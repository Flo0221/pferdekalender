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
import 'package:pferdekalender/features/training/domain/training_catalog.dart';
import 'package:pferdekalender/features/training/ui/training_providers.dart';

import 'fake_notifications.dart';

/// Laufende Test-App mit In-Memory-Datenbank und gefälschten Benachrichtigungen.
class TestApp {
  TestApp(this.db, this.container, this.notifications);

  final AppDatabase db;
  final ProviderContainer container;
  final FakeNotificationGateway notifications;

  /// Erzeugt Datenbank und Container (vor dem Pumpen, um Daten anzulegen).
  static TestApp create() {
    driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
    final db = AppDatabase(NativeDatabase.memory());
    final notifications = FakeNotificationGateway();
    final container = ProviderContainer(
      overrides: [
        databaseProvider.overrideWithValue(db),
        documentsDirProvider.overrideWith((ref) async => Directory.systemTemp),
        notificationGatewayProvider.overrideWithValue(notifications),
        // rootBundle lädt in der Testzeit nicht – Vorlagen direkt lesen.
        trainingCatalogProvider.overrideWithValue(AsyncData(testCatalog)),
      ],
    );
    return TestApp(db, container, notifications);
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
