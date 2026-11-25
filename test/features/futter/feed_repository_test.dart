import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pferdekalender/core/db/app_database.dart';
import 'package:pferdekalender/core/time/local_date.dart';
import 'package:pferdekalender/features/futter/data/feed_repository.dart';
import 'package:pferdekalender/features/futter/domain/feed.dart';
import 'package:pferdekalender/features/pferd/data/horse_repository.dart';
import 'package:pferdekalender/features/pferd/data/photo_storage.dart';
import 'package:pferdekalender/features/pferd/domain/horse.dart';

void main() {
  late AppDatabase db;
  late FeedRepository repo;
  late HorseRepository horses;
  late String horseId;
  late String heu;

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    repo = FeedRepository(db);
    horses = HorseRepository(
      db,
      PhotoStorage(() async => Directory.systemTemp),
    );
    horseId = await horses.createHorse(const Horse(id: '', name: 'Amigo'));
    heu = await repo.saveItem(
      const FeedItem(
        id: '',
        name: 'Heu',
        category: FeedCategory.raufutter,
        unit: FeedUnit.kg,
        stock: 300,
      ),
    );
  });
  tearDown(() => db.close());

  FeedPlan plan({String id = '', double amount = 9}) => FeedPlan(
    id: id,
    horseId: horseId,
    name: 'Winter',
    validFrom: LocalDate(2026, 11, 1),
    meals: [
      Meal(
        id: '',
        name: 'Morgens',
        timeMinutes: 420,
        entries: [MealEntry(id: '', itemId: heu, amount: amount)],
      ),
    ],
  );

  test(
    'Plan speichern und vollständig lesen; Bearbeiten ersetzt Mahlzeiten',
    () async {
      final id = await repo.savePlan(plan());
      var plans = await repo.getPlans(horseId);
      expect(plans.single.meals.single.entries.single.amount, 9);

      await repo.savePlan(plan(id: id, amount: 10));
      plans = await repo.getPlans(horseId);
      expect(plans.single.meals, hasLength(1));
      expect(plans.single.meals.single.entries.single.amount, 10);
      expect(await db.select(db.feedMealItems).get(), hasLength(1));
    },
  );

  test('neue Version: Kopie ab Datum, alte bleibt', () async {
    final id = await repo.savePlan(plan());
    final original = (await repo.getPlans(horseId)).single;
    await repo.createVersion(original, LocalDate(2027, 3, 1), name: 'Frühjahr');
    final plans = await repo.getPlans(horseId);
    expect(plans.map((p) => p.name), ['Frühjahr', 'Winter']);
    expect(plans.last.id, id);
    expect(plans.first.meals.single.entries.single.itemId, heu);
  });

  test('watchPlans reagiert auch auf Änderungen an Mahlzeiten', () async {
    final id = await repo.savePlan(plan());
    final stream = repo.watchPlans(horseId);
    final first = await stream.first;
    expect(first.single.meals.single.entries.single.amount, 9);
    await repo.savePlan(plan(id: id, amount: 7));
    final next = await repo.watchPlans(horseId).first;
    expect(next.single.meals.single.entries.single.amount, 7);
  });

  test('verwendetes Futtermittel wird nur archiviert', () async {
    await repo.savePlan(plan());
    expect(await repo.removeItem(heu), isFalse);
    expect(await repo.watchItems().first, isEmpty);
    expect(
      (await repo.watchItems(includeArchived: true).first).single.archived,
      isTrue,
    );
    final unused = await repo.saveItem(
      const FeedItem(
        id: '',
        name: 'Möhren',
        category: FeedCategory.leckerli,
        unit: FeedUnit.stueck,
      ),
    );
    expect(await repo.removeItem(unused), isTrue);
  });

  test('findOrCreateItem findet gleichnamige Futtermittel', () async {
    final a = await repo.findOrCreateItem(
      const FeedItem(
        id: '',
        name: 'heu ',
        category: FeedCategory.raufutter,
        unit: FeedUnit.kg,
      ),
    );
    expect(a, heu);
    final b = await repo.findOrCreateItem(
      const FeedItem(
        id: '',
        name: 'Leinöl',
        category: FeedCategory.oel,
        unit: FeedUnit.ml,
      ),
    );
    expect(b, isNot(heu));
  });

  test('Zusätze speichern, Pferd löschen entfernt Futterdaten', () async {
    await repo.savePlan(plan());
    await repo.saveSupplement(
      TemporarySupplement(
        id: '',
        horseId: horseId,
        itemId: heu,
        start: LocalDate(2026, 11, 1),
        end: LocalDate(2026, 12, 12),
        source: SupplementSource.bloodTest,
        bloodTestId: 'b1',
      ),
    );
    final s = (await repo.watchSupplements(horseId).first).single;
    expect(s.amount, isNull);
    expect(s.source, SupplementSource.bloodTest);

    await horses.deleteHorsePermanently(horseId);
    expect(await db.select(db.feedPlans).get(), isEmpty);
    expect(await db.select(db.feedMeals).get(), isEmpty);
    expect(await db.select(db.feedSupplementsTemporary).get(), isEmpty);
    expect(
      await db.select(db.feedItems).get(),
      hasLength(1),
      reason: 'Futtermittel gehören allen Pferden',
    );
  });
}
