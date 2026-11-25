import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:pferdekalender/core/time/local_date.dart';
import 'package:pferdekalender/features/dienstplan/ui/shift_providers.dart';

import '../../helpers/test_app.dart';

void main() {
  testWidgets('Vorlagen anlegen, Schnell eintragen, Tag überschreiben', (
    tester,
  ) async {
    final app = TestApp.create();
    await app.pump(tester);
    await app.openTab(tester, 'Dienst');

    expect(find.text('Noch keine Schichten'), findsOneWidget);
    await tester.tap(find.text('Standard-Vorlagen anlegen'));
    await tester.pumpAndSettle();

    // Kein Pferde-Umschalter im Dienstplan.
    expect(find.text('Mein Dienstplan'), findsOneWidget);

    // Schnell-Modus: „Nacht“ wählen und heute antippen.
    await tester.tap(find.byTooltip('Schnell eintragen'));
    await tester.pumpAndSettle();
    expect(find.text('Vorlage wählen, dann Tage antippen.'), findsOneWidget);
    await tester.tap(find.widgetWithText(ChoiceChip, 'Nacht'));
    await tester.pumpAndSettle();

    final today = LocalDate.today();
    await tester.tap(find.text('${today.day}').first);
    await tester.pumpAndSettle();

    final repo = app.container.read(shiftRepositoryProvider);
    var day = (await app.read(tester, () => repo.getDays(today, today)))[today];
    final templates = await app.read(tester, () => repo.watchTemplates().first);
    final nacht = templates.firstWhere((t) => t.name == 'Nacht');
    expect(day?.templateId, nacht.id);
    expect(find.text('N'), findsWidgets);

    // Schnell-Modus beenden, Tag bearbeiten: eigene Stallzeit 20 min.
    await tester.tap(find.byTooltip('Fertig'));
    await tester.pumpAndSettle();
    expect(find.text('Nacht'), findsOneWidget);
    await tester.tap(find.byTooltip('Tag bearbeiten'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Eigene Stallzeit für diesen Tag'));
    await tester.pumpAndSettle();
    final sheetList = find
        .descendant(
          of: find.byType(BottomSheet),
          matching: find.byType(Scrollable),
        )
        .first;
    await tester.scrollUntilVisible(
      find.widgetWithText(ChoiceChip, '20 min'),
      100,
      scrollable: sheetList,
    );
    await tester.tap(find.widgetWithText(ChoiceChip, '20 min'));
    await tester.scrollUntilVisible(
      find.text('Beisteller/Reitbeteiligung übernimmt'),
      100,
      scrollable: sheetList,
    );
    await tester.tap(find.text('Beisteller/Reitbeteiligung übernimmt'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, 'Speichern'));
    await tester.pumpAndSettle();

    day = (await app.read(tester, () => repo.getDays(today, today)))[today];
    expect(day?.overrideMinutes, 20);
    expect(day?.otherPersonCovers, isTrue);
    expect(day?.templateId, nacht.id);
    expect(find.textContaining('Stallzeit 20 min *'), findsOneWidget);
    expect(find.text('N*'), findsWidgets);

    await app.dispose(tester);
  });

  testWidgets('Rhythmus anlegen und ausrollen', (tester) async {
    final app = TestApp.create();
    final repo = app.container.read(shiftRepositoryProvider);
    await repo.createDefaultTemplates();
    await app.pump(tester);
    await app.openTab(tester, 'Dienst');

    await tester.tap(find.byTooltip('Rhythmen'));
    await tester.pumpAndSettle();
    expect(find.text('Noch keine Rhythmen'), findsOneWidget);
    await tester.tap(find.text('Neuer Rhythmus'));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField).first, 'Wechselschicht');
    for (final chip in ['+ Früh', '+ Früh', '+ Spät', '+ Spät', '+ Frei']) {
      await tester.tap(find.text(chip));
      await tester.pump();
    }
    await tester.pumpAndSettle();
    expect(find.text('2× F · 2× S · 1× –'), findsOneWidget);
    expect(find.text('Zyklus: 5 Tage'), findsOneWidget);

    await tester.tap(find.text('Ausrollen'));
    await tester.pumpAndSettle();
    expect(find.text('56 Tage eingetragen'), findsOneWidget);
    expect(find.text('Wechselschicht'), findsOneWidget);

    final start = LocalDate.today().startOfWeek;
    final days = await app.read(
      tester,
      () => repo.getDays(start, start.addDays(55)),
    );
    expect(days, hasLength(56));

    await app.dispose(tester);
  });
}
