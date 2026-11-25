import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:pferdekalender/core/time/local_date.dart';
import 'package:pferdekalender/features/pferd/domain/horse.dart';
import 'package:pferdekalender/features/pferd/ui/horse_providers.dart';
import 'package:pferdekalender/features/pflege/domain/care_event.dart';
import 'package:pferdekalender/features/pflege/domain/care_type.dart';
import 'package:pferdekalender/features/pflege/ui/care_providers.dart';

import '../../helpers/test_app.dart';

void main() {
  testWidgets('Ohne Pferd: Hinweis statt Kalender', (tester) async {
    final app = TestApp.create();
    await app.pump(tester);
    expect(
      find.text('Lege zuerst im Tab „Pferd“ ein Pferd an.'),
      findsOneWidget,
    );
    expect(find.text('Eintrag hinzufügen'), findsNothing);
    await app.dispose(tester);
  });

  testWidgets(
    'Hufbearbeitung anlegen: Intervall-Vorschlag, Folgetermin, Erinnerung',
    (tester) async {
      final app = TestApp.create();
      await app.container
          .read(horseRepositoryProvider)
          .createHorse(const Horse(id: '', name: 'Amigo'));
      await app.pump(tester);

      expect(find.text('Kalender'), findsOneWidget);
      await tester.tap(find.text('Eintrag hinzufügen'));
      await tester.pumpAndSettle();
      expect(find.text('Neuer Eintrag'), findsOneWidget);

      await tester.tap(find.text('Hufbearbeitung'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Beschlag'));
      await tester.pumpAndSettle();

      // Vorschlag 7 Wochen ist übernommen.
      final list = find.byType(Scrollable).first;
      await tester.scrollUntilVisible(
        find.text('Wiederholen nach'),
        300,
        scrollable: list,
      );
      expect(find.text('Wiederholen nach'), findsOneWidget);
      expect(
        tester
            .widget<TextFormField>(find.widgetWithText(TextFormField, 'Anzahl'))
            .controller!
            .text,
        '7',
      );
      expect(find.textContaining('Folgetermin am'), findsOneWidget);

      await tester.tap(find.text('Speichern'));
      await tester.pumpAndSettle();

      final events = await app.container
          .read(careRepositoryProvider)
          .watchEvents(app.container.read(selectedHorseProvider).value!.id)
          .first;
      expect(events, hasLength(2));
      final today = LocalDate.today();
      final original = events.firstWhere((e) => e.parentEventId == null);
      final followUp = events.firstWhere((e) => e.parentEventId != null);
      expect(original.variantKey, 'beschlag');
      expect(original.date, today);
      expect(followUp.date, today.addWeeks(7));
      expect(followUp.reminderOffsets, [1], reason: 'Standard-Vorbelegung');
      expect(find.textContaining('Folgetermin am'), findsOneWidget);

      // Erinnerung für den Folgetermin wurde geplant.
      await tester.pump(const Duration(seconds: 1));
      expect(
        app.notifications.planned.any(
          (n) => n.payload == 'care:${followUp.id}',
        ),
        isTrue,
      );

      // Anstehend zeigt beide offenen Termine.
      await tester.tap(find.text('Anstehend'));
      await tester.pumpAndSettle();
      expect(
        find.textContaining('Hufbearbeitung · Beschlag'),
        findsNWidgets(2),
      );

      await app.dispose(tester);
    },
  );

  testWidgets('Überfällig rot oben, Historie mit Wirkstoff-Filter', (
    tester,
  ) async {
    final app = TestApp.create();
    final horseId = await app.container
        .read(horseRepositoryProvider)
        .createHorse(const Horse(id: '', name: 'Amigo'));
    final care = app.container.read(careRepositoryProvider);
    final today = LocalDate.today();
    await care.saveEvent(
      CareEvent(
        id: '',
        horseId: horseId,
        typeId: BuiltinCareTypes.tierarzt,
        date: today.addDays(-3),
        title: 'Nachkontrolle',
      ),
    );
    for (final (days, p, w) in [
      (200, 'Equest Pramox', 'Moxidectin'),
      (100, 'Banminth', 'Pyrantel'),
    ]) {
      await care.saveEvent(
        CareEvent(
          id: '',
          horseId: horseId,
          typeId: BuiltinCareTypes.wurmkur,
          date: today.addDays(-days),
          done: true,
          fields: {CareFields.praeparat: p, CareFields.wirkstoff: w},
        ),
      );
    }
    await app.pump(tester);

    await tester.tap(find.text('Anstehend'));
    await tester.pumpAndSettle();
    expect(find.text('Überfällig'), findsOneWidget);
    expect(find.text('Tierarzt · Nachkontrolle'), findsOneWidget);
    expect(find.text('überfällig seit 3 Tagen'), findsOneWidget);

    await tester.tap(find.text('Historie'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(ChoiceChip, 'Wurmkur'));
    await tester.pumpAndSettle();
    expect(
      find.text('Wirkstoffe zuletzt: Pyrantel → Moxidectin'),
      findsOneWidget,
    );
    expect(find.text('Wurmkur · Banminth'), findsOneWidget);

    await app.dispose(tester);
  });
}
