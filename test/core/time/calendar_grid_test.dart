import 'package:flutter_test/flutter_test.dart';
import 'package:pferdekalender/core/time/calendar_grid.dart';
import 'package:pferdekalender/core/time/local_date.dart';

void main() {
  test('Monat November 2026: 6 Wochen ab Montag 26.10.', () {
    final weeks = calendarWeeks(LocalDate(2026, 11, 25), CalendarSpan.month);
    expect(weeks.first.first, LocalDate(2026, 10, 26));
    expect(weeks.last.last, LocalDate(2026, 12, 6));
    expect(weeks, hasLength(6));
    expect(weeks.every((w) => w.length == 7 && w.first.weekday == 1), isTrue);
  });

  test('Februar 2027 beginnt Montag: genau 4 Wochen', () {
    final weeks = calendarWeeks(LocalDate(2027, 2, 10), CalendarSpan.month);
    expect(weeks, hasLength(4));
    expect(weeks.first.first, LocalDate(2027, 2, 1));
  });

  test('März 2026 mit Zeitumstellung: lückenlose Tage', () {
    final days = calendarWeeks(
      LocalDate(2026, 3, 1),
      CalendarSpan.month,
    ).expand((w) => w).toList();
    for (var i = 1; i < days.length; i++) {
      expect(days[i - 1].daysUntil(days[i]), 1);
    }
    expect(days.contains(LocalDate(2026, 3, 29)), isTrue);
  });

  test('Woche und 2 Wochen ab Montag', () {
    expect(
      calendarWeeks(LocalDate(2026, 11, 25), CalendarSpan.week).single.first,
      LocalDate(2026, 11, 23),
    );
    expect(
      calendarWeeks(LocalDate(2026, 11, 25), CalendarSpan.twoWeeks),
      hasLength(2),
    );
  });

  test('Blättern', () {
    expect(
      shiftFocus(LocalDate(2026, 12, 31), CalendarSpan.month, 1),
      LocalDate(2027, 1, 1),
    );
    expect(
      shiftFocus(LocalDate(2026, 1, 15), CalendarSpan.month, -1),
      LocalDate(2025, 12, 1),
    );
    expect(
      shiftFocus(LocalDate(2026, 11, 25), CalendarSpan.twoWeeks, 1),
      LocalDate(2026, 12, 9),
    );
    expect(
      shiftFocus(LocalDate(2026, 11, 25), CalendarSpan.week, -1),
      LocalDate(2026, 11, 18),
    );
  });
}
