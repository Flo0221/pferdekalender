import '../../../core/time/local_date.dart';
import 'shift.dart';

/// Ergebnis des Ausrollens eines Rhythmus.
class RolloutResult {
  const RolloutResult({required this.days, required this.skippedManual});

  /// Zu speichernde Tage (Quelle „Rhythmus“).
  final List<ShiftDay> days;

  /// Tage, die manuell geändert waren und deshalb nicht überschrieben wurden.
  final List<LocalDate> skippedManual;
}

/// Rollt [pattern] ab dem Startdatum über `weeks × 7` Tage aus.
///
/// - Der Zyklus wiederholt sich ([ShiftPattern.steps], beliebige Länge).
/// - Manuell gesetzte Tage in [existing] bleiben, außer [overwriteManual].
/// - Eigene Stallzeit, „Beisteller übernimmt“ und Notiz eines vorhandenen
///   Tages bleiben auch beim Überschreiben erhalten – nur die Schicht ändert
///   sich.
RolloutResult rolloutPattern(
  ShiftPattern pattern,
  Map<LocalDate, ShiftDay> existing, {
  bool overwriteManual = false,
}) {
  if (pattern.steps.isEmpty || pattern.weeks <= 0) {
    return const RolloutResult(days: [], skippedManual: []);
  }
  final days = <ShiftDay>[];
  final skipped = <LocalDate>[];
  final total = pattern.weeks * 7;
  for (var i = 0; i < total; i++) {
    final date = pattern.startDate.addDays(i);
    final templateId = pattern.steps[i % pattern.steps.length];
    final old = existing[date];
    if (old != null && old.source == ShiftSource.manual && !old.isEmpty) {
      if (!overwriteManual) {
        skipped.add(date);
        continue;
      }
    }
    days.add(
      ShiftDay(
        date: date,
        templateId: templateId,
        overrideMinutes: old?.overrideMinutes,
        otherPersonCovers: old?.otherPersonCovers ?? false,
        note: old?.note,
        source: ShiftSource.pattern,
        patternId: pattern.id,
      ),
    );
  }
  return RolloutResult(days: days, skippedManual: skipped);
}

/// Kurzbeschreibung eines Zyklus: aufeinanderfolgende gleiche Schichten
/// werden zusammengefasst, z. B. `[(F,2), (S,2), (N,2), (null,4)]`.
List<(String?, int)> compressSteps(List<String?> steps) {
  final result = <(String?, int)>[];
  for (final s in steps) {
    if (result.isNotEmpty && result.last.$1 == s) {
      result[result.length - 1] = (s, result.last.$2 + 1);
    } else {
      result.add((s, 1));
    }
  }
  return result;
}

/// Was an einem Tag für das Pferd zur Verfügung steht (für den
/// Trainings-Generator). Reines Dart.
class DayAvailability {
  const DayAvailability({
    required this.date,
    required this.minutes,
    this.template,
    this.preferredTime,
    this.afterNightShift = false,
    this.otherPersonCovers = false,
    this.isOverride = false,
  });

  final LocalDate date;

  /// Verfügbare Stallzeit; `null` = nichts eingetragen (unbekannt).
  final int? minutes;
  final ShiftTemplate? template;
  final DayTime? preferredTime;

  /// Der Vortag war eine Nachtschicht.
  final bool afterNightShift;
  final bool otherPersonCovers;

  /// Stallzeit wurde für diesen Tag eigens gesetzt.
  final bool isOverride;
}

/// Verfügbarkeit für jeden Tag von [from] bis [to] (einschließlich).
List<DayAvailability> availabilityFor(
  LocalDate from,
  LocalDate to,
  Map<LocalDate, ShiftDay> days,
  Map<String, ShiftTemplate> templates,
) {
  final result = <DayAvailability>[];
  for (var d = from; !d.isAfter(to); d = d.addDays(1)) {
    final day = days[d];
    final template = day?.templateId == null
        ? null
        : templates[day!.templateId];
    final prev = days[d.addDays(-1)];
    final prevTemplate = prev?.templateId == null
        ? null
        : templates[prev!.templateId];
    result.add(
      DayAvailability(
        date: d,
        minutes: day?.overrideMinutes ?? template?.stableMinutes,
        template: template,
        preferredTime: template?.preferredTime,
        afterNightShift: prevTemplate?.isNight ?? false,
        otherPersonCovers: day?.otherPersonCovers ?? false,
        isOverride: day?.overrideMinutes != null,
      ),
    );
  }
  return result;
}

/// Summe der verfügbaren Stallzeit (unbekannte Tage zählen nicht).
int totalMinutes(Iterable<DayAvailability> days) =>
    days.fold(0, (sum, d) => sum + (d.minutes ?? 0));

/// Startvorlagen, die der Nutzer per Knopfdruck anlegen kann.
const defaultShiftTemplates = <ShiftTemplate>[
  ShiftTemplate(
    id: '',
    name: 'Früh',
    shortCode: 'F',
    colorValue: 0xFFFFB300,
    startMinutes: 6 * 60,
    endMinutes: 14 * 60,
    stableMinutes: 90,
    preferredTime: DayTime.nachmittags,
    sortOrder: 0,
  ),
  ShiftTemplate(
    id: '',
    name: 'Spät',
    shortCode: 'S',
    colorValue: 0xFF1E88E5,
    startMinutes: 14 * 60,
    endMinutes: 22 * 60,
    stableMinutes: 60,
    preferredTime: DayTime.morgens,
    sortOrder: 1,
  ),
  ShiftTemplate(
    id: '',
    name: 'Nacht',
    shortCode: 'N',
    colorValue: 0xFF5E35B1,
    startMinutes: 22 * 60,
    endMinutes: 6 * 60,
    stableMinutes: 30,
    preferredTime: DayTime.nachmittags,
    isNight: true,
    sortOrder: 2,
  ),
  ShiftTemplate(
    id: '',
    name: 'Frei',
    shortCode: '–',
    colorValue: 0xFF43A047,
    stableMinutes: 150,
    sortOrder: 3,
  ),
  ShiftTemplate(
    id: '',
    name: 'Urlaub',
    shortCode: 'U',
    colorValue: 0xFF00ACC1,
    stableMinutes: 180,
    sortOrder: 4,
  ),
];
