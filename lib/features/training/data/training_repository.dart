import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../../core/db/app_database.dart';
import '../../../core/time/local_date.dart';
import '../../dienstplan/domain/shift_logic.dart';
import '../domain/training.dart';
import '../domain/training_generator.dart';

/// Trainingspläne und -einheiten.
class TrainingRepository {
  TrainingRepository(this._db, {Uuid? uuid, DateTime Function()? clock})
    : _uuid = uuid ?? const Uuid(),
      _clock = clock ?? DateTime.now;

  final AppDatabase _db;
  final Uuid _uuid;
  final DateTime Function() _clock;

  // ---------------------------------------------------------------- Einheiten

  Stream<List<TrainingSession>> watchSessions(String horseId) =>
      (_db.select(_db.trainingSessions)
            ..where((s) => s.horseId.equals(horseId))
            ..orderBy([
              (s) => OrderingTerm(expression: s.date),
              (s) => OrderingTerm(expression: s.createdAt),
            ]))
          .watch()
          .map((rows) => rows.map(_toSession).toList());

  Future<List<TrainingSession>> getSessions(String horseId) =>
      (_db.select(_db.trainingSessions)
            ..where((s) => s.horseId.equals(horseId))
            ..orderBy([(s) => OrderingTerm(expression: s.date)]))
          .get()
          .then((rows) => rows.map(_toSession).toList());

  Future<TrainingSession?> getSession(String id) async {
    final row = await (_db.select(
      _db.trainingSessions,
    )..where((s) => s.id.equals(id))).getSingleOrNull();
    return row == null ? null : _toSession(row);
  }

  /// Neu (leere ID) oder ändern. Gibt die ID zurück.
  Future<String> saveSession(TrainingSession s) async {
    final id = s.id.isEmpty ? _uuid.v4() : s.id;
    await _db
        .into(_db.trainingSessions)
        .insertOnConflictUpdate(_toCompanion(s.copyWith(id: id)));
    return id;
  }

  /// Verschieben: neues Datum, danach fixiert (bleibt beim Neu-Verteilen).
  Future<void> moveSession(String id, LocalDate date) =>
      (_db.update(_db.trainingSessions)..where((s) => s.id.equals(id))).write(
        TrainingSessionsCompanion(
          date: Value(date),
          pinned: const Value(true),
          updatedAt: Value(_clock()),
        ),
      );

  /// Kopie an [date] (geplant, ohne Bewertung, fixiert, ohne Plan-Bezug).
  Future<String> copySession(String id, LocalDate date) async {
    final s = await getSession(id);
    if (s == null) return '';
    return saveSession(
      TrainingSession(
        id: '',
        horseId: s.horseId,
        date: date,
        level: s.level,
        durationMinutes: s.durationMinutes,
        title: s.title,
        unitKey: s.unitKey,
        form: s.form,
        content: s.content,
        notes: s.notes,
        pinned: true,
      ),
    );
  }

  Future<void> deleteSession(String id) =>
      (_db.delete(_db.trainingSessions)..where((s) => s.id.equals(id))).go();

  // ---------------------------------------------------------------- Pläne

  Stream<TrainingPlan?> watchActivePlan(String horseId) =>
      (_db.select(_db.trainingPlans)
            ..where(
              (p) => p.horseId.equals(horseId) & p.status.equals('active'),
            )
            ..orderBy([
              (p) => OrderingTerm(
                expression: p.createdAt,
                mode: OrderingMode.desc,
              ),
            ])
            ..limit(1))
          .watchSingleOrNull()
          .map((r) => r == null ? null : _toPlan(r));

  /// Übernimmt einen generierten Plan. Ein bisher aktiver Plan des Pferdes
  /// wird archiviert; seine künftigen, offenen, nicht fixierten Einheiten
  /// ab [today] werden entfernt (erledigte bleiben).
  Future<String> savePlan({
    required String horseId,
    required TrainingParams params,
    required List<GeneratedSession> sessions,
    required LocalDate today,
  }) => _db.transaction(() async {
    final old =
        await (_db.select(_db.trainingPlans)..where(
              (p) => p.horseId.equals(horseId) & p.status.equals('active'),
            ))
            .get();
    for (final p in old) {
      await _removeOpenFuture(p.id, today);
      await (_db.update(
        _db.trainingPlans,
      )..where((t) => t.id.equals(p.id))).write(
        TrainingPlansCompanion(
          status: const Value('archived'),
          updatedAt: Value(_clock()),
        ),
      );
    }
    final id = _uuid.v4();
    await _db
        .into(_db.trainingPlans)
        .insert(
          TrainingPlansCompanion.insert(
            id: id,
            horseId: horseId,
            goal: params.goal.key,
            params: jsonEncode(params.toJson()),
            startDate: params.startDate,
            weeks: params.weeks,
            distributedAt: Value(_clock()),
          ),
        );
    await _insertGenerated(id, horseId, sessions);
    return id;
  });

  /// Beendet einen Plan: künftige offene Einheiten ab [today] entfallen,
  /// erledigte und fixierte bleiben (ohne Plan-Bezug).
  Future<void> endPlan(String planId, LocalDate today) =>
      _db.transaction(() async {
        await _removeOpenFuture(planId, today);
        await (_db.update(
          _db.trainingPlans,
        )..where((p) => p.id.equals(planId))).write(
          TrainingPlansCompanion(
            status: const Value('archived'),
            updatedAt: Value(_clock()),
          ),
        );
      });

  /// Regel 6: verteilt nur künftige, offene, nicht fixierte Einheiten ab
  /// [today] neu. Erledigte, ausgefallene, fixierte und manuelle Einheiten
  /// bleiben und werden vom Generator berücksichtigt.
  Future<GeneratedPlan> redistribute({
    required TrainingPlan plan,
    required TrainingGenerator generator,
    required Map<LocalDate, DayAvailability> availability,
    required LocalDate today,
  }) => _db.transaction(() async {
    await _removeOpenFuture(plan.id, today);
    final remaining = await getSessions(plan.horseId);
    final fixed = [
      for (final s in remaining)
        if (s.status != SessionStatus.cancelled)
          FixedSession(
            date: s.date,
            level: s.level,
            form: s.form,
            minutes: s.durationMinutes,
          ),
    ];
    final result = generator.generate(
      params: plan.params,
      availability: availability,
      fixed: fixed,
      from: today,
    );
    await _insertGenerated(plan.id, plan.horseId, result.sessions);
    await (_db.update(
      _db.trainingPlans,
    )..where((p) => p.id.equals(plan.id))).write(
      TrainingPlansCompanion(
        distributedAt: Value(_clock()),
        updatedAt: Value(_clock()),
      ),
    );
    return result;
  });

  Future<void> _removeOpenFuture(String planId, LocalDate today) =>
      (_db.delete(_db.trainingSessions)..where(
            (s) =>
                s.planId.equals(planId) &
                s.status.equals(SessionStatus.planned.key) &
                s.pinned.equals(false) &
                s.date.isBiggerOrEqualValue(today.toIso()),
          ))
          .go();

  Future<void> _insertGenerated(
    String planId,
    String horseId,
    List<GeneratedSession> sessions,
  ) => _db.batch((b) {
    for (final g in sessions) {
      b.insert(
        _db.trainingSessions,
        _toCompanion(
          TrainingSession(
            id: _uuid.v4(),
            planId: planId,
            horseId: horseId,
            date: g.date,
            level: g.level,
            durationMinutes: g.minutes,
            title: g.unit.name,
            unitKey: g.unit.key,
            form: g.unit.form,
            content: g.content,
            reason: g.reason,
          ),
        ),
      );
    }
  });

  // ---------------------------------------------------------------- Mapping

  static String? _clean(String? v) {
    final t = v?.trim();
    return (t == null || t.isEmpty) ? null : t;
  }

  static Object? _decode(String? json) {
    if (json == null) return null;
    try {
      return jsonDecode(json);
    } on FormatException {
      return null;
    }
  }

  TrainingPlan _toPlan(TrainingPlanRow r) => TrainingPlan(
    id: r.id,
    horseId: r.horseId,
    params: TrainingParams.fromJson(
      (_decode(r.params) as Map? ?? const {}).cast<String, Object?>(),
    ),
    active: r.status == 'active',
    distributedAt: r.distributedAt,
  );

  TrainingSession _toSession(TrainingSessionRow r) => TrainingSession(
    id: r.id,
    planId: r.planId,
    horseId: r.horseId,
    date: r.date,
    level: r.level,
    durationMinutes: r.durationMinutes,
    title: r.title,
    unitKey: r.templateKey,
    form: r.form,
    content: SessionContent.fromJson(_decode(r.content)),
    status: SessionStatus.fromKey(r.status),
    rating: r.rating,
    notes: r.notes,
    pinned: r.pinned,
    reason: SessionReason.fromJson(_decode(r.reason)),
  );

  TrainingSessionsCompanion _toCompanion(TrainingSession s) =>
      TrainingSessionsCompanion.insert(
        id: s.id,
        planId: Value(s.planId),
        horseId: s.horseId,
        date: s.date,
        templateKey: Value(s.unitKey),
        form: Value(s.form),
        title: s.title.trim(),
        level: s.level.clamp(0, 5),
        durationMinutes: s.durationMinutes,
        content: Value(jsonEncode(s.content.toJson())),
        status: Value(s.status.key),
        rating: Value(s.rating),
        notes: Value(_clean(s.notes)),
        pinned: Value(s.pinned),
        reason: Value(s.reason == null ? null : jsonEncode(s.reason!.toJson())),
        updatedAt: Value(_clock()),
      );
}
