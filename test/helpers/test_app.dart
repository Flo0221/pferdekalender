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

  /// Sauberes Beenden (Drift-Stream-Timer, Datenbank schließen).
  Future<void> dispose(WidgetTester tester) async {
    await tester.pumpWidget(const SizedBox.shrink());
    container.dispose();
    await tester.pump(const Duration(seconds: 1));
    await tester.runAsync(db.close);
  }
}
