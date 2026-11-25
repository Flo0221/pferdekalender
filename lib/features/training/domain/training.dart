import '../../../core/time/local_date.dart';

/// Trainingsziel. Der [key] wird gespeichert und ist Schlüssel in der
/// Vorlagen-Datei (`goals`).
enum TrainingGoal {
  muskelaufbau('muskelaufbau'),
  muskelerhalt('muskelerhalt'),
  kondition('kondition'),
  wiedereinstieg('wiedereinstieg');

  const TrainingGoal(this.key);
  final String key;

  static TrainingGoal fromKey(String? key) => values.firstWhere(
    (g) => g.key == key,
    orElse: () => TrainingGoal.muskelerhalt,
  );
}

/// Status einer Einheit. Der [key] wird gespeichert.
enum SessionStatus {
  planned('planned'),
  done('done'),
  cancelled('cancelled');

  const SessionStatus(this.key);
  final String key;

  static SessionStatus fromKey(String? key) =>
      values.firstWhere((s) => s.key == key, orElse: () => planned);
}

/// Ablauf einer Einheit: Aufwärmen, Arbeitsphase, Abwärmen.
class SessionContent {
  const SessionContent({
    this.warmup = const [],
    this.work = const [],
    this.cooldown = const [],
    this.pauseHint,
  });

  final List<String> warmup;
  final List<String> work;
  final List<String> cooldown;
  final String? pauseHint;

  bool get isEmpty => warmup.isEmpty && work.isEmpty && cooldown.isEmpty;

  Map<String, Object?> toJson() => {
    'warmup': warmup,
    'work': work,
    'cooldown': cooldown,
    'pauseHint': ?pauseHint,
  };

  static SessionContent fromJson(Object? json) {
    if (json is! Map) return const SessionContent();
    List<String> list(Object? v) => v is List
        ? [
            for (final e in v)
              if (e is String) e,
          ]
        : const [];
    return SessionContent(
      warmup: list(json['warmup']),
      work: list(json['work']),
      cooldown: list(json['cooldown']),
      pauseHint: json['pauseHint'] is String
          ? json['pauseHint'] as String
          : null,
    );
  }
}

/// Warum eine Einheit an diesem Tag liegt (wird in der UI in Text gefasst).
class SessionReason {
  const SessionReason({
    this.availableMinutes,
    this.shiftName,
    this.assumedMinutes = false,
    this.daysSinceIntensive,
    this.afterNightShift = false,
    this.downgradedFrom,
    this.activePause = false,
    this.intensive = false,
    this.recoveryAfterHigh = false,
  });

  /// Stallzeit für dieses Pferd an dem Tag (nach Aufteilung).
  final int? availableMinutes;
  final String? shiftName;

  /// Kein Dienstplan-Eintrag – Standardzeit angenommen.
  final bool assumedMinutes;

  /// Tage seit der letzten intensiven Einheit (Stufe ≥ 4), falls bekannt.
  final int? daysSinceIntensive;
  final bool afterNightShift;

  /// Geplante Stufe, die mangels passender Einheit gesenkt wurde.
  final int? downgradedFrom;
  final bool activePause;

  /// Auf einen Tag mit viel Zeit gelegt, weil intensiv.
  final bool intensive;

  /// Nach einer Stufe-5-Einheit bewusst leicht gehalten.
  final bool recoveryAfterHigh;

  Map<String, Object?> toJson() => {
    'availableMinutes': ?availableMinutes,
    'shiftName': ?shiftName,
    if (assumedMinutes) 'assumedMinutes': true,
    'daysSinceIntensive': ?daysSinceIntensive,
    if (afterNightShift) 'afterNightShift': true,
    'downgradedFrom': ?downgradedFrom,
    if (activePause) 'activePause': true,
    if (intensive) 'intensive': true,
    if (recoveryAfterHigh) 'recoveryAfterHigh': true,
  };

  static SessionReason? fromJson(Object? json) {
    if (json is! Map) return null;
    int? i(String k) => json[k] is int ? json[k] as int : null;
    bool b(String k) => json[k] == true;
    return SessionReason(
      availableMinutes: i('availableMinutes'),
      shiftName: json['shiftName'] is String
          ? json['shiftName'] as String
          : null,
      assumedMinutes: b('assumedMinutes'),
      daysSinceIntensive: i('daysSinceIntensive'),
      afterNightShift: b('afterNightShift'),
      downgradedFrom: i('downgradedFrom'),
      activePause: b('activePause'),
      intensive: b('intensive'),
      recoveryAfterHigh: b('recoveryAfterHigh'),
    );
  }
}

/// Eine Trainingseinheit (geplant, erledigt oder ausgefallen).
class TrainingSession {
  const TrainingSession({
    required this.id,
    required this.horseId,
    required this.date,
    required this.level,
    required this.durationMinutes,
    required this.title,
    this.planId,
    this.unitKey,
    this.form,
    this.content = const SessionContent(),
    this.status = SessionStatus.planned,
    this.rating,
    this.notes,
    this.pinned = false,
    this.reason,
  });

  final String id;
  final String? planId;
  final String horseId;
  final LocalDate date;

  /// Vorlage aus der JSON-Datei (`units[].key`), bei manuellen Einheiten optional.
  final String? unitKey;

  /// Trainingsform (`forms[].key`).
  final String? form;

  /// Belastungsstufe 0–5.
  final int level;
  final int durationMinutes;
  final String title;
  final SessionContent content;
  final SessionStatus status;

  /// Gefühl nach dem Training 1–5.
  final int? rating;
  final String? notes;

  /// Manuell verschoben/angelegt – bleibt beim Neu-Verteilen fixiert.
  final bool pinned;
  final SessionReason? reason;

  TrainingSession copyWith({
    String? id,
    String? planId,
    LocalDate? date,
    int? level,
    int? durationMinutes,
    String? title,
    String? unitKey,
    String? form,
    SessionContent? content,
    SessionStatus? status,
    int? rating,
    bool clearRating = false,
    String? notes,
    bool? pinned,
    SessionReason? reason,
    bool clearReason = false,
  }) => TrainingSession(
    id: id ?? this.id,
    planId: planId ?? this.planId,
    horseId: horseId,
    date: date ?? this.date,
    level: level ?? this.level,
    durationMinutes: durationMinutes ?? this.durationMinutes,
    title: title ?? this.title,
    unitKey: unitKey ?? this.unitKey,
    form: form ?? this.form,
    content: content ?? this.content,
    status: status ?? this.status,
    rating: clearRating ? null : (rating ?? this.rating),
    notes: notes ?? this.notes,
    pinned: pinned ?? this.pinned,
    reason: clearReason ? null : (reason ?? this.reason),
  );
}

/// Eingaben des Plan-Generators (werden mit dem Plan gespeichert).
class TrainingParams {
  const TrainingParams({
    required this.goal,
    required this.fitness,
    required this.daysPerWeek,
    required this.weeks,
    required this.startDate,
    required this.forms,
    this.exclusions = const {},
    this.restrictions,
    this.sharePercent = 100,
    this.bufferMinutes = 20,
    this.defaultMinutes = 60,
  });

  final TrainingGoal goal;

  /// Aktueller Fitnessstand 1–5.
  final int fitness;

  /// Gewünschte Trainingstage pro Woche (3–6).
  final int daysPerWeek;

  /// Planlänge: 4, 6, 8 oder 12 Wochen.
  final int weeks;
  final LocalDate startDate;

  /// Verfügbare Trainingsformen (`forms[].key`).
  final Set<String> forms;

  /// Ausgeschlossene Tags (z. B. `galopp`, `sprung`).
  final Set<String> exclusions;

  /// Einschränkungen als Freitext – wird nur angezeigt.
  final String? restrictions;

  /// Anteil der Stallzeit für dieses Pferd (bei mehreren Pferden), in %.
  final int sharePercent;

  /// Puffer für Putzen/Satteln (Minuten).
  final int bufferMinutes;

  /// Angenommene Stallzeit, wenn für einen Tag kein Dienstplan existiert.
  final int defaultMinutes;

  LocalDate get endDate => startDate.addDays(weeks * 7 - 1);

  Map<String, Object?> toJson() => {
    'goal': goal.key,
    'fitness': fitness,
    'daysPerWeek': daysPerWeek,
    'weeks': weeks,
    'startDate': startDate.toIso(),
    'forms': (forms.toList()..sort()),
    'exclusions': (exclusions.toList()..sort()),
    'restrictions': ?restrictions,
    'sharePercent': sharePercent,
    'bufferMinutes': bufferMinutes,
    'defaultMinutes': defaultMinutes,
  };

  static TrainingParams fromJson(Map<String, Object?> j) {
    int i(String k, int d) => j[k] is int ? j[k] as int : d;
    Set<String> set(String k) => j[k] is List
        ? {
            for (final e in j[k] as List)
              if (e is String) e,
          }
        : <String>{};
    return TrainingParams(
      goal: TrainingGoal.fromKey(j['goal'] as String?),
      fitness: i('fitness', 3),
      daysPerWeek: i('daysPerWeek', 4),
      weeks: i('weeks', 6),
      startDate: LocalDate.parse(j['startDate'] as String),
      forms: set('forms'),
      exclusions: set('exclusions'),
      restrictions: j['restrictions'] as String?,
      sharePercent: i('sharePercent', 100),
      bufferMinutes: i('bufferMinutes', 20),
      defaultMinutes: i('defaultMinutes', 60),
    );
  }
}

/// Ein gespeicherter Trainingsplan.
class TrainingPlan {
  const TrainingPlan({
    required this.id,
    required this.horseId,
    required this.params,
    this.active = true,
    this.distributedAt,
  });

  final String id;
  final String horseId;
  final TrainingParams params;
  final bool active;

  /// Zeitpunkt der letzten Verteilung (für „Dienstplan geändert“-Hinweis).
  final DateTime? distributedAt;
}
