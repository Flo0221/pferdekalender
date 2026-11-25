import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:drift_dev/api/migrations_native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pferdekalender/core/db/app_database.dart';

import 'generated/schema.dart';
import 'generated/schema_v1.dart' as v1;
import 'generated/schema_v2.dart' as v2;
import 'generated/schema_v3.dart' as v3;
import 'generated/schema_v4.dart' as v4;
import 'generated/schema_v5.dart' as v5;
import 'generated/schema_v6.dart' as v6;
import 'generated/schema_v7.dart' as v7;

/// Prüft jede Schema-Migration gegen die gespeicherten Snapshots in
/// drift_schemas/. Bei jeder neuen Version hier einen Datenerhalt-Test ergänzen.
void main() {
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
  late SchemaVerifier verifier;

  setUpAll(() => verifier = SchemaVerifier(GeneratedHelper()));

  group('Schema-Migrationen', () {
    const versions = GeneratedHelper.versions;
    for (final (i, fromVersion) in versions.indexed) {
      for (final toVersion in versions.skip(i + 1)) {
        test('von v$fromVersion nach v$toVersion', () async {
          final schema = await verifier.schemaAt(fromVersion);
          final db = AppDatabase(schema.newConnection());
          await verifier.migrateAndValidate(db, toVersion);
          await db.close();
        });
      }
    }

    test('neuester Snapshot entspricht der App-Version', () async {
      final db = AppDatabase(NativeDatabase.memory());
      expect(versions.last, db.schemaVersion);
      await db.close();
    });
  });

  test('v1 → v2 behält Einstellungen', () async {
    // Snapshot-Klassen speichern DateTime als Unix-Sekunden.
    final created = DateTime.utc(2026, 11, 1).millisecondsSinceEpoch ~/ 1000;
    await verifier.testWithDataIntegrity(
      oldVersion: 1,
      newVersion: 2,
      createOld: v1.DatabaseAtV1.new,
      createNew: v2.DatabaseAtV2.new,
      openTestedDatabase: AppDatabase.new,
      createItems: (batch, oldDb) {
        batch.insertAll(oldDb.settings, [
          v1.SettingsData(
            key: 'theme_mode',
            value: 'dark',
            createdAt: created,
            updatedAt: created,
          ),
        ]);
      },
      validateItems: (newDb) async {
        final rows = await newDb.select(newDb.settings).get();
        expect(rows.single.key, 'theme_mode');
        expect(rows.single.value, 'dark');
        expect(await newDb.select(newDb.horses).get(), isEmpty);
      },
    );
  });

  test('v2 → v3 behält Pferde und legt Pflege-Startwerte an', () async {
    final ts = DateTime.utc(2026, 11, 1).millisecondsSinceEpoch ~/ 1000;
    await verifier.testWithDataIntegrity(
      oldVersion: 2,
      newVersion: 3,
      createOld: v2.DatabaseAtV2.new,
      createNew: v3.DatabaseAtV3.new,
      openTestedDatabase: AppDatabase.new,
      createItems: (batch, oldDb) {
        batch.insert(
          oldDb.horses,
          v2.HorsesCompanion.insert(
            id: 'h1',
            name: 'Amigo',
            birthDate: const Value('2015-04-02'),
            createdAt: Value(ts),
            updatedAt: Value(ts),
          ),
        );
      },
      validateItems: (newDb) async {
        final horse = await newDb.select(newDb.horses).getSingle();
        expect(horse.name, 'Amigo');
        expect(horse.birthDate, '2015-04-02');
        // Startwerte kommen über beforeOpen der App-Datenbank.
        expect(await newDb.select(newDb.careEventTypes).get(), hasLength(9));
        expect(
          await newDb.select(newDb.careIntervalDefaults).get(),
          isNotEmpty,
        );
      },
    );
  });

  test('v3 → v4 behält Pflegeeinträge, Dienstplan-Tabellen leer', () async {
    final ts = DateTime.utc(2026, 11, 1).millisecondsSinceEpoch ~/ 1000;
    await verifier.testWithDataIntegrity(
      oldVersion: 3,
      newVersion: 4,
      createOld: v3.DatabaseAtV3.new,
      createNew: v4.DatabaseAtV4.new,
      openTestedDatabase: AppDatabase.new,
      createItems: (batch, oldDb) {
        batch
          ..insert(
            oldDb.horses,
            v3.HorsesCompanion.insert(
              id: 'h1',
              name: 'Amigo',
              createdAt: Value(ts),
              updatedAt: Value(ts),
            ),
          )
          ..insert(
            oldDb.careEventTypes,
            v3.CareEventTypesCompanion.insert(
              id: 'builtin_huf',
              name: 'Hufbearbeitung',
              kind: 'huf',
              color: 0xFF8D6E63,
              icon: 'huf',
              createdAt: Value(ts),
              updatedAt: Value(ts),
            ),
          )
          ..insert(
            oldDb.careEvents,
            v3.CareEventsCompanion.insert(
              id: 'e1',
              horseId: 'h1',
              typeId: 'builtin_huf',
              date: '2026-12-01',
              repeatValue: const Value(7),
              repeatUnit: const Value('weeks'),
              createdAt: Value(ts),
              updatedAt: Value(ts),
            ),
          );
      },
      validateItems: (newDb) async {
        final e = await newDb.select(newDb.careEvents).getSingle();
        expect(e.date, '2026-12-01');
        expect(e.repeatValue, 7);
        expect(await newDb.select(newDb.shiftTemplates).get(), isEmpty);
        expect(await newDb.select(newDb.shiftDays).get(), isEmpty);
      },
    );
  });

  test('v4 → v5 behält Dienstplan, Trainings-Tabellen leer', () async {
    final ts = DateTime.utc(2026, 11, 1).millisecondsSinceEpoch ~/ 1000;
    await verifier.testWithDataIntegrity(
      oldVersion: 4,
      newVersion: 5,
      createOld: v4.DatabaseAtV4.new,
      createNew: v5.DatabaseAtV5.new,
      openTestedDatabase: AppDatabase.new,
      createItems: (batch, oldDb) {
        batch
          ..insert(
            oldDb.shiftTemplates,
            v4.ShiftTemplatesCompanion.insert(
              id: 't1',
              name: 'Früh',
              shortCode: 'F',
              color: 0xFFFFB300,
              stableMinutes: 90,
              createdAt: Value(ts),
              updatedAt: Value(ts),
            ),
          )
          ..insert(
            oldDb.shiftDays,
            v4.ShiftDaysCompanion.insert(
              date: '2026-12-01',
              templateId: const Value('t1'),
              overrideMinutes: const Value(20),
              createdAt: Value(ts),
              updatedAt: Value(ts),
            ),
          );
      },
      validateItems: (newDb) async {
        final day = await newDb.select(newDb.shiftDays).getSingle();
        expect(day.templateId, 't1');
        expect(day.overrideMinutes, 20);
        expect(await newDb.select(newDb.trainingPlans).get(), isEmpty);
        expect(await newDb.select(newDb.trainingSessions).get(), isEmpty);
      },
    );
  });

  test('v5 → v6 behält Trainingseinheiten, Futter-Tabellen leer', () async {
    final ts = DateTime.utc(2026, 11, 1).millisecondsSinceEpoch ~/ 1000;
    await verifier.testWithDataIntegrity(
      oldVersion: 5,
      newVersion: 6,
      createOld: v5.DatabaseAtV5.new,
      createNew: v6.DatabaseAtV6.new,
      openTestedDatabase: AppDatabase.new,
      createItems: (batch, oldDb) {
        batch
          ..insert(
            oldDb.horses,
            v5.HorsesCompanion.insert(
              id: 'h1',
              name: 'Amigo',
              createdAt: Value(ts),
              updatedAt: Value(ts),
            ),
          )
          ..insert(
            oldDb.trainingSessions,
            v5.TrainingSessionsCompanion.insert(
              id: 's1',
              horseId: 'h1',
              date: '2026-12-01',
              title: 'Longe',
              level: 3,
              durationMinutes: 30,
              createdAt: Value(ts),
              updatedAt: Value(ts),
            ),
          );
      },
      validateItems: (newDb) async {
        final s = await newDb.select(newDb.trainingSessions).getSingle();
        expect(s.title, 'Longe');
        expect(s.level, 3);
        expect(await newDb.select(newDb.feedItems).get(), isEmpty);
        expect(await newDb.select(newDb.feedPlans).get(), isEmpty);
      },
    );
  });

  test('v6 → v7 behält Futterplan, Blutbild-Tabellen leer', () async {
    final ts = DateTime.utc(2026, 11, 1).millisecondsSinceEpoch ~/ 1000;
    await verifier.testWithDataIntegrity(
      oldVersion: 6,
      newVersion: 7,
      createOld: v6.DatabaseAtV6.new,
      createNew: v7.DatabaseAtV7.new,
      openTestedDatabase: AppDatabase.new,
      createItems: (batch, oldDb) {
        batch
          ..insert(
            oldDb.horses,
            v6.HorsesCompanion.insert(
              id: 'h1',
              name: 'Amigo',
              createdAt: Value(ts),
              updatedAt: Value(ts),
            ),
          )
          ..insert(
            oldDb.feedPlans,
            v6.FeedPlansCompanion.insert(
              id: 'p1',
              horseId: 'h1',
              name: 'Winter',
              validFrom: '2026-11-01',
              createdAt: Value(ts),
              updatedAt: Value(ts),
            ),
          );
      },
      validateItems: (newDb) async {
        final p = await newDb.select(newDb.feedPlans).getSingle();
        expect(p.name, 'Winter');
        expect(p.validFrom, '2026-11-01');
        expect(await newDb.select(newDb.bloodTests).get(), isEmpty);
      },
    );
  });
}
