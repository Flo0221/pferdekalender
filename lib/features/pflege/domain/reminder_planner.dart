import '../../../core/time/local_date.dart';

/// Eine einzuplanende Benachrichtigung (lokale Gerätezeit). Reines Dart.
class PlannedNotification {
  const PlannedNotification({
    required this.id,
    required this.date,
    required this.minutes,
    required this.title,
    required this.body,
    required this.payload,
  });

  /// Wird bei jedem Abgleich neu vergeben (alle alten werden vorher gelöscht).
  final int id;
  final LocalDate date;

  /// Minuten seit Mitternacht.
  final int minutes;
  final String title;
  final String body;

  /// z. B. `care:<eventId>` oder `birthday:<horseId>`.
  final String payload;

  DateTime get localDateTime => date.atMinutes(minutes);
}

/// Eingabe für einen Pflegetermin-Erinnerungskandidaten.
class ReminderSource {
  const ReminderSource({
    required this.payload,
    required this.date,
    required this.offsets,
    required this.title,
    required this.bodyFor,
    this.eventMinutes,
  });

  final String payload;
  final LocalDate date;
  final int? eventMinutes;
  final List<int> offsets;
  final String title;

  /// Text abhängig von „Tage vorher“ (0 = heute).
  final String Function(int offsetDays) bodyFor;
}

/// Android erlaubt pro App nur eine begrenzte Zahl geplanter Alarme.
const maxPlannedNotifications = 400;

/// Berechnet alle künftigen Benachrichtigungen.
///
/// - Zeitpunkt: [reminderMinutes] (z. B. 9:00) am Tag `Datum − Offset`.
/// - Bei Offset 0 und Termin-Uhrzeit vor der Erinnerungszeit: 60 min vor
///   dem Termin (frühestens 0:00).
/// - Vergangene Zeitpunkte (≤ [now]) entfallen.
/// - Es werden höchstens [limit] Benachrichtigungen geplant (die nächsten).
List<PlannedNotification> planNotifications(
  Iterable<ReminderSource> sources, {
  required DateTime now,
  required int reminderMinutes,
  int limit = maxPlannedNotifications,
}) {
  final candidates = <(DateTime, LocalDate, int, ReminderSource, int)>[];
  for (final s in sources) {
    for (final offset in s.offsets.toSet()) {
      if (offset < 0) continue;
      final day = s.date.addDays(-offset);
      var minutes = reminderMinutes;
      if (offset == 0 && s.eventMinutes != null) {
        final before = s.eventMinutes! - 60;
        if (before < minutes) minutes = before < 0 ? 0 : before;
      }
      final at = day.atMinutes(minutes);
      if (!at.isAfter(now)) continue;
      candidates.add((at, day, minutes, s, offset));
    }
  }
  candidates.sort((a, b) => a.$1.compareTo(b.$1));
  return [
    for (final (i, c) in candidates.take(limit).indexed)
      PlannedNotification(
        id: i + 1,
        date: c.$2,
        minutes: c.$3,
        title: c.$4.title,
        body: c.$4.bodyFor(c.$5),
        payload: c.$4.payload,
      ),
  ];
}
