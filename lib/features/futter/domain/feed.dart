import '../../../core/time/local_date.dart';

/// Kategorie eines Futtermittels. Der [key] wird gespeichert.
enum FeedCategory {
  raufutter('raufutter'),
  kraftfutter('kraftfutter'),
  mineralfutter('mineralfutter'),
  ergaenzung('ergaenzung'),
  oel('oel'),
  leckerli('leckerli'),
  medikament('medikament');

  const FeedCategory(this.key);
  final String key;

  static FeedCategory fromKey(String? key) => values.firstWhere(
    (c) => c.key == key,
    orElse: () => FeedCategory.ergaenzung,
  );
}

/// Einheit einer Futtermenge. Der [key] wird gespeichert.
enum FeedUnit {
  kg('kg'),
  g('g'),
  ml('ml'),
  messbecher('messbecher'),
  stueck('stueck'),
  liter('liter');

  const FeedUnit(this.key);
  final String key;

  static FeedUnit fromKey(String? key) =>
      values.firstWhere((u) => u.key == key, orElse: () => FeedUnit.g);
}

/// Für welche Tage eine Futterposition gilt. Der [key] wird gespeichert.
enum FeedVariant {
  always('always'),
  trainingDay('training'),
  restDay('rest');

  const FeedVariant(this.key);
  final String key;

  static FeedVariant fromKey(String? key) =>
      values.firstWhere((v) => v.key == key, orElse: () => always);

  bool appliesTo({required bool trainingDay}) => switch (this) {
    always => true,
    FeedVariant.trainingDay => trainingDay,
    restDay => !trainingDay,
  };
}

/// Ein Futtermittel (für alle Pferde gemeinsam).
class FeedItem {
  const FeedItem({
    required this.id,
    required this.name,
    required this.category,
    required this.unit,
    this.notes,
    this.stock,
    this.lowStockThreshold,
    this.archived = false,
  });

  final String id;
  final String name;
  final FeedCategory category;
  final FeedUnit unit;
  final String? notes;

  /// Aktueller Vorrat in [unit] (optional).
  final double? stock;

  /// Ab diesem Vorrat erscheint „Vorrat wird knapp“.
  final double? lowStockThreshold;
  final bool archived;
}

/// Eine Position in einer Mahlzeit.
class MealEntry {
  const MealEntry({
    required this.id,
    required this.itemId,
    required this.amount,
    this.variant = FeedVariant.always,
  });

  final String id;
  final String itemId;
  final double amount;
  final FeedVariant variant;
}

/// Eine Mahlzeit (z. B. „Morgens 7:00“).
class Meal {
  const Meal({
    required this.id,
    required this.name,
    this.timeMinutes,
    this.entries = const [],
    this.sortOrder = 0,
  });

  final String id;
  final String name;
  final int? timeMinutes;
  final List<MealEntry> entries;
  final int sortOrder;
}

/// Eine Version des Futterplans eines Pferdes, gültig ab [validFrom].
class FeedPlan {
  const FeedPlan({
    required this.id,
    required this.horseId,
    required this.name,
    required this.validFrom,
    this.notes,
    this.meals = const [],
  });

  final String id;
  final String horseId;

  /// z. B. „Winter-Ration“.
  final String name;
  final LocalDate validFrom;
  final String? notes;
  final List<Meal> meals;
}

/// Herkunft eines Zusatzes. Der [key] wird gespeichert.
enum SupplementSource {
  manual('manual'),
  bloodTest('blood');

  const SupplementSource(this.key);
  final String key;

  static SupplementSource fromKey(String? key) =>
      key == bloodTest.key ? bloodTest : manual;
}

/// Zeitlich begrenzter Zusatz (z. B. „Kur für 6 Wochen“).
class TemporarySupplement {
  const TemporarySupplement({
    required this.id,
    required this.horseId,
    required this.itemId,
    required this.start,
    required this.end,
    this.amount,
    this.mealName,
    this.note,
    this.source = SupplementSource.manual,
    this.bloodTestId,
  });

  final String id;
  final String horseId;
  final String itemId;

  /// `null` = „laut Packungsangabe“.
  final double? amount;

  /// Zu welcher Mahlzeit (Name); `null` = einmal täglich.
  final String? mealName;
  final LocalDate start;
  final LocalDate end;
  final String? note;
  final SupplementSource source;
  final String? bloodTestId;

  bool activeOn(LocalDate d) => !d.isBefore(start) && !d.isAfter(end);
}
