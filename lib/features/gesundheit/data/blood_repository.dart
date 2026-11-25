import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../../core/db/app_database.dart';
import '../../../core/time/local_date.dart';
import '../domain/blood.dart';

/// Blutbilder eines Pferdes.
class BloodRepository {
  BloodRepository(this._db, {Uuid? uuid, DateTime Function()? clock})
    : _uuid = uuid ?? const Uuid(),
      _clock = clock ?? DateTime.now;

  final AppDatabase _db;
  final Uuid _uuid;
  final DateTime Function() _clock;

  /// Alle Blutbilder (neueste zuerst) inkl. Werte.
  Stream<List<BloodTest>> watchTests(String horseId) => _db
      .customSelect(
        'SELECT COUNT(*) AS n FROM blood_tests',
        readsFrom: {_db.bloodTests, _db.bloodValues},
      )
      .watch()
      .asyncMap((_) => getTests(horseId));

  Future<List<BloodTest>> getTests(String horseId) async {
    final tests =
        await (_db.select(_db.bloodTests)
              ..where((t) => t.horseId.equals(horseId))
              ..orderBy([
                (t) =>
                    OrderingTerm(expression: t.date, mode: OrderingMode.desc),
                (t) => OrderingTerm(
                  expression: t.createdAt,
                  mode: OrderingMode.desc,
                ),
              ]))
            .get();
    if (tests.isEmpty) return const [];
    final values = await (_db.select(
      _db.bloodValues,
    )..where((v) => v.testId.isIn(tests.map((t) => t.id)))).get();
    return [for (final t in tests) _toTest(t, values)];
  }

  Future<BloodTest?> getTest(String id) async {
    final t = await (_db.select(
      _db.bloodTests,
    )..where((t) => t.id.equals(id))).getSingleOrNull();
    if (t == null) return null;
    final values = await (_db.select(
      _db.bloodValues,
    )..where((v) => v.testId.equals(id))).get();
    return _toTest(t, values);
  }

  /// Speichert ein Blutbild; die Werte werden komplett ersetzt.
  Future<String> saveTest(BloodTest test) => _db.transaction(() async {
    final id = test.id.isEmpty ? _uuid.v4() : test.id;
    await _db
        .into(_db.bloodTests)
        .insertOnConflictUpdate(
          BloodTestsCompanion.insert(
            id: id,
            horseId: test.horseId,
            date: test.date,
            lab: Value(_clean(test.lab)),
            notes: Value(_clean(test.notes)),
            updatedAt: Value(_clock()),
          ),
        );
    await (_db.delete(_db.bloodValues)..where((v) => v.testId.equals(id))).go();
    for (final v in test.values) {
      await _db
          .into(_db.bloodValues)
          .insert(
            BloodValuesCompanion.insert(
              testId: id,
              paramKey: v.paramKey,
              value: v.value,
              refLow: Value(v.refLow),
              refHigh: Value(v.refHigh),
            ),
            mode: InsertMode.insertOrReplace,
          );
    }
    return id;
  });

  Future<void> deleteTest(String id) =>
      (_db.delete(_db.bloodTests)..where((t) => t.id.equals(id))).go();

  static String? _clean(String? v) {
    final t = v?.trim();
    return (t == null || t.isEmpty) ? null : t;
  }

  BloodTest _toTest(BloodTestRow t, List<BloodValueRow> values) => BloodTest(
    id: t.id,
    horseId: t.horseId,
    date: t.date,
    lab: t.lab,
    notes: t.notes,
    values: [
      for (final v in values)
        if (v.testId == t.id)
          BloodValue(
            paramKey: v.paramKey,
            value: v.value,
            refLow: v.refLow,
            refHigh: v.refHigh,
          ),
    ],
  );
}

/// Startdatum/Ende für einen Zusatz von [weeks] Wochen ab [from].
(LocalDate, LocalDate) supplementRange(LocalDate from, int weeks) =>
    (from, from.addWeeks(weeks).addDays(-1));
