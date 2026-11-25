import 'package:flutter_test/flutter_test.dart';
import 'package:pferdekalender/core/time/local_date.dart';
import 'package:pferdekalender/features/futter/domain/feed.dart';
import 'package:pferdekalender/features/futter/domain/feed_logic.dart';

void main() {
  FeedPlan plan(String id, LocalDate from, {double kraft = 1}) => FeedPlan(
    id: id,
    horseId: 'h',
    name: id,
    validFrom: from,
    meals: [
      Meal(
        id: '$id-m',
        name: 'Morgens',
        timeMinutes: 7 * 60,
        entries: [
          const MealEntry(id: 'e1', itemId: 'heu', amount: 4),
          MealEntry(
            id: 'e2',
            itemId: 'kraft',
            amount: kraft,
            variant: FeedVariant.trainingDay,
          ),
          const MealEntry(
            id: 'e3',
            itemId: 'kraft',
            amount: 0.5,
            variant: FeedVariant.restDay,
          ),
        ],
      ),
      Meal(
        id: '$id-a',
        name: 'Abends',
        timeMinutes: 18 * 60,
        entries: const [MealEntry(id: 'e4', itemId: 'heu', amount: 5)],
      ),
    ],
  );

  final sommer = plan('sommer', LocalDate(2026, 5, 1));
  final winter = plan('winter', LocalDate(2026, 11, 1), kraft: 1.5);

  test('gültige Version nach Datum (Historie bleibt)', () {
    expect(planOn([sommer, winter], LocalDate(2026, 4, 30)), isNull);
    expect(planOn([sommer, winter], LocalDate(2026, 10, 31))!.id, 'sommer');
    expect(planOn([winter, sommer], LocalDate(2026, 11, 1))!.id, 'winter');
    expect(planOn([sommer, winter], LocalDate(2027, 2, 1))!.id, 'winter');
  });

  test('Trainingstag vs. Ruhetag und Tagessumme', () {
    final day = LocalDate(2026, 11, 25);
    final t = rationFor(
      date: day,
      plans: [sommer, winter],
      supplements: const [],
      trainingDay: true,
    );
    expect(t.totals, {'heu': 9, 'kraft': 1.5});
    final r = rationFor(
      date: day,
      plans: [sommer, winter],
      supplements: const [],
      trainingDay: false,
    );
    expect(r.totals, {'heu': 9, 'kraft': 0.5});
    expect(r.meals.map((m) => m.name), ['Morgens', 'Abends']);
  });

  test('Zusätze nur im Zeitraum, zur Mahlzeit oder täglich', () {
    final kur = TemporarySupplement(
      id: 's1',
      horseId: 'h',
      itemId: 'leber',
      amount: 30,
      mealName: 'abends',
      start: LocalDate(2026, 11, 1),
      end: LocalDate(2026, 12, 12),
    );
    final selen = TemporarySupplement(
      id: 's2',
      horseId: 'h',
      itemId: 'selen',
      start: LocalDate(2026, 11, 1),
      end: LocalDate(2026, 11, 30),
    );
    final within = rationFor(
      date: LocalDate(2026, 11, 25),
      plans: [winter],
      supplements: [kur, selen],
      trainingDay: false,
    );
    final abends = within.meals.firstWhere((m) => m.name == 'Abends');
    expect(abends.lines.any((l) => l.itemId == 'leber' && l.temporary), isTrue);
    expect(within.daily.single.itemId, 'selen');
    expect(within.daily.single.amount, isNull, reason: 'laut Packungsangabe');
    expect(within.totals.containsKey('selen'), isFalse);
    expect(within.totals['leber'], 30);

    final after = rationFor(
      date: LocalDate(2026, 12, 13),
      plans: [winter],
      supplements: [kur, selen],
      trainingDay: false,
    );
    expect(after.totals.containsKey('leber'), isFalse);
    expect(after.daily, isEmpty);
    // Letzter Tag zählt noch dazu.
    expect(kur.activeOn(LocalDate(2026, 12, 12)), isTrue);
  });

  test('Zusatz zu einer Mahlzeit, die es nicht gibt → täglich', () {
    final s = TemporarySupplement(
      id: 's',
      horseId: 'h',
      itemId: 'x',
      amount: 1,
      mealName: 'Mittags',
      start: LocalDate(2026, 1, 1),
      end: LocalDate(2026, 12, 31),
    );
    final r = rationFor(
      date: LocalDate(2026, 11, 25),
      plans: [winter],
      supplements: [s],
      trainingDay: true,
    );
    expect(r.daily.single.itemId, 'x');
  });

  test('Vorrat: Reichweite und „knapp“', () {
    const heu = FeedItem(
      id: 'heu',
      name: 'Heu',
      category: FeedCategory.raufutter,
      unit: FeedUnit.kg,
      stock: 100,
      lowStockThreshold: 120,
    );
    expect(daysOfStockLeft(heu, 9), 11);
    expect(isLowStock(heu), isTrue);
    const ohne = FeedItem(
      id: 'x',
      name: 'X',
      category: FeedCategory.oel,
      unit: FeedUnit.ml,
    );
    expect(daysOfStockLeft(ohne, 5), isNull);
    expect(isLowStock(ohne), isFalse);
  });

  test('Durchschnittsverbrauch mit Trainings- und Ruhetagen', () {
    final from = LocalDate(2026, 11, 23); // Mo
    final use = averageDailyUse(
      from: from,
      days: 7,
      plans: [winter],
      supplements: const [],
      isTrainingDay: (d) => d.weekday <= 4, // Mo–Do Training
    );
    expect(use['heu'], 9);
    expect(use['kraft'], closeTo((4 * 1.5 + 3 * 0.5) / 7, 1e-9));
  });

  test('neue Version ist eine Kopie mit neuen IDs', () {
    var n = 0;
    final copy = copyPlanAsNewVersion(
      winter,
      LocalDate(2027, 3, 1),
      () => 'id${n++}',
      name: 'Frühjahr',
    );
    expect(copy.validFrom, LocalDate(2027, 3, 1));
    expect(copy.name, 'Frühjahr');
    expect(copy.id, isNot(winter.id));
    expect(copy.meals.first.id, isNot(winter.meals.first.id));
    expect(copy.meals.first.entries.length, winter.meals.first.entries.length);
    expect(copy.meals.first.entries[1].variant, FeedVariant.trainingDay);
  });
}
