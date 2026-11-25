import '../../../core/time/local_date.dart';
import 'feed.dart';

/// Gültige Planversion an [date]: die mit dem spätesten `validFrom` ≤ [date].
FeedPlan? planOn(Iterable<FeedPlan> plans, LocalDate date) {
  FeedPlan? best;
  for (final p in plans) {
    if (p.validFrom.isAfter(date)) continue;
    if (best == null || p.validFrom.isAfter(best.validFrom)) best = p;
  }
  return best;
}

/// Eine Zeile der Tagesration.
class RationLine {
  const RationLine({
    required this.itemId,
    required this.amount,
    this.temporary = false,
    this.supplementId,
    this.variant = FeedVariant.always,
  });

  final String itemId;

  /// `null` = laut Packungsangabe.
  final double? amount;
  final bool temporary;
  final String? supplementId;
  final FeedVariant variant;
}

/// Eine Mahlzeit der Tagesration.
class RationMeal {
  const RationMeal({required this.name, this.timeMinutes, required this.lines});
  final String name;
  final int? timeMinutes;
  final List<RationLine> lines;
}

/// Ration eines Tages (Plan + passende Variante + aktive Zusätze).
class DayRation {
  const DayRation({
    required this.date,
    required this.plan,
    required this.trainingDay,
    required this.meals,
    required this.daily,
  });

  final LocalDate date;
  final FeedPlan? plan;
  final bool trainingDay;
  final List<RationMeal> meals;

  /// Zusätze ohne Mahlzeit (einmal täglich).
  final List<RationLine> daily;

  /// Tagessumme je Futtermittel (nur Positionen mit Menge).
  Map<String, double> get totals {
    final t = <String, double>{};
    for (final l in [for (final m in meals) ...m.lines, ...daily]) {
      if (l.amount == null) continue;
      t[l.itemId] = (t[l.itemId] ?? 0) + l.amount!;
    }
    return t;
  }
}

/// Berechnet die Ration für [date].
///
/// - Planversion nach `validFrom`.
/// - Positionen „Trainingstag“/„Ruhetag“ je nach [trainingDay].
/// - Zeitlich begrenzte Zusätze nur im Zeitraum; mit Mahlzeitname werden sie
///   dieser Mahlzeit zugeordnet (fehlt sie, landen sie bei „täglich“).
DayRation rationFor({
  required LocalDate date,
  required Iterable<FeedPlan> plans,
  required Iterable<TemporarySupplement> supplements,
  required bool trainingDay,
}) {
  final plan = planOn(plans, date);
  final meals = <RationMeal>[];
  final mealsSorted = [...?plan?.meals]
    ..sort((a, b) {
      final ta = a.timeMinutes ?? 24 * 60, tb = b.timeMinutes ?? 24 * 60;
      return ta != tb ? ta.compareTo(tb) : a.sortOrder.compareTo(b.sortOrder);
    });
  final active = supplements.where((s) => s.activeOn(date)).toList();
  final placed = <String>{};
  for (final m in mealsSorted) {
    final lines = <RationLine>[
      for (final e in m.entries)
        if (e.variant.appliesTo(trainingDay: trainingDay))
          RationLine(itemId: e.itemId, amount: e.amount, variant: e.variant),
      for (final s in active)
        if (s.mealName != null &&
            s.mealName!.trim().toLowerCase() == m.name.trim().toLowerCase())
          RationLine(
            itemId: s.itemId,
            amount: s.amount,
            temporary: true,
            supplementId: s.id,
          ),
    ];
    for (final l in lines) {
      if (l.supplementId != null) placed.add(l.supplementId!);
    }
    meals.add(
      RationMeal(name: m.name, timeMinutes: m.timeMinutes, lines: lines),
    );
  }
  final daily = [
    for (final s in active)
      if (!placed.contains(s.id))
        RationLine(
          itemId: s.itemId,
          amount: s.amount,
          temporary: true,
          supplementId: s.id,
        ),
  ];
  return DayRation(
    date: date,
    plan: plan,
    trainingDay: trainingDay,
    meals: meals,
    daily: daily,
  );
}

/// Wie lange reicht der Vorrat bei durchschnittlichem Tagesverbrauch?
/// `null`, wenn kein Vorrat gepflegt oder kein Verbrauch.
int? daysOfStockLeft(FeedItem item, double dailyUse) {
  if (item.stock == null || dailyUse <= 0) return null;
  return (item.stock! / dailyUse).floor();
}

/// „Vorrat wird knapp“: Vorrat ≤ Schwelle (wenn gesetzt).
bool isLowStock(FeedItem item) =>
    item.stock != null &&
    item.lowStockThreshold != null &&
    item.stock! <= item.lowStockThreshold!;

/// Durchschnittlicher Tagesverbrauch je Futtermittel über [days] Tage ab
/// [from] (berücksichtigt Trainings-/Ruhetage und Zusätze).
Map<String, double> averageDailyUse({
  required LocalDate from,
  required int days,
  required Iterable<FeedPlan> plans,
  required Iterable<TemporarySupplement> supplements,
  required bool Function(LocalDate) isTrainingDay,
}) {
  final sum = <String, double>{};
  for (var i = 0; i < days; i++) {
    final d = from.addDays(i);
    final r = rationFor(
      date: d,
      plans: plans,
      supplements: supplements,
      trainingDay: isTrainingDay(d),
    );
    r.totals.forEach((k, v) => sum[k] = (sum[k] ?? 0) + v);
  }
  return {for (final e in sum.entries) e.key: e.value / days};
}

/// Kopie einer Planversion als neue Version ab [validFrom] (neue IDs über
/// [newId]); so bleibt die Historie erhalten.
FeedPlan copyPlanAsNewVersion(
  FeedPlan plan,
  LocalDate validFrom,
  String Function() newId, {
  String? name,
}) => FeedPlan(
  id: newId(),
  horseId: plan.horseId,
  name: name ?? plan.name,
  validFrom: validFrom,
  notes: plan.notes,
  meals: [
    for (final m in plan.meals)
      Meal(
        id: newId(),
        name: m.name,
        timeMinutes: m.timeMinutes,
        sortOrder: m.sortOrder,
        entries: [
          for (final e in m.entries)
            MealEntry(
              id: newId(),
              itemId: e.itemId,
              amount: e.amount,
              variant: e.variant,
            ),
        ],
      ),
  ],
);
