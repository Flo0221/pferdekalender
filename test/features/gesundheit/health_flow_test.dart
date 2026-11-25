import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:pferdekalender/core/router/app_router.dart';
import 'package:pferdekalender/features/futter/ui/feed_providers.dart';
import 'package:pferdekalender/features/gesundheit/ui/blood_edit_screen.dart';
import 'package:pferdekalender/features/pferd/domain/horse.dart';
import 'package:pferdekalender/features/pferd/ui/horse_providers.dart';
import 'package:pferdekalender/features/pferd/ui/pferd_screen.dart';

import '../../helpers/test_app.dart';

void main() {
  testWidgets(
    'Gesundheit: Werte per Suche eintragen, Auswertung, Kurzinfo im Profil, übernehmen',
    (tester) async {
      final app = TestApp.create();
      final horseId = await app.container
          .read(horseRepositoryProvider)
          .createHorse(const Horse(id: '', name: 'Amigo'));
      await app.pump(tester);
      await app.openTab(tester, 'Pferd');

      final profile = find
          .descendant(
            of: find.byType(PferdScreen),
            matching: find.byType(Scrollable),
          )
          .first;
      await tester.scrollUntilVisible(
        find.text('Gesundheit'),
        300,
        scrollable: profile,
      );
      expect(find.text('Noch kein Blutbild eingetragen'), findsOneWidget);

      await tester.tap(find.text('Noch kein Blutbild eingetragen'));
      await app.settle(tester);
      await tester.tap(find.text('Blutbild eintragen'));
      await app.settle(tester);
      expect(find.text('Neues Blutbild'), findsOneWidget);
      expect(find.text('0 Werte eingetragen'), findsNothing);
      expect(find.text('Noch kein Wert eingetragen'), findsOneWidget);

      // Suche nach „gamma“ findet γ-GT.
      await tester.enterText(find.byType(TextField).first, 'gamma');
      await tester.pumpAndSettle();
      expect(find.text('γ-GT'), findsOneWidget);
      expect(find.text('Selen'), findsNothing);
      await tester.tap(find.text('γ-GT'));
      await tester.pumpAndSettle();
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Wert *'),
        '60',
      );
      await tester.tap(find.widgetWithText(FilledButton, 'Speichern'));
      await tester.pumpAndSettle();
      expect(find.text('zu hoch'), findsOneWidget);

      // Ohne Suche scrollen: Selen eintragen.
      await tester.tap(find.byTooltip('Suche leeren'));
      await tester.pumpAndSettle();
      final list = find
          .descendant(
            of: find.byType(BloodEditScreen),
            matching: find.byType(Scrollable),
          )
          .last;
      await tester.scrollUntilVisible(
        find.text('Selen'),
        300,
        scrollable: list,
      );
      await tester.ensureVisible(find.text('Selen'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Selen'));
      await tester.pumpAndSettle();
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Wert *'),
        '80',
      );
      await tester.tap(find.widgetWithText(FilledButton, 'Speichern'));
      await tester.pumpAndSettle();
      expect(find.text('2 Werte eingetragen'), findsOneWidget);

      await tester.tap(find.text('Speichern'));
      await app.settle(tester);

      // Auswertung.
      expect(find.textContaining('Auswertung ·'), findsOneWidget);
      expect(find.textContaining('keine Diagnose'), findsOneWidget);

      final detail = find.byType(Scrollable).last;
      await tester.scrollUntilVisible(
        find.text('Leberunterstützendes Ergänzungsfutter'),
        300,
        scrollable: detail,
      );
      await tester.scrollUntilVisible(
        find.text('In Futterplan übernehmen'),
        300,
        scrollable: detail,
      );
      await tester.tap(find.text('In Futterplan übernehmen'));
      await app.settle(tester);
      expect(find.textContaining('Zusätze'), findsWidgets);

      final supplements = await app.read(
        tester,
        () => app.container
            .read(feedRepositoryProvider)
            .watchSupplements(horseId)
            .first,
      );
      expect(supplements.length, greaterThanOrEqualTo(2));

      // Zurück: Kurzinfo im Profil.
      final router = app.container.read(routerProvider);
      router.pop();
      await app.settle(tester);
      router.pop();
      await app.settle(tester);
      await tester.scrollUntilVisible(
        find.textContaining('Leberwerte erhöht'),
        300,
        scrollable: profile,
      );
      expect(find.textContaining('Leberwerte erhöht'), findsOneWidget);
      expect(find.textContaining('Selen zu niedrig'), findsOneWidget);

      await app.dispose(tester);
    },
  );
}
