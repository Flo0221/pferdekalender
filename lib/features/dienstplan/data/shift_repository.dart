import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../../core/db/app_database.dart';
import '../../../core/time/local_date.dart';
import '../../einstellungen/domain/setting_keys.dart';
import '../domain/shift.dart';
import '../domain/shift_logic.dart';

/// Dienstplan: Vorlagen, Tage, Rhythmen. Gehört zur Person, nicht zum Pferd.
class ShiftRepository {
  ShiftRepository(this._db, {Uuid? uuid, DateTime Function()? clock})
    : _uuid = uuid ?? const Uuid(),
      _clock = clock ?? DateTime.now;

  final AppDatabase _db;
  final Uuid _uuid;
  final DateTime Function() _clock;

  // ---------------------------------------------------------------- Vorlagen

  Stream<List<ShiftTemplate>> watchTemplates({bool includeArchived = false}) {
    final q = _db.select(_db.shiftTemplates)
      ..orderBy([
        (t) => OrderingTerm(expression: t.sortOrder),
        (t) => OrderingTerm(expression: t.name.collate(Collate.noCase)),
      ]);
    if (!includeArchived) q.where((t) => t.archived.equals(false));
    return q.watch().map((rows) => rows.map(_toTemplate).toList());
  }

  /// Alle Schichten inkl. ausgeblendeter als Map (einmalige Abfrage).
  Future<Map<String, ShiftTemplate>> getTemplateMap() async {
    final rows = await _db.select(_db.shiftTemplates).get();
    return {for (final r in rows) r.id: _toTemplate(r)};
  }

  /// Neu (leere ID) oder ändern. Gibt die ID zurück.
  Future<String> saveTemplate(ShiftTemplate t) async {
    final isNew = t.id.isEmpty;
    final id = isNew ? _uuid.v4() : t.id;
    var sortOrder = t.sortOrder;
    if (isNew) {
      final max =
          await (_db.selectOnly(_db.shiftTemplates)
                ..addColumns([_db.shiftTemplates.sortOrder.max()]))
              .map((r) => r.read(_db.shiftTemplates.sortOrder.max()))
              .getSingle();
      sortOrder = (max ?? -1) + 1;
    }
    await _db
        .into(_db.shiftTemplates)
        .insertOnConflictUpdate(
          ShiftTemplatesCompanion.insert(
            id: id,
            name: t.name.trim(),
            shortCode: t.shortCode.trim(),
            color: t.colorValue,
            startMinutes: Value(t.startMinutes),
            endMinutes: Value(t.endMinutes),
            stableMinutes: t.stableMinutes,
            preferredTime: Value(t.preferredTime?.key),
            isNight: Value(t.isNight),
            archived: Value(t.archived),
            sortOrder: Value(sortOrder),
            updatedAt: Value(_clock()),
          ),
        );
    await _touch();
    return id;
  }

  /// Legt die Startvorlagen (Früh, Spät, Nacht, Frei, Urlaub) an.
  Future<void> createDefaultTemplates() => _db.transaction(() async {
    for (final t in defaultShiftTemplates) {
      await saveTemplate(t);
    }
  });

  /// Wird die Vorlage noch an Tagen verwendet, wird sie nur ausgeblendet
  /// (die Tage behalten ihre Schicht). Sonst wird sie gelöscht.
  /// Gibt `true` zurück, wenn gelöscht (nicht nur ausgeblendet) wurde.
  Future<bool> removeTemplate(String id) => _db.transaction(() async {
    final used =
        await (_db.selectOnly(_db.shiftDays)
              ..addColumns([_db.shiftDays.date.count()])
              ..where(_db.shiftDays.templateId.equals(id)))
            .map((r) => r.read(_db.shiftDays.date.count()))
            .getSingle();
    if ((used ?? 0) > 0) {
      await (_db.update(
        _db.shiftTemplates,
      )..where((t) => t.id.equals(id))).write(
        ShiftTemplatesCompanion(
          archived: const Value(true),
          updatedAt: Value(_clock()),
        ),
      );
      return false;
    }
    await (_db.delete(_db.shiftTemplates)..where((t) => t.id.equals(id))).go();
    return true;
  });

  // ---------------------------------------------------------------- Tage

  /// Alle Tage im Zeitraum (einschließlich) als Map.
  Stream<Map<LocalDate, ShiftDay>> watchDays(LocalDate from, LocalDate to) =>
      (_db.select(_db.shiftDays)
            ..where((d) => d.date.isBetweenValues(from.toIso(), to.toIso())))
          .watch()
          .map((rows) => {for (final r in rows) r.date: _toDay(r)});

  Future<Map<LocalDate, ShiftDay>> getDays(LocalDate from, LocalDate to) async {
    final rows = await (_db.select(
      _db.shiftDays,
    )..where((d) => d.date.isBetweenValues(from.toIso(), to.toIso()))).get();
    return {for (final r in rows) r.date: _toDay(r)};
  }

  /// Schnell-Eintragen: Schicht setzen ([templateId] `null` = entfernen).
  /// Eigene Stallzeit, Beisteller und Notiz des Tages bleiben erhalten.
  Future<void> setShift(LocalDate date, String? templateId) async {
    final old = (await getDays(date, date))[date] ?? ShiftDay(date: date);
    await saveDay(
      old.copyWith(
        templateId: templateId,
        clearTemplate: templateId == null,
        source: ShiftSource.manual,
      ),
    );
  }

  /// Speichert einen Tag; ein leerer Tag wird gelöscht.
  Future<void> saveDay(ShiftDay day) async {
    if (day.isEmpty) {
      await (_db.delete(
        _db.shiftDays,
      )..where((d) => d.date.equalsValue(day.date))).go();
    } else {
      await _db.into(_db.shiftDays).insertOnConflictUpdate(_toCompanion(day));
    }
    await _touch();
  }

  // ---------------------------------------------------------------- Rhythmen

  Stream<List<ShiftPattern>> watchPatterns() =>
      (_db.select(_db.shiftPatterns)..orderBy([
            (p) =>
                OrderingTerm(expression: p.startDate, mode: OrderingMode.desc),
          ]))
          .watch()
          .map((rows) => rows.map(_toPattern).toList());

  /// Speichert den Rhythmus und rollt ihn aus. Gibt das Ergebnis zurück
  /// (inkl. übersprungener, manuell geänderter Tage).
  Future<RolloutResult> applyPattern(
    ShiftPattern pattern, {
    bool overwriteManual = false,
  }) => _db.transaction(() async {
    final id = pattern.id.isEmpty ? _uuid.v4() : pattern.id;
    final p = ShiftPattern(
      id: id,
      name: pattern.name.trim(),
      steps: pattern.steps,
      startDate: pattern.startDate,
      weeks: pattern.weeks,
    );
    await _db
        .into(_db.shiftPatterns)
        .insertOnConflictUpdate(
          ShiftPatternsCompanion.insert(
            id: id,
            name: p.name,
            steps: jsonEncode(p.steps),
            startDate: p.startDate,
            weeks: p.weeks,
            updatedAt: Value(_clock()),
          ),
        );
    // Beim erneuten Ausrollen: eigene Tage außerhalb des neuen Zeitraums
    // entfernen (manuell geänderte bleiben).
    await (_db.delete(_db.shiftDays)..where(
          (d) =>
              d.patternId.equals(id) &
              d.source.equals(ShiftSource.pattern.key) &
              (d.date.isSmallerThanValue(p.startDate.toIso()) |
                  d.date.isBiggerThanValue(p.endDate.toIso())),
        ))
        .go();
    final existing = await getDays(p.startDate, p.endDate);
    final result = rolloutPattern(
      p,
      existing,
      overwriteManual: overwriteManual,
    );
    await _db.batch((b) {
      for (final d in result.days) {
        if (d.isEmpty) {
          b.deleteWhere(_db.shiftDays, (t) => t.date.equalsValue(d.date));
        } else {
          b.insert(
            _db.shiftDays,
            _toCompanion(d),
            mode: InsertMode.insertOrReplace,
          );
        }
      }
    });
    await _touch();
    return result;
  });

  /// Löscht den Rhythmus. Mit [removeDays] werden auch die von ihm gesetzten
  /// Tage ab [from] entfernt (manuell geänderte bleiben).
  Future<void> deletePattern(
    String id, {
    bool removeDays = false,
    LocalDate? from,
  }) => _db.transaction(() async {
    if (removeDays) {
      await (_db.delete(_db.shiftDays)..where(
            (d) =>
                d.patternId.equals(id) &
                d.source.equals(ShiftSource.pattern.key) &
                (from == null
                    ? const Constant(true)
                    : d.date.isBiggerOrEqualValue(from.toIso())),
          ))
          .go();
    }
    await (_db.delete(_db.shiftPatterns)..where((p) => p.id.equals(id))).go();
    await _touch();
  });

  /// Merkt sich die letzte Änderung (für „Plan neu verteilen?“ im Training).
  Future<void> _touch() => _db
      .into(_db.settings)
      .insertOnConflictUpdate(
        SettingsCompanion.insert(
          key: SettingKeys.shiftChangedAt,
          value: _clock().toUtc().toIso8601String(),
          updatedAt: Value(_clock()),
        ),
      );

  // ---------------------------------------------------------------- Mapping

  static String? _clean(String? v) {
    final t = v?.trim();
    return (t == null || t.isEmpty) ? null : t;
  }

  ShiftTemplate _toTemplate(ShiftTemplateRow r) => ShiftTemplate(
    id: r.id,
    name: r.name,
    shortCode: r.shortCode,
    colorValue: r.color,
    startMinutes: r.startMinutes,
    endMinutes: r.endMinutes,
    stableMinutes: r.stableMinutes,
    preferredTime: DayTime.fromKey(r.preferredTime),
    isNight: r.isNight,
    archived: r.archived,
    sortOrder: r.sortOrder,
  );

  ShiftDay _toDay(ShiftDayRow r) => ShiftDay(
    date: r.date,
    templateId: r.templateId,
    overrideMinutes: r.overrideMinutes,
    otherPersonCovers: r.otherPersonCovers,
    note: r.note,
    source: ShiftSource.fromKey(r.source),
    patternId: r.patternId,
  );

  ShiftDaysCompanion _toCompanion(ShiftDay d) => ShiftDaysCompanion.insert(
    date: d.date,
    templateId: Value(d.templateId),
    overrideMinutes: Value(d.overrideMinutes),
    otherPersonCovers: Value(d.otherPersonCovers),
    note: Value(_clean(d.note)),
    source: Value(d.source.key),
    patternId: Value(d.patternId),
    updatedAt: Value(_clock()),
  );

  ShiftPattern _toPattern(ShiftPatternRow r) {
    List<String?> steps;
    try {
      steps = [
        for (final s in jsonDecode(r.steps) as List<Object?>)
          s is String ? s : null,
      ];
    } on FormatException {
      steps = const [];
    }
    return ShiftPattern(
      id: r.id,
      name: r.name,
      steps: steps,
      startDate: r.startDate,
      weeks: r.weeks,
    );
  }
}
