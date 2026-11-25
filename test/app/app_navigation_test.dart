import 'package:drift/drift.dart' show driftRuntimeOptions;
import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:pferdekalender/app.dart';
import 'package:pferdekalender/core/db/app_database.dart';
import 'package:pferdekalender/core/db/database_provider.dart';

void main() {
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;

  Future<AppDatabase> pumpApp(WidgetTester tester) async {
    final db = AppDatabase(NativeDatabase.memory());
    await tester.pumpWidget(
      ProviderScope(
        overrides: [databaseProvider.overrideWithValue(db)],
        child: const PferdekalenderApp(),
      ),
    );
    await tester.pumpAndSettle();
    return db;
  }

  Future<void> tearDownApp(WidgetTester tester, AppDatabase db) async {
    await tester.pumpWidget(const SizedBox.shrink());
    // Drift räumt Stream-Abfragen mit einem kurzen Timer auf.
    await tester.pump(const Duration(seconds: 1));
    await tester.runAsync(db.close);
  }

  testWidgets('App startet im Pflege-Tab mit 5 Tabs auf Deutsch', (
    tester,
  ) async {
    final db = await pumpApp(tester);

    expect(find.text('Pflege-Kalender'), findsOneWidget);
    for (final label in ['Pflege', 'Training', 'Futter', 'Dienst', 'Pferd']) {
      expect(
        find.descendant(
          of: find.byType(NavigationBar),
          matching: find.text(label),
        ),
        findsOneWidget,
      );
    }
    await tearDownApp(tester, db);
  });

  testWidgets('Tabs wechseln zeigt den jeweiligen Bereich', (tester) async {
    final db = await pumpApp(tester);

    final expected = {
      'Training': 'Noch kein Training geplant',
      'Futter': 'Noch kein Futterplan',
      'Dienst': 'Mein Dienstplan',
      'Pferd': 'Noch kein Pferd angelegt',
      'Pflege': 'Noch keine Pflegetermine',
    };
    for (final MapEntry(key: tab, value: text) in expected.entries) {
      await tester.tap(
        find.descendant(
          of: find.byType(NavigationBar),
          matching: find.text(tab),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text(text), findsOneWidget, reason: 'Tab $tab');
    }
    await tearDownApp(tester, db);
  });

  testWidgets('Einstellungen öffnen, Theme umschalten, Hinweis sichtbar', (
    tester,
  ) async {
    final db = await pumpApp(tester);

    await tester.tap(find.byTooltip('Einstellungen öffnen'));
    await tester.pumpAndSettle();
    expect(find.text('Einstellungen'), findsOneWidget);
    expect(
      find.textContaining('ersetzen keine Absprache mit Tierarzt'),
      findsOneWidget,
    );

    await tester.tap(find.text('Dunkel'));
    await tester.pumpAndSettle();
    final app = tester.widget<MaterialApp>(find.byType(MaterialApp));
    expect(app.themeMode, ThemeMode.dark);

    await tearDownApp(tester, db);
  });
}
