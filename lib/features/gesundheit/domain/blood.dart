import '../../../core/time/local_date.dart';

/// Abweichungsrichtung eines Blutwerts.
enum Direction {
  low('low'),
  high('high');

  const Direction(this.key);
  final String key;

  static Direction? fromKey(String? k) {
    for (final d in values) {
      if (d.key == k) return d;
    }
    return null;
  }
}

/// Saisonaler Grenzwert (z. B. ACTH).
class SeasonalLimit {
  const SeasonalLimit(this.months, this.high, this.strongHigh);
  final Set<int> months;
  final double high;
  final double? strongHigh;
}

/// Ein Blutwert mit Referenzbereich (Laboklin, adulte Pferde).
class BloodParameter {
  const BloodParameter({
    required this.key,
    required this.name,
    required this.group,
    required this.unit,
    required this.category,
    this.low,
    this.high,
    this.aliases = const [],
    this.strongLow,
    this.strongHigh,
    this.note,
    this.seasonal = const [],
    this.summaryByParameter = false,
  });

  final String key;
  final String name;
  final String group;
  final String unit;
  final String category;
  final double? low;
  final double? high;
  final List<String> aliases;

  /// Ab hier „deutlich“ zu niedrig/zu hoch (sonst Faktor 0,5 bzw. 2).
  final double? strongLow;
  final double? strongHigh;
  final String? note;
  final List<SeasonalLimit> seasonal;

  /// Kurzinfo nennt den Wert selbst („Selen zu niedrig“) statt der
  /// Kategorie („Leberwerte erhöht“).
  final bool summaryByParameter;

  /// Obergrenze, ggf. saisonal nach Monat [month].
  (double?, double?) highFor(int month) {
    for (final s in seasonal) {
      if (s.months.contains(month)) return (s.high, s.strongHigh);
    }
    return (high, strongHigh);
  }
}

/// Art eines Vorschlags.
enum SuggestionKind { supplement, ration, management, care }

/// Futter-Baustein bzw. Maßnahme (ohne Marken).
class BloodSuggestion {
  const BloodSuggestion({
    required this.key,
    required this.kind,
    required this.title,
    required this.text,
    this.itemName,
    this.itemCategory,
    this.itemUnit,
    this.weeks,
    this.careType,
    this.careTitle,
    this.inDays,
  });

  final String key;
  final SuggestionKind kind;
  final String title;
  final String text;

  /// Für `supplement`: Futtermittel, das angelegt wird.
  final String? itemName;
  final String? itemCategory;
  final String? itemUnit;

  /// Dauer des Zusatzes in Wochen.
  final int? weeks;

  /// Für `care`: Eintragsart und Titel des Pflegetermins.
  final String? careType;
  final String? careTitle;
  final int? inDays;
}

class BloodRule {
  const BloodRule({
    required this.param,
    required this.direction,
    required this.text,
    this.suggestions = const [],
    this.vetFirst = false,
    this.vetIfStrong = true,
    this.controlWeeks,
  });

  final String param;
  final Direction direction;
  final String text;
  final List<String> suggestions;
  final bool vetFirst;
  final bool vetIfStrong;
  final int? controlWeeks;
}

typedef Condition = (String param, Direction direction);

/// Muster aus mehreren Werten (z. B. GLDH + γ-GT erhöht).
class BloodCombo {
  const BloodCombo({
    required this.id,
    required this.title,
    required this.text,
    required this.category,
    this.all = const [],
    this.any = const [],
    this.none = const [],
    this.vetFirst = false,
    this.suggestions = const [],
  });

  final String id;
  final String title;
  final String text;
  final String category;
  final List<Condition> all;
  final List<Condition> any;
  final List<Condition> none;
  final bool vetFirst;
  final List<String> suggestions;
}

/// Inhalt von `assets/blood_reference.json`.
class BloodCatalog {
  const BloodCatalog({
    required this.source,
    required this.disclaimer,
    required this.groups,
    required this.categories,
    required this.parameters,
    required this.suggestions,
    required this.rules,
    required this.combos,
  });

  final String source;
  final String disclaimer;

  /// Schlüssel → Anzeigename, in Reihenfolge.
  final List<(String, String)> groups;
  final Map<String, String> categories;
  final List<BloodParameter> parameters;
  final Map<String, BloodSuggestion> suggestions;
  final List<BloodRule> rules;
  final List<BloodCombo> combos;

  BloodParameter? parameter(String key) {
    for (final p in parameters) {
      if (p.key == key) return p;
    }
    return null;
  }

  static BloodCatalog fromJson(Map<String, Object?> j) {
    double? d(Object? v) => v is num ? v.toDouble() : null;
    List<String> strings(Object? v) => v is List
        ? [
            for (final e in v)
              if (e is String) e,
          ]
        : const [];
    List<Map<String, Object?>> maps(Object? v) => [
      if (v is List)
        for (final e in v)
          if (e is Map) e.cast<String, Object?>(),
    ];
    List<Condition> conds(Object? v) => [
      if (v is List)
        for (final c in v)
          if (c is List &&
              c.length == 2 &&
              c[0] is String &&
              Direction.fromKey(c[1] as String?) != null)
            (c[0] as String, Direction.fromKey(c[1] as String?)!),
    ];

    final sugg = <String, BloodSuggestion>{};
    final rawS = j['suggestions'];
    if (rawS is Map) {
      for (final MapEntry(:key, :value) in rawS.entries) {
        if (key is! String || value is! Map) continue;
        final m = value.cast<String, Object?>();
        final item = m['item'] is Map
            ? (m['item'] as Map).cast<String, Object?>()
            : null;
        sugg[key] = BloodSuggestion(
          key: key,
          kind: SuggestionKind.values.firstWhere(
            (k) => k.name == m['kind'],
            orElse: () => SuggestionKind.management,
          ),
          title: m['title'] as String? ?? key,
          text: m['text'] as String? ?? '',
          itemName: item?['name'] as String?,
          itemCategory: item?['category'] as String?,
          itemUnit: item?['unit'] as String?,
          weeks: (m['weeks'] as num?)?.toInt(),
          careType: m['careType'] as String?,
          careTitle: m['careTitle'] as String?,
          inDays: (m['inDays'] as num?)?.toInt(),
        );
      }
    }

    return BloodCatalog(
      source: j['source'] as String? ?? '',
      disclaimer: j['disclaimer'] as String? ?? '',
      groups: [
        for (final g in maps(j['groups']))
          (g['key'] as String, g['name'] as String? ?? ''),
      ],
      categories: {
        if (j['categories'] is Map)
          for (final MapEntry(:key, :value) in (j['categories'] as Map).entries)
            if (key is String && value is String) key: value,
      },
      parameters: [
        for (final m in maps(j['parameters']))
          BloodParameter(
            key: m['key'] as String,
            name: m['name'] as String,
            group: m['group'] as String,
            unit: m['unit'] as String? ?? '',
            category: m['category'] as String? ?? '',
            low: d(m['low']),
            high: d(m['high']),
            aliases: strings(m['aliases']),
            strongLow: d(m['strongLow']),
            strongHigh: d(m['strongHigh']),
            note: m['note'] as String?,
            summaryByParameter: m['summary'] == 'parameter',
            seasonal: [
              for (final s in maps(m['seasonalHigh']))
                SeasonalLimit(
                  {
                    for (final x in (s['months'] as List? ?? const []))
                      if (x is num) x.toInt(),
                  },
                  d(s['high']) ?? 0,
                  d(s['strongHigh']),
                ),
            ],
          ),
      ],
      suggestions: sugg,
      rules: [
        for (final m in maps(j['rules']))
          if (Direction.fromKey(m['direction'] as String?) case final dir?)
            BloodRule(
              param: m['param'] as String,
              direction: dir,
              text: m['text'] as String? ?? '',
              suggestions: strings(m['suggestions']),
              vetFirst: m['vetFirst'] == true,
              vetIfStrong: m['vetIfStrong'] != false,
              controlWeeks: (m['controlWeeks'] as num?)?.toInt(),
            ),
      ],
      combos: [
        for (final m in maps(j['combos']))
          BloodCombo(
            id: m['id'] as String,
            title: m['title'] as String? ?? '',
            text: m['text'] as String? ?? '',
            category: m['category'] as String? ?? '',
            all: conds(m['all']),
            any: conds(m['any']),
            none: conds(m['none']),
            vetFirst: m['vet'] == true,
            suggestions: strings(m['suggestions']),
          ),
      ],
    );
  }
}

/// Ein eingetragener (abweichender) Wert. Eigene Grenzen vom Befund
/// überschreiben die hinterlegten Referenzwerte.
class BloodValue {
  const BloodValue({
    required this.paramKey,
    required this.value,
    this.refLow,
    this.refHigh,
  });

  final String paramKey;
  final double value;
  final double? refLow;
  final double? refHigh;
}

/// Ein Blutbild (Befund) eines Pferdes.
class BloodTest {
  const BloodTest({
    required this.id,
    required this.horseId,
    required this.date,
    this.lab,
    this.notes,
    this.values = const [],
  });

  final String id;
  final String horseId;
  final LocalDate date;
  final String? lab;
  final String? notes;

  /// Nur eingetragene Werte; alle anderen gelten als im Referenzbereich.
  final List<BloodValue> values;
}
