import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:pferdekalender/core/time/local_date.dart';
import 'package:pferdekalender/features/futter/domain/feed.dart';
import 'package:pferdekalender/features/futter/ui/feed_providers.dart';
import 'package:pferdekalender/features/pferd/domain/horse.dart';
import 'package:pferdekalender/features/pferd/ui/horse_providers.dart';
import 'package:pferdekalender/features/training/domain/training.dart';
import 'package:pferdekalender/features/training/ui/training_providers.dart';

import '../../helpers/test_app.dart';

void main() {
  testWidgets('Futterplan anlegen, Tagesration, Trainingstag-Variante', (
    tester,
  ) async {
    final app = TestApp.create();
    final horseId = await app.container
        .read(horseRepositoryProvider)
        .createHorse(const Horse(id: '', name: 'Amigo'));
    final feed = app.container.read(feedRepositoryProvider);
    final heu = await feed.saveItem(
      const FeedItem(
        id: '',
        name: 'Heu',
        category: FeedCategory.raufutter,
        unit: FeedUnit.kg,
      ),
    );
    final hafer = await feed.saveItem(
      const FeedItem(
        id: '',
        name: 'Hafer',
        category: FeedCategory.kraftfutter,
        unit: FeedUnit.kg,
        stock: 3,
        lowStockThreshold: 5,
      ),
    );
    await app.pump(tester);
    await app.openTab(tester, 'Futter');

    expect(find.text('Noch kein Futterplan'), findsOneWidget);
    await tester.tap(find.text('Futterplan anlegen'));
    await app.settle(tester);
    expect(find.text('Futterplan bearbeiten'), findsOneWidget);
    expect(find.text('Morgens'), findsOneWidget);
    expect(find.text('Abends'), findsOneWidget);

    // Morgens: Heu 4 kg (Standard-Auswahl = erstes Futtermittel).
    await tester.tap(find.text('Futtermittel hinzufügen').first);
    await tester.pumpAndSettle();
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Menge').first,
      '4',
    );
    await tester.tap(find.text('Speichern'));
    await app.settle(tester);

    expect(find.text('Futterplan · gültig seit ${_today()}'), findsOneWidget);
    expect(find.text('Tagessumme'), findsOneWidget);
    expect(find.text('4 kg'), findsWidgets);

    // Hafer nur an Trainingstagen ergänzen (direkt über das Repository).
    final p = (await app.read(tester, () => feed.getPlans(horseId))).single;
    await tester.runAsync(
      () => feed.savePlan(
        FeedPlan(
          id: p.id,
          horseId: horseId,
          name: p.name,
          validFrom: p.validFrom,
          meals: [
            Meal(
              id: '',
              name: 'Morgens',
              timeMinutes: 420,
              entries: [
                MealEntry(id: '', itemId: heu, amount: 4),
                MealEntry(
                  id: '',
                  itemId: hafer,
                  amount: 1,
                  variant: FeedVariant.trainingDay,
                ),
              ],
            ),
          ],
        ),
      ),
    );
    await app.settle(tester);
    expect(find.text('Ruhetag'), findsOneWidget);
    expect(find.text('Hafer'), findsNothing);

    // Training heute → Trainingstag, Hafer erscheint; Vorrat knapp.
    await tester.runAsync(
      () => app.container
          .read(trainingRepositoryProvider)
          .saveSession(
            TrainingSession(
              id: '',
              horseId: horseId,
              date: LocalDate.today(),
              level: 3,
              durationMinutes: 40,
              title: 'Longe',
            ),
          ),
    );
    await app.settle(tester);
    expect(find.text('Trainingstag'), findsOneWidget);
    expect(find.text('Hafer'), findsWidgets);
    expect(find.text('nur an Trainingstagen'), findsOneWidget);
    expect(find.text('Vorrat wird knapp: Hafer'), findsOneWidget);

    await app.dispose(tester);
  });
}

String _today() {
  final d = LocalDate.today();
  return '${d.day.toString().padLeft(2, '0')}.${d.month.toString().padLeft(2, '0')}.${d.year}';
}
