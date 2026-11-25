import 'dart:convert';
import 'dart:io';

import 'package:drift/drift.dart' show driftRuntimeOptions;
import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:pferdekalender/app.dart';
import 'package:pferdekalender/core/db/app_database.dart';
import 'package:pferdekalender/core/db/database_provider.dart';
import 'package:pferdekalender/core/files/documents_dir_provider.dart';
import 'package:pferdekalender/core/notifications/notification_providers.dart';
import 'package:pferdekalender/core/platform/web_env.dart';
import 'package:pferdekalender/features/backup/ui/backup_files.dart';
import 'package:pferdekalender/features/gesundheit/domain/blood.dart';
import 'package:pferdekalender/features/gesundheit/ui/blood_providers.dart';
import 'package:pferdekalender/features/training/domain/training_catalog.dart';
import 'package:pferdekalender/features/training/ui/training_providers.dart';

import 'fake_backup_files.dart';
import 'fake_notifications.dart';

/// Laufende Test-App mit In-Memory-Datenbank und gefälschten Benachrichtigungen.
class TestApp {
  TestApp(this.db, this.container, this.notifications, this.backupFiles);

  final AppDatabase db;
  final ProviderContainer container;
  final FakeNotificationGateway notifications;
  final FakeBackupFiles backupFiles;

  /// Erzeugt Datenbank und Container (vor dem Pumpen, um Daten anzulegen).
  static TestApp create({WebEnv? webEnv}) {
    driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
    final db = AppDatabase(NativeDatabase.memory());
    final docs = Directory.systemTemp.createTempSync('pferdekalender_test');
    final notifications = FakeNotificationGateway();
    final backupFiles = FakeBackupFiles();
    final container = ProviderContainer(
      overrides: [
        databaseProvider.overrideWithValue(db),
        // Eigener Ordner je Test (Import räumt dort Fotos auf).
        documentsDirProvider.overrideWith((ref) async => docs),
        notificationGatewayProvider.overrideWithValue(notifications),
        backupFilesProvider.overrideWithValue(backupFiles),
        if (webEnv != null) webEnvProvider.overrideWithValue(webEnv),
        // rootBundle lädt in der Testzeit nicht – Vorlagen direkt lesen.
        trainingCatalogProvider.overrideWithValue(AsyncData(testCatalog)),
        bloodCatalogProvider.overrideWithValue(AsyncData(testBloodCatalog)),
      ],
    );
    return TestApp(db, container, notifications, backupFiles);
  }

  Future<void> pump(WidgetTester tester) async {
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const PferdekalenderApp(),
      ),
    );
    await tester.pumpAndSettle();
  }

  Future<void> openTab(WidgetTester tester, String label) async {
    await tester.tap(
      find.descendant(
        of: find.byType(NavigationBar),
        matching: find.text(label),
      ),
    );
    await tester.pumpAndSettle();
  }

  /// Liest aus der Datenbank, nachdem UI-Aktionen Schreibzugriffe ausgelöst
  /// haben. Direkt im Test-Zone-`await` kann das hängen; `runAsync` nicht.
  Future<T> read<T>(WidgetTester tester, Future<T> Function() query) async =>
      (await tester.runAsync(query)) as T;

  /// Wie `pumpAndSettle`, lässt aber zwischendurch echte Zeit verstreichen –
  /// für Bildschirme, die beim Öffnen selbst die Datenbank abfragen (sonst
  /// dreht der Ladekreisel endlos und `pumpAndSettle` läuft in den Timeout).
  Future<void> settle(WidgetTester tester, {int rounds = 15}) async {
    for (var i = 0; i < rounds; i++) {
      await tester.runAsync(
        () => Future<void>.delayed(const Duration(milliseconds: 20)),
      );
      await tester.pump(const Duration(milliseconds: 50));
    }
    await tester.pumpAndSettle();
  }

  /// Sauberes Beenden (Drift-Stream-Timer, Datenbank schließen).
  Future<void> dispose(WidgetTester tester) async {
    await tester.pumpWidget(const SizedBox.shrink());
    container.dispose();
    await tester.pump(const Duration(seconds: 1));
    await tester.runAsync(db.close);
  }
}

/// Trainingsvorlagen aus `assets/training_templates.json`.
final testCatalog = TrainingCatalog.fromJson(
  (jsonDecode(File('assets/training_templates.json').readAsStringSync()) as Map)
      .cast<String, Object?>(),
);

/// Blutbild-Referenzwerte aus `assets/blood_reference.json`.
final testBloodCatalog = BloodCatalog.fromJson(
  (jsonDecode(File('assets/blood_reference.json').readAsStringSync()) as Map)
      .cast<String, Object?>(),
);
