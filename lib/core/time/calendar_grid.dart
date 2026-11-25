import 'local_date.dart';

/// Ansicht eines Kalenders.
enum CalendarSpan { month, twoWeeks, week }

/// Berechnet die anzuzeigenden Wochen (je 7 Tage, Montag zuerst). Reines Dart.
///
/// - Monat: alle Wochen, die einen Tag des Monats von [focused] enthalten.
/// - 2 Wochen / Woche: ab dem Montag der Woche von [focused].
List<List<LocalDate>> calendarWeeks(LocalDate focused, CalendarSpan span) {
  final LocalDate start;
  final int weeks;
  switch (span) {
    case CalendarSpan.month:
      final first = LocalDate(focused.year, focused.month, 1);
      final last = LocalDate(focused.year, focused.month + 1, 0);
      start = first.startOfWeek;
      weeks = (start.daysUntil(last) ~/ 7) + 1;
    case CalendarSpan.twoWeeks:
      start = focused.startOfWeek;
      weeks = 2;
    case CalendarSpan.week:
      start = focused.startOfWeek;
      weeks = 1;
  }
  return [
    for (var w = 0; w < weeks; w++)
      [for (var d = 0; d < 7; d++) start.addDays(w * 7 + d)],
  ];
}

/// Nächster bzw. vorheriger Zeitraum (Monat, 2 Wochen oder Woche).
LocalDate shiftFocus(LocalDate focused, CalendarSpan span, int direction) =>
    switch (span) {
      CalendarSpan.month => LocalDate(
        focused.year,
        focused.month + direction,
        1,
      ),
      CalendarSpan.twoWeeks => focused.addWeeks(2 * direction),
      CalendarSpan.week => focused.addWeeks(direction),
    };
