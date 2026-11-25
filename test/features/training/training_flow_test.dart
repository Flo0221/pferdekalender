import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:pferdekalender/core/time/local_date.dart';
import 'package:pferdekalender/features/dienstplan/ui/shift_providers.dart';
import 'package:pferdekalender/features/pferd/domain/horse.dart';
import 'package:pferdekalender/features/pferd/ui/horse_providers.dart';
import 'package:pferdekalender/features/training/ui/generator_screen.dart';
import 'package:pferdekalender/features/training/ui/training_providers.dart';
import 'package:pferdekalender/features/training/ui/training_screen.dart';

import '../../helpers/test_app.dart';

void main() {
  testWidgets('Einheit von Hand anlegen', (tester) async {
    final app = TestApp.create();
    final horseId = await app.container
        .read(horseRepositoryProvider)
        .createHorse(const Horse(id: '', name: 'Amigo'));
    await app.pump(tester);
    await app.openTab(tester, 'Training');

    final trainingList = find
        .descendant(
          of: find.byType(TrainingScreen),
          matching: find.byType(Scrollable),
        )
        .first;
    await tester.scrollUntilVisible(
      find.text('Ruhetag – keine Einheit geplant'),
      300,
      scrollable: trainingList,
    );
    expect(find.text('Ruhetag – keine Einheit geplant'), findsOneWidget);
    await tester.tap(find.text('Einheit hinzufügen'));
    await tester.pumpAndSettle();
    expect(find.text('Neue Einheit'), findsOneWidget);

    await tester.enterText(
      find.widgetWithText(TextFormField, 'Titel'),
      'Longe',
    );
    await tester.tap(find.textContaining('3 · Mittel'));
    await tester.tap(find.widgetWithText(ChoiceChip, '40 min'));
    await tester.tap(find.text('Speichern'));
    await tester.pumpAndSettle();

    await tester.scrollUntilVisible(
      find.text('Longe'),
      300,
      scrollable: trainingList,
    );
    expect(find.text('Longe'), findsOneWidget);
    expect(find.text('Stufe 3 · 40 min'), findsOneWidget);
    final sessions = await app.read(
      tester,
      () => app.container.read(trainingRepositoryProvider).getSessions(horseId),
    );
    expect(sessions.single.pinned, isTrue, reason: 'manuell = fixiert');
    expect(sessions.single.date, LocalDate.today());

    await app.dispose(tester);
  });

  testWidgets(
    'Generator: Hinweis, Vorschau mit Kurve, übernehmen, Dienstplan geändert',
    (tester) async {
      final app = TestApp.create();
      await app.container
          .read(horseRepositoryProvider)
          .createHorse(const Horse(id: '', name: 'Amigo'));
      await app.container
          .read(shiftRepositoryProvider)
          .createDefaultTemplates();
      await app.pump(tester);
      await app.openTab(tester, 'Training');

      await tester.tap(find.byTooltip('Plan-Generator'));
      await tester.pumpAndSettle();
      // Hinweis beim ersten Mal.
      expect(find.text('Bevor es losgeht'), findsOneWidget);
      await tester.tap(find.text('Verstanden'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Wiedereinstieg nach Pause'));
      await tester.pumpAndSettle();
      expect(
        find.textContaining('Nur nach Freigabe durch den Tierarzt'),
        findsOneWidget,
      );
      await tester.tap(find.text('Muskelaufbau'));
      await tester.tap(find.text('4 Wochen'));
      await tester.pumpAndSettle();

      await tester.scrollUntilVisible(
        find.text('Vorschau erstellen'),
        300,
        scrollable: find
            .descendant(
              of: find.byType(GeneratorScreen),
              matching: find.byType(Scrollable),
            )
            .first,
      );
      await tester.tap(find.text('Vorschau erstellen'));
      await tester.pump();
      await app.settle(tester);
      expect(find.text('Belastungskurve'), findsOneWidget);
      expect(find.textContaining('Woche 1 ·'), findsOneWidget);

      await tester.tap(find.text('Plan übernehmen'));
      await app.settle(tester);
      expect(find.text('Trainingsplan übernommen'), findsOneWidget);
      expect(find.text('Aktueller Plan: Muskelaufbau'), findsOneWidget);
      expect(
        find.text('Dienstplan geändert – Plan ab heute neu verteilen?'),
        findsNothing,
      );

      // Dienstplan ändern → Hinweis erscheint → neu verteilen.
      final shifts = app.container.read(shiftRepositoryProvider);
      final templates = await app.read(
        tester,
        () => shifts.watchTemplates().first,
      );
      await tester.runAsync(
        () => shifts.setShift(LocalDate.today().addDays(2), templates.first.id),
      );
      await app.settle(tester);
      expect(
        find.text('Dienstplan geändert – Plan ab heute neu verteilen?'),
        findsOneWidget,
      );
      await tester.tap(find.text('Neu verteilen'));
      await app.settle(tester, rounds: 40);
      expect(
        find.text('Dienstplan geändert – Plan ab heute neu verteilen?'),
        findsNothing,
      );

      await app.dispose(tester);
    },
  );
}
