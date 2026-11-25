import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:drift_dev/api/migrations_native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pferdekalender/core/db/app_database.dart';

import 'generated/schema.dart';
import 'generated/schema_v1.dart' as v1;
import 'generated/schema_v2.dart' as v2;

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
}
