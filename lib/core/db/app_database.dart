import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';

import '../../features/dienstplan/data/shift_tables.dart';
import '../../features/pferd/data/horse_tables.dart';
import '../../features/pflege/data/care_seed.dart';
import '../../features/pflege/data/care_tables.dart';
import '../../features/training/data/training_tables.dart';
import '../time/local_date.dart';
import 'app_database.steps.dart';
import 'converters.dart';
import 'tables/settings_table.dart';

part 'app_database.g.dart';

/// Zentrale SQLite-Datenbank (Drift). Die Datei liegt im
/// App-Dokumentenverzeichnis und verlässt das Gerät nie automatisch.
///
/// Schema-Änderungen: [schemaVersion] erhöhen, dann
/// `dart run drift_dev make-migrations` ausführen und den Schritt in
/// [migration] ergänzen (siehe CLAUDE.md).
@DriftDatabase(
  tables: [
    Settings,
    Horses,
    HorsePhotos,
    HorseWeights,
    Contacts,
    HorseContacts,
    CareEventTypes,
    CareIntervalDefaults,
    CareEvents,
    CareReminders,
    ShiftTemplates,
    ShiftPatterns,
    ShiftDays,
    TrainingPlans,
    TrainingSessions,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.executor);

  /// Öffnet die Datenbankdatei `pferdekalender.sqlite` auf dem Gerät.
  factory AppDatabase.open() => AppDatabase(
    driftDatabase(
      name: 'pferdekalender',
      native: const DriftNativeOptions(
        databaseDirectory: getApplicationDocumentsDirectory,
      ),
    ),
  );

  @override
  int get schemaVersion => 5;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) => m.createAll(),
    onUpgrade: stepByStep(
      from1To2: (m, schema) async {
        await m.createTable(schema.horses);
        await m.createTable(schema.horsePhotos);
        await m.createTable(schema.horseWeights);
        await m.createTable(schema.contacts);
        await m.createTable(schema.horseContacts);
      },
      from2To3: (m, schema) async {
        await m.createTable(schema.careEventTypes);
        await m.createTable(schema.careIntervalDefaults);
        await m.createTable(schema.careEvents);
        await m.createTable(schema.careReminders);
      },
      from3To4: (m, schema) async {
        await m.createTable(schema.shiftTemplates);
        await m.createTable(schema.shiftPatterns);
        await m.createTable(schema.shiftDays);
      },
      from4To5: (m, schema) async {
        await m.createTable(schema.trainingPlans);
        await m.createTable(schema.trainingSessions);
      },
    ),
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON');
      // Startwerte immer nach allen Migrationen auf dem aktuellen Schema
      // ergänzen (insertOrIgnore – Nutzeränderungen bleiben erhalten).
      // (Ab Schema v3; Migrationstests öffnen auch ältere Zwischenstände.)
      if (details.versionNow >= 3) await seedCareDefaults(this);
    },
  );
}
