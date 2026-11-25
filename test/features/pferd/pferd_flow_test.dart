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
import 'package:pferdekalender/features/pferd/domain/horse.dart';
import 'package:pferdekalender/features/pferd/ui/horse_providers.dart';

import '../../helpers/fake_notifications.dart';

void main() {
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;

  Future<(AppDatabase, ProviderContainer)> pumpApp(WidgetTester tester) async {
    final db = AppDatabase(NativeDatabase.memory());
    final container = ProviderContainer(
      overrides: [
        databaseProvider.overrideWithValue(db),
        notificationGatewayProvider.overrideWithValue(
          FakeNotificationGateway(),
        ),
        documentsDirProvider.overrideWith((ref) async => Directory.systemTemp),
      ],
    );
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const PferdekalenderApp(),
      ),
    );
    await tester.pumpAndSettle();
    return (db, container);
  }

  Future<void> tearDownApp(
    WidgetTester tester,
    AppDatabase db,
    ProviderContainer container,
  ) async {
    await tester.pumpWidget(const SizedBox.shrink());
    container.dispose();
    await tester.pump(const Duration(seconds: 1));
    await tester.runAsync(db.close);
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

  testWidgets('Erstes Pferd anlegen → Profil und Umschalter zeigen es', (
    tester,
  ) async {
    final (db, container) = await pumpApp(tester);
    await openTab(tester, 'Pferd');

    expect(find.text('Noch kein Pferd angelegt'), findsOneWidget);
    await tester.tap(find.text('Erstes Pferd anlegen'));
    await tester.pumpAndSettle();
    expect(find.text('Neues Pferd'), findsOneWidget);

    // Speichern ohne Namen zeigt Pflichtfeld-Hinweis.
    await tester.tap(find.text('Speichern'));
    await tester.pumpAndSettle();
    expect(find.text('Bitte ausfüllen'), findsOneWidget);

    await tester.enterText(
      find.widgetWithText(TextFormField, 'Name *'),
      'Don Diego',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Rufname'),
      'Didi',
    );
    await tester.tap(find.text('Wallach'));
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Rasse'),
      'Hannoveraner',
    );
    await tester.tap(find.text('Speichern'));
    await tester.pumpAndSettle();

    // Zurück im Profil: Rufname im Kopf und im Umschalter, Name als Feld.
    expect(find.text('Didi'), findsWidgets);
    expect(find.text('Don Diego'), findsOneWidget);
    expect(find.textContaining('Wallach'), findsOneWidget);
    expect(
      find.bySemanticsLabel(RegExp('Pferd wechseln: Didi')),
      findsOneWidget,
    );

    // Auch im Pflege-Tab ist das Pferd gewählt.
    await openTab(tester, 'Pflege');
    expect(
      find.bySemanticsLabel(RegExp('Pferd wechseln: Didi')),
      findsOneWidget,
    );
    // Dienstplan ist pferdeunabhängig.
    await openTab(tester, 'Dienst');
    expect(find.text('Mein Dienstplan'), findsOneWidget);

    await tearDownApp(tester, db, container);
  });

  testWidgets('Umschalter wechselt zwischen zwei Pferden', (tester) async {
    final (db, container) = await pumpApp(tester);
    final repo = container.read(horseRepositoryProvider);
    await repo.createHorse(const Horse(id: '', name: 'Amigo'));
    await repo.createHorse(const Horse(id: '', name: 'Bella'));
    await tester.pumpAndSettle();

    expect(
      find.bySemanticsLabel(RegExp('Pferd wechseln: Amigo')),
      findsOneWidget,
    );
    await tester.tap(find.bySemanticsLabel(RegExp('Pferd wechseln')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Bella').last);
    await tester.pumpAndSettle();
    expect(
      find.bySemanticsLabel(RegExp('Pferd wechseln: Bella')),
      findsOneWidget,
    );

    await tearDownApp(tester, db, container);
  });

  testWidgets(
    'Archivieren mit Bestätigung, endgültig löschen doppelt bestätigt',
    (tester) async {
      final (db, container) = await pumpApp(tester);
      final repo = container.read(horseRepositoryProvider);
      await repo.createHorse(const Horse(id: '', name: 'Amigo'));
      await tester.pumpAndSettle();
      await openTab(tester, 'Pferd');

      await tester.tap(find.byTooltip('Pferde verwalten'));
      await tester.pumpAndSettle();
      expect(find.text('Meine Pferde'), findsOneWidget);

      await tester.tap(find.byIcon(Icons.more_vert).first);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Archivieren').last);
      await tester.pumpAndSettle();
      expect(find.text('Amigo archivieren?'), findsOneWidget);
      await tester.tap(find.widgetWithText(FilledButton, 'Archivieren'));
      await tester.pumpAndSettle();
      expect(find.text('Keine archivierten Pferde'), findsNothing);

      // Endgültig löschen: Warnung → Weiter → Namen eintippen.
      await tester.tap(find.byIcon(Icons.more_vert).first);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Endgültig löschen').last);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Weiter'));
      await tester.pumpAndSettle();
      final deleteButton = find.widgetWithText(
        FilledButton,
        'Endgültig löschen',
      );
      expect(tester.widget<FilledButton>(deleteButton).onPressed, isNull);
      await tester.enterText(find.byType(TextField).last, 'Amigo');
      await tester.pumpAndSettle();
      await tester.tap(deleteButton);
      await tester.pumpAndSettle();

      expect(find.text('Keine archivierten Pferde'), findsOneWidget);
      expect(await db.select(db.horses).get(), isEmpty);

      await tearDownApp(tester, db, container);
    },
  );
}
