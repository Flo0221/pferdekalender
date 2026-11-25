import '../../../core/time/local_date.dart';

/// Bevorzugte Tageszeit für den Stall. Der [key] wird gespeichert.
enum DayTime {
  morgens('morgens'),
  nachmittags('nachmittags'),
  abends('abends');

  const DayTime(this.key);
  final String key;

  static DayTime? fromKey(String? key) {
    for (final t in values) {
      if (t.key == key) return t;
    }
    return null;
  }
}

/// Eine Schichtvorlage (Früh, Spät, Nacht, Frei, Urlaub …).
class ShiftTemplate {
  const ShiftTemplate({
    required this.id,
    required this.name,
    required this.shortCode,
    required this.colorValue,
    required this.stableMinutes,
    this.startMinutes,
    this.endMinutes,
    this.preferredTime,
    this.isNight = false,
    this.archived = false,
    this.sortOrder = 0,
  });

  final String id;
  final String name;

  /// Kürzel im Kalender, z. B. „F“, „S“, „N“.
  final String shortCode;
  final int colorValue;

  /// Verfügbare Zeit für das Pferd an diesem Tag (Minuten).
  final int stableMinutes;
  final int? startMinutes;
  final int? endMinutes;
  final DayTime? preferredTime;

  /// Nachtschicht: der Folgetag wird im Trainingsplan geschont.
  final bool isNight;
  final bool archived;
  final int sortOrder;
}

/// Woher ein Dienstplan-Tag stammt. Der [key] wird gespeichert.
enum ShiftSource {
  manual('manual'),
  pattern('pattern');

  const ShiftSource(this.key);
  final String key;

  static ShiftSource fromKey(String? key) =>
      key == pattern.key ? pattern : manual;
}

/// Ein Tag im Dienstplan (höchstens ein Eintrag pro Datum).
class ShiftDay {
  const ShiftDay({
    required this.date,
    this.templateId,
    this.overrideMinutes,
    this.otherPersonCovers = false,
    this.note,
    this.source = ShiftSource.manual,
    this.patternId,
  });

  final LocalDate date;
  final String? templateId;

  /// Eigene Stallzeit nur für diesen Tag (überschreibt die Vorlage).
  final int? overrideMinutes;

  /// Beisteller/Reitbeteiligung bewegt das Pferd an diesem Tag.
  final bool otherPersonCovers;
  final String? note;
  final ShiftSource source;
  final String? patternId;

  /// Ein Tag ohne jede Angabe wird nicht gespeichert.
  bool get isEmpty =>
      templateId == null &&
      overrideMinutes == null &&
      !otherPersonCovers &&
      (note == null || note!.trim().isEmpty);

  ShiftDay copyWith({
    String? templateId,
    bool clearTemplate = false,
    int? overrideMinutes,
    bool clearOverride = false,
    bool? otherPersonCovers,
    String? note,
    ShiftSource? source,
    String? patternId,
    bool clearPattern = false,
  }) => ShiftDay(
    date: date,
    templateId: clearTemplate ? null : (templateId ?? this.templateId),
    overrideMinutes: clearOverride
        ? null
        : (overrideMinutes ?? this.overrideMinutes),
    otherPersonCovers: otherPersonCovers ?? this.otherPersonCovers,
    note: note ?? this.note,
    source: source ?? this.source,
    patternId: clearPattern ? null : (patternId ?? this.patternId),
  );
}

/// Wiederkehrendes Schichtmuster, z. B. 2× Früh, 2× Spät, 2× Nacht, 4× Frei.
class ShiftPattern {
  const ShiftPattern({
    required this.id,
    required this.name,
    required this.steps,
    required this.startDate,
    required this.weeks,
  });

  final String id;
  final String name;

  /// Ein Eintrag pro Tag des Zyklus; `null` = Tag ohne Schicht.
  final List<String?> steps;
  final LocalDate startDate;
  final int weeks;

  LocalDate get endDate => startDate.addDays(weeks * 7 - 1);
}
