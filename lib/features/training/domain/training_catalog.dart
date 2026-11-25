import 'training.dart';

/// Belastungsstufe aus der Vorlagen-Datei.
class LevelInfo {
  const LevelInfo(this.level, this.name, this.loadPerTenMinutes);
  final int level;
  final String name;
  final double loadPerTenMinutes;
}

class FormInfo {
  const FormInfo(this.key, this.name);
  final String key;
  final String name;
}

class ExclusionInfo {
  const ExclusionInfo(this.tag, this.name);
  final String tag;
  final String name;
}

/// Intervall-Angaben einer Einheit (z. B. 3 min Trab / 1 min Schritt).
class IntervalSpec {
  const IntervalSpec(this.baseWorkMinutes, this.restMinutes);
  final double baseWorkMinutes;
  final double restMinutes;
}

/// Eine Einheiten-Vorlage.
class TrainingUnit {
  const TrainingUnit({
    required this.key,
    required this.name,
    required this.level,
    required this.form,
    required this.minMinutes,
    required this.defaultMinutes,
    required this.maxMinutes,
    this.tags = const {},
    this.exercises = const [],
    this.interval,
  });

  final String key;
  final String name;
  final int level;
  final String form;
  final int minMinutes;
  final int defaultMinutes;
  final int maxMinutes;
  final Set<String> tags;
  final List<String> exercises;
  final IntervalSpec? interval;
}

/// Ziel-Parameter (Progression, Entlastung, Stufen).
class GoalConfig {
  const GoalConfig({
    required this.progressionPerWeek,
    required this.deloadEvery,
    required this.deloadFactor,
    required this.maxLevel,
    required this.minLevel,
    required this.highDaysByFitness,
    required this.level5MinFitness,
    required this.level5PerWeek,
    this.maxDaysPerWeek,
    this.levelCapByWeek = const [],
    this.maxMinutesByWeek = const [],
    this.noTrotWeeks = 0,
    this.intervalGrowthMinutesPerWeek = 0,
    this.preferredForms = const [],
  });

  final double progressionPerWeek;

  /// Jede n-te Woche Entlastung (0 = nie).
  final int deloadEvery;
  final double deloadFactor;
  final int maxLevel;
  final int minLevel;
  final Map<int, int> highDaysByFitness;
  final int level5MinFitness;
  final int level5PerWeek;
  final int? maxDaysPerWeek;

  /// Höchste Stufe je Woche (Index = Woche, letzter Wert gilt danach).
  final List<int> levelCapByWeek;
  final List<int> maxMinutesByWeek;

  /// In den ersten n Wochen nur Schritt (keine Einheiten mit Tag „trab“).
  final int noTrotWeeks;
  final double intervalGrowthMinutesPerWeek;
  final List<String> preferredForms;

  int levelCap(int week) {
    if (levelCapByWeek.isEmpty) return maxLevel;
    final cap = week < levelCapByWeek.length
        ? levelCapByWeek[week]
        : levelCapByWeek.last;
    return cap < maxLevel ? cap : maxLevel;
  }

  int? maxMinutes(int week) =>
      week < maxMinutesByWeek.length ? maxMinutesByWeek[week] : null;

  bool isDeload(int week) => deloadEvery > 0 && (week + 1) % deloadEvery == 0;
}

/// Inhalt von `assets/training_templates.json`.
class TrainingCatalog {
  const TrainingCatalog({
    required this.levels,
    required this.forms,
    required this.exclusions,
    required this.fitnessScale,
    required this.warmup,
    required this.warmupWalkOnly,
    required this.cooldown,
    required this.pauseHint,
    required this.goals,
    required this.units,
  });

  final Map<int, LevelInfo> levels;
  final List<FormInfo> forms;
  final List<ExclusionInfo> exclusions;
  final Map<int, double> fitnessScale;
  final List<String> warmup;
  final List<String> warmupWalkOnly;
  final List<String> cooldown;
  final String pauseHint;
  final Map<TrainingGoal, GoalConfig> goals;
  final List<TrainingUnit> units;

  double loadFactor(int level) =>
      levels[level]?.loadPerTenMinutes ?? level.toDouble();

  /// Belastungspunkte einer Einheit.
  double load(int level, int minutes) => loadFactor(level) * minutes / 10;

  TrainingUnit? unit(String? key) {
    for (final u in units) {
      if (u.key == key) return u;
    }
    return null;
  }

  String formName(String? key) {
    for (final f in forms) {
      if (f.key == key) return f.name;
    }
    return key ?? '';
  }

  /// Liest die (bereits mit `jsonDecode` geparste) Vorlagen-Datei.
  /// Wirft [FormatException] bei fehlenden Pflichtangaben.
  static TrainingCatalog fromJson(Map<String, Object?> json) {
    List<Map<String, Object?>> maps(String key) => [
      for (final e in (json[key] as List? ?? const []))
        if (e is Map) e.cast<String, Object?>(),
    ];
    List<String> strings(Object? v) => v is List
        ? [
            for (final e in v)
              if (e is String) e,
          ]
        : const [];
    int intOf(Map<String, Object?> m, String k, [int? d]) {
      final v = m[k];
      if (v is num) return v.toInt();
      if (d != null) return d;
      throw FormatException('Pflichtfeld fehlt: $k', m);
    }

    double numOf(Map<String, Object?> m, String k, double d) =>
        m[k] is num ? (m[k] as num).toDouble() : d;
    Map<int, T> intKeyed<T>(Object? v, T Function(Object?) f) => {
      if (v is Map)
        for (final MapEntry(:key, :value) in v.entries)
          ?int.tryParse('$key'): f(value),
    };

    final goals = <TrainingGoal, GoalConfig>{};
    final rawGoals = json['goals'];
    if (rawGoals is Map) {
      for (final g in TrainingGoal.values) {
        final m = rawGoals[g.key];
        if (m is! Map) continue;
        final c = m.cast<String, Object?>();
        goals[g] = GoalConfig(
          progressionPerWeek: numOf(c, 'progressionPerWeek', 0),
          deloadEvery: intOf(c, 'deloadEvery', 0),
          deloadFactor: numOf(c, 'deloadFactor', 1),
          maxLevel: intOf(c, 'maxLevel', 4),
          minLevel: intOf(c, 'minLevel', 2),
          highDaysByFitness: intKeyed(
            c['highDaysByFitness'],
            (v) => v is num ? v.toInt() : 1,
          ),
          level5MinFitness: intOf(c, 'level5MinFitness', 99),
          level5PerWeek: intOf(c, 'level5PerWeek', 0),
          maxDaysPerWeek: c['maxDaysPerWeek'] is num
              ? (c['maxDaysPerWeek'] as num).toInt()
              : null,
          levelCapByWeek: [
            for (final e in (c['levelCapByWeek'] as List? ?? const []))
              if (e is num) e.toInt(),
          ],
          maxMinutesByWeek: [
            for (final e in (c['maxMinutesByWeek'] as List? ?? const []))
              if (e is num) e.toInt(),
          ],
          noTrotWeeks: intOf(c, 'noTrotWeeks', 0),
          intervalGrowthMinutesPerWeek: numOf(
            c,
            'intervalGrowthMinutesPerWeek',
            0,
          ),
          preferredForms: strings(c['preferredForms']),
        );
      }
    }
    for (final g in TrainingGoal.values) {
      if (!goals.containsKey(g)) {
        throw FormatException('Ziel fehlt in der Vorlagen-Datei: ${g.key}');
      }
    }

    return TrainingCatalog(
      levels: {
        for (final m in maps('levels'))
          intOf(m, 'level'): LevelInfo(
            intOf(m, 'level'),
            m['name'] as String? ?? '',
            numOf(m, 'loadPerTenMinutes', intOf(m, 'level').toDouble()),
          ),
      },
      forms: [
        for (final m in maps('forms'))
          FormInfo(m['key'] as String, m['name'] as String? ?? ''),
      ],
      exclusions: [
        for (final m in maps('exclusions'))
          ExclusionInfo(m['tag'] as String, m['name'] as String? ?? ''),
      ],
      fitnessScale: intKeyed(
        json['fitnessScale'],
        (v) => v is num ? v.toDouble() : 1.0,
      ),
      warmup: strings(json['warmup']),
      warmupWalkOnly: strings(json['warmupWalkOnly']),
      cooldown: strings(json['cooldown']),
      pauseHint: json['pauseHint'] as String? ?? '',
      goals: goals,
      units: [
        for (final m in maps('units'))
          TrainingUnit(
            key: m['key'] as String,
            name: m['name'] as String? ?? '',
            level: intOf(m, 'level'),
            form: m['form'] as String,
            minMinutes: intOf(m, 'minMinutes'),
            defaultMinutes: intOf(m, 'defaultMinutes'),
            maxMinutes: intOf(m, 'maxMinutes'),
            tags: strings(m['tags']).toSet(),
            exercises: strings(m['exercises']),
            interval: m['interval'] is Map
                ? IntervalSpec(
                    numOf(
                      (m['interval'] as Map).cast<String, Object?>(),
                      'baseWorkMinutes',
                      3,
                    ),
                    numOf(
                      (m['interval'] as Map).cast<String, Object?>(),
                      'restMinutes',
                      1,
                    ),
                  )
                : null,
          ),
      ],
    );
  }
}
