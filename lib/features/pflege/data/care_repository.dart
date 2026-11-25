import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../../core/db/app_database.dart';
import '../../../core/time/local_date.dart';
import '../domain/care_event.dart';
import '../domain/care_logic.dart';
import '../domain/care_type.dart';
import '../domain/interval_defaults.dart';
import '../domain/repeat_interval.dart';

/// Offener Pflegetermin mit Erinnerungen – Eingabe für den Erinnerungs-Abgleich.
class ReminderCandidate {
  const ReminderCandidate({
    required this.event,
    required this.horseName,
    required this.typeName,
  });

  final CareEvent event;
  final String horseName;
  final String typeName;
}

/// Pferd mit eingeschalteter Geburtstagserinnerung.
class BirthdayCandidate {
  const BirthdayCandidate({
    required this.horseId,
    required this.horseName,
    required this.birthDate,
  });

  final String horseId;
  final String horseName;
  final LocalDate birthDate;
}

class CareRepository {
  CareRepository(this._db, {Uuid? uuid}) : _uuid = uuid ?? const Uuid();

  final AppDatabase _db;
  final Uuid _uuid;

  // ------------------------------------------------------------ Eintragsarten

  Stream<List<CareType>> watchTypes({bool includeArchived = false}) {
    final q = _db.select(_db.careEventTypes)
      ..orderBy([
        (t) => OrderingTerm(expression: t.sortOrder),
        (t) => OrderingTerm(expression: t.name.collate(Collate.noCase)),
      ]);
    if (!includeArchived) q.where((t) => t.archived.equals(false));
    return q.watch().map((rows) => rows.map(_toType).toList());
  }

  /// Legt eine eigene Art an (leere [CareType.id]) oder ändert eine vorhandene.
  /// Bei eingebauten Arten bleiben Formular-Art und Icon-Schlüssel fest.
  Future<String> saveType(CareType type) async {
    if (type.id.isEmpty) {
      final id = _uuid.v4();
      final maxOrder =
          await (_db.selectOnly(_db.careEventTypes)
                ..addColumns([_db.careEventTypes.sortOrder.max()]))
              .map((r) => r.read(_db.careEventTypes.sortOrder.max()))
              .getSingle();
      await _db
          .into(_db.careEventTypes)
          .insert(
            CareEventTypesCompanion.insert(
              id: id,
              name: type.name.trim(),
              kind: CareKind.allgemein.key,
              color: type.colorValue,
              icon: type.iconKey,
              sortOrder: Value((maxOrder ?? 0) + 1),
            ),
          );
      return id;
    }
    await (_db.update(
      _db.careEventTypes,
    )..where((t) => t.id.equals(type.id))).write(
      CareEventTypesCompanion(
        name: Value(type.name.trim()),
        color: Value(type.colorValue),
        icon: type.builtin ? const Value.absent() : Value(type.iconKey),
        updatedAt: Value(DateTime.now()),
      ),
    );
    return type.id;
  }

  /// Archivierte Arten erscheinen nicht mehr beim Anlegen, alte Einträge
  /// bleiben aber sichtbar.
  Future<void> setTypeArchived(String id, {required bool archived}) =>
      (_db.update(_db.careEventTypes)..where((t) => t.id.equals(id))).write(
        CareEventTypesCompanion(
          archived: Value(archived),
          updatedAt: Value(DateTime.now()),
        ),
      );

  // ------------------------------------------------------- Standard-Intervalle

  /// Nur Einträge mit Wert > 0 (0 = vom Nutzer entfernter Vorschlag).
  Stream<List<IntervalDefault>> watchIntervalDefaults() => _db
      .select(_db.careIntervalDefaults)
      .watch()
      .map(
        (rows) => [
          for (final r in rows)
            if (RepeatInterval.tryCreate(r.value, r.unit) case final interval?)
              IntervalDefault(
                typeId: r.typeId,
                variantKey: r.variantKey.isEmpty ? null : r.variantKey,
                interval: interval,
              ),
        ],
      );

  /// Setzt oder entfernt ([interval] == null) einen Vorschlag.
  Future<void> setIntervalDefault(
    String typeId,
    String? variantKey,
    RepeatInterval? interval,
  ) => _db
      .into(_db.careIntervalDefaults)
      .insertOnConflictUpdate(
        CareIntervalDefaultsCompanion.insert(
          typeId: typeId,
          variantKey: Value(variantKey ?? ''),
          value: interval?.value ?? 0,
          unit: (interval?.unit ?? IntervalUnit.weeks).key,
          updatedAt: Value(DateTime.now()),
        ),
      );

  // ------------------------------------------------------------- Einträge

  static const _offsetsColumn = 'reminder_offsets';

  Selectable<CareEvent> _eventsQuery(String where, List<Variable> vars) => _db
      .customSelect(
        'SELECT e.*, (SELECT group_concat(r.offset_days) '
        'FROM care_reminders r WHERE r.event_id = e.id) '
        'AS $_offsetsColumn FROM care_events e WHERE $where',
        variables: vars,
        readsFrom: {_db.careEvents, _db.careReminders},
      )
      .map((row) {
        final r = _db.careEvents.map(row.data);
        final offsets = row.readNullable<String>(_offsetsColumn);
        return _toEvent(r, offsets);
      });

  /// Alle Einträge eines Pferdes (für Kalender, Anstehend, Historie).
  Stream<List<CareEvent>> watchEvents(String horseId) => _eventsQuery(
    'e.horse_id = ? ORDER BY e.date, e.time_minutes',
    [Variable.withString(horseId)],
  ).watch();

  Future<CareEvent?> getEvent(String id) =>
      _eventsQuery('e.id = ?', [Variable.withString(id)]).getSingleOrNull();

  /// Der (neueste) Folgetermin, der aus [eventId] entstanden ist.
  Future<CareEvent?> getFollowUp(String eventId) => _eventsQuery(
    'e.parent_event_id = ? ORDER BY e.date DESC LIMIT 1',
    [Variable.withString(eventId)],
  ).getSingleOrNull();

  /// Speichert [event] (neu, wenn [CareEvent.id] leer ist) samt Erinnerungen
  /// und gleicht den Folgetermin ab (siehe `planFollowUp`).
  /// Gibt die ID zurück.
  Future<String> saveEvent(
    CareEvent event, {
    bool recalculateFollowUp = false,
  }) => _db.transaction(() async {
    final isNew = event.id.isEmpty;
    final id = isNew ? _uuid.v4() : event.id;
    var e = event.copyWith(id: id);
    if (e.repeat != null && e.seriesId == null) e = e.copyWith(seriesId: id);
    await _db.into(_db.careEvents).insertOnConflictUpdate(_toCompanion(e));
    await _replaceReminders(id, e.reminderOffsets);

    final existing = isNew ? null : await getFollowUp(id);
    switch (planFollowUp(e, existing, recalculate: recalculateFollowUp)) {
      case FollowUpNone():
        break;
      case FollowUpCreate(:final date):
        final followUp = buildFollowUp(e, date, _uuid.v4());
        await _db.into(_db.careEvents).insert(_toCompanion(followUp));
        await _replaceReminders(followUp.id, followUp.reminderOffsets);
      case FollowUpMove(:final followUpId, :final date):
        await (_db.update(
          _db.careEvents,
        )..where((t) => t.id.equals(followUpId))).write(
          CareEventsCompanion(
            date: Value(date),
            updatedAt: Value(DateTime.now()),
          ),
        );
      case FollowUpDelete(:final followUpId):
        await (_db.delete(
          _db.careEvents,
        )..where((t) => t.id.equals(followUpId))).go();
    }
    return id;
  });

  /// Markiert als erledigt am tatsächlichen Datum [actualDate].
  Future<void> markDone(
    String id,
    LocalDate actualDate, {
    required bool recalculateFollowUp,
  }) async {
    final e = await getEvent(id);
    if (e == null) return;
    await saveEvent(
      e.copyWith(done: true, date: actualDate),
      recalculateFollowUp: recalculateFollowUp,
    );
  }

  Future<void> markOpen(String id) =>
      (_db.update(_db.careEvents)..where((t) => t.id.equals(id))).write(
        CareEventsCompanion(
          done: const Value(false),
          updatedAt: Value(DateTime.now()),
        ),
      );

  /// Löscht einen Eintrag. Mit [deleteOpenFollowUp] auch dessen noch offenen
  /// Folgetermin; ein erledigter Folgetermin bleibt immer erhalten.
  Future<void> deleteEvent(String id, {bool deleteOpenFollowUp = false}) =>
      _db.transaction(() async {
        if (deleteOpenFollowUp) {
          final f = await getFollowUp(id);
          if (f != null && !f.done) {
            await (_db.delete(
              _db.careEvents,
            )..where((t) => t.id.equals(f.id))).go();
          }
        }
        await (_db.delete(_db.careEvents)..where((t) => t.id.equals(id))).go();
      });

  Future<void> _replaceReminders(String eventId, List<int> offsets) async {
    await (_db.delete(
      _db.careReminders,
    )..where((r) => r.eventId.equals(eventId))).go();
    for (final o in normalizeOffsets(offsets)) {
      await _db
          .into(_db.careReminders)
          .insert(
            CareRemindersCompanion.insert(eventId: eventId, offsetDays: o),
          );
    }
  }

  // ------------------------------------------------------------- Vorschläge

  /// Bisherige Werte (neueste zuerst) für Autovervollständigung – über alle
  /// Pferde, da Hufschmied/Tierarzt oft dieselben sind.
  /// [field] ist `person` oder ein Schlüssel aus [CareFields].
  Future<List<String>> suggestions(String field, {String? typeId}) async {
    final q = _db.select(_db.careEvents)
      ..orderBy([
        (t) => OrderingTerm(expression: t.date, mode: OrderingMode.desc),
      ])
      ..limit(300);
    if (typeId != null) q.where((t) => t.typeId.equals(typeId));
    final rows = await q.get();
    return distinctSuggestions(
      rows.map(
        (r) => field == 'person'
            ? r.person
            : _decodeFields(r.fields)[field]?.toString(),
      ),
    );
  }

  // ------------------------------------------------------------- Erinnerungen

  /// Offene Einträge mit Erinnerungen aktiver Pferde (für den Abgleich).
  Stream<List<ReminderCandidate>> watchReminderCandidates() {
    final query = _db.customSelect(
      'SELECT e.*, h.name AS horse_name, h.call_name AS horse_call_name, '
      't.name AS type_name, '
      '(SELECT group_concat(r.offset_days) FROM care_reminders r '
      'WHERE r.event_id = e.id) AS $_offsetsColumn '
      'FROM care_events e '
      'JOIN horses h ON h.id = e.horse_id '
      'JOIN care_event_types t ON t.id = e.type_id '
      'WHERE e.done = 0 AND h.archived_at IS NULL '
      'AND EXISTS (SELECT 1 FROM care_reminders r WHERE r.event_id = e.id)',
      readsFrom: {
        _db.careEvents,
        _db.careReminders,
        _db.horses,
        _db.careEventTypes,
      },
    );
    return query.watch().map(
      (rows) => [
        for (final row in rows)
          ReminderCandidate(
            event: _toEvent(
              _db.careEvents.map(row.data),
              row.readNullable<String>(_offsetsColumn),
            ),
            horseName: _displayName(
              row.read<String>('horse_name'),
              row.readNullable<String>('horse_call_name'),
            ),
            typeName: row.read<String>('type_name'),
          ),
      ],
    );
  }

  Stream<List<BirthdayCandidate>> watchBirthdayCandidates() =>
      (_db.select(_db.horses)..where(
            (h) =>
                h.archivedAt.isNull() &
                h.birthdayReminder.equals(true) &
                h.birthDate.isNotNull(),
          ))
          .watch()
          .map(
            (rows) => [
              for (final h in rows)
                BirthdayCandidate(
                  horseId: h.id,
                  horseName: _displayName(h.name, h.callName),
                  birthDate: h.birthDate!,
                ),
            ],
          );

  /// Schaltet die Geburtstagserinnerung eines Pferdes.
  Future<void> setBirthdayReminder(String horseId, {required bool enabled}) =>
      (_db.update(_db.horses)..where((h) => h.id.equals(horseId))).write(
        HorsesCompanion(
          birthdayReminder: Value(enabled),
          updatedAt: Value(DateTime.now()),
        ),
      );

  // ------------------------------------------------------------- Mapping

  static String _displayName(String name, String? callName) =>
      (callName != null && callName.trim().isNotEmpty) ? callName : name;

  static String? _clean(String? v) {
    final t = v?.trim();
    return (t == null || t.isEmpty) ? null : t;
  }

  static Map<String, Object> _decodeFields(String json) {
    try {
      final decoded = jsonDecode(json);
      if (decoded is! Map) return const {};
      return {
        for (final MapEntry(:key, :value) in decoded.entries)
          if (key is String &&
              (value is String || value is num || value is bool))
            key: value is num ? value.toInt() : value as Object,
      };
    } on FormatException {
      return const {};
    }
  }

  static String _encodeFields(Map<String, Object> fields) => jsonEncode({
    for (final MapEntry(:key, :value) in fields.entries)
      if (value is! String || value.trim().isNotEmpty)
        key: value is String ? value.trim() : value,
  });

  CareType _toType(CareTypeRow r) => CareType(
    id: r.id,
    name: r.name,
    kind: CareKind.fromKey(r.kind),
    colorValue: r.color,
    iconKey: r.icon,
    builtin: r.builtin,
    archived: r.archived,
    sortOrder: r.sortOrder,
  );

  CareEvent _toEvent(CareEventRow r, String? offsets) => CareEvent(
    id: r.id,
    horseId: r.horseId,
    typeId: r.typeId,
    date: r.date,
    timeMinutes: r.timeMinutes,
    done: r.done,
    variantKey: r.variantKey,
    title: r.title,
    person: r.person,
    costCents: r.costCents,
    notes: r.notes,
    fields: _decodeFields(r.fields),
    repeat: RepeatInterval.tryCreate(r.repeatValue, r.repeatUnit),
    parentEventId: r.parentEventId,
    seriesId: r.seriesId,
    reminderOffsets: normalizeOffsets(
      (offsets ?? '').split(',').map((s) => int.tryParse(s)).whereType<int>(),
    ),
  );

  CareEventsCompanion _toCompanion(CareEvent e) => CareEventsCompanion.insert(
    id: e.id,
    horseId: e.horseId,
    typeId: e.typeId,
    date: e.date,
    timeMinutes: Value(e.timeMinutes),
    done: Value(e.done),
    variantKey: Value(_clean(e.variantKey)),
    title: Value(_clean(e.title)),
    person: Value(_clean(e.person)),
    costCents: Value(e.costCents),
    notes: Value(_clean(e.notes)),
    fields: Value(_encodeFields(e.fields)),
    repeatValue: Value(e.repeat?.value),
    repeatUnit: Value(e.repeat?.unit.key),
    parentEventId: Value(e.parentEventId),
    seriesId: Value(e.seriesId),
    updatedAt: Value(DateTime.now()),
  );
}
