import 'package:flutter_test/flutter_test.dart';
import 'package:pferdekalender/core/time/local_date.dart';

void main() {
  group('LocalDate', () {
    test('ISO-Text hin und zurück', () {
      final d = LocalDate(2026, 3, 5);
      expect(d.toIso(), '2026-03-05');
      expect(LocalDate.parse('2026-03-05'), d);
    });

    test('ungültige Daten werden abgelehnt', () {
      expect(() => LocalDate.parse('2026-02-30'), throwsFormatException);
      expect(() => LocalDate.parse('2026-13-01'), throwsFormatException);
      expect(() => LocalDate.parse('05.03.2026'), throwsFormatException);
    });

    test('Umstellung auf Sommerzeit (29.03.2026) verschiebt keinen Tag', () {
      final vorher = LocalDate(2026, 3, 28);
      expect(vorher.addDays(1), LocalDate(2026, 3, 29));
      expect(vorher.addDays(2), LocalDate(2026, 3, 30));
      expect(LocalDate(2026, 3, 29).daysUntil(LocalDate(2026, 3, 30)), 1);
      // 7 Wochen über die Umstellung hinweg bleibt derselbe Wochentag.
      final start = LocalDate(2026, 3, 2);
      expect(start.addWeeks(7), LocalDate(2026, 4, 20));
      expect(start.addWeeks(7).weekday, DateTime.monday);
    });

    test('Umstellung auf Winterzeit (25.10.2026) verschiebt keinen Tag', () {
      final vorher = LocalDate(2026, 10, 24);
      expect(vorher.addDays(1), LocalDate(2026, 10, 25));
      expect(vorher.addDays(2), LocalDate(2026, 10, 26));
      expect(LocalDate(2026, 10, 25).daysUntil(LocalDate(2026, 10, 26)), 1);
    });

    test('1 Jahr täglich weiterzählen ergibt genau 365 verschiedene Tage', () {
      var d = LocalDate(2026, 1, 1);
      final seen = <LocalDate>{};
      for (var i = 0; i < 365; i++) {
        seen.add(d);
        d = d.addDays(1);
      }
      expect(seen.length, 365);
      expect(d, LocalDate(2027, 1, 1));
    });

    test(
      'fromDateTime nimmt den lokalen Kalendertag, auch kurz vor Mitternacht',
      () {
        expect(
          LocalDate.fromDateTime(DateTime(2026, 3, 29, 23, 59)),
          LocalDate(2026, 3, 29),
        );
        expect(
          LocalDate.fromDateTime(DateTime(2026, 10, 25, 0, 1)),
          LocalDate(2026, 10, 25),
        );
      },
    );

    test('addMonths begrenzt auf Monatsende', () {
      expect(LocalDate(2026, 1, 31).addMonths(1), LocalDate(2026, 2, 28));
      expect(LocalDate(2028, 1, 31).addMonths(1), LocalDate(2028, 2, 29));
      expect(LocalDate(2026, 8, 31).addMonths(6), LocalDate(2027, 2, 28));
      expect(LocalDate(2026, 3, 15).addMonths(-3), LocalDate(2025, 12, 15));
      expect(LocalDate(2028, 2, 29).addYears(1), LocalDate(2029, 2, 28));
    });

    test('Woche beginnt am Montag', () {
      // 25.11.2026 ist ein Mittwoch.
      expect(LocalDate(2026, 11, 25).weekday, DateTime.wednesday);
      expect(LocalDate(2026, 11, 25).startOfWeek, LocalDate(2026, 11, 23));
      expect(LocalDate(2026, 11, 29).startOfWeek, LocalDate(2026, 11, 23));
      expect(LocalDate(2026, 11, 23).startOfWeek, LocalDate(2026, 11, 23));
    });

    test('Vergleich und Gleichheit', () {
      final a = LocalDate(2026, 1, 1);
      final b = LocalDate(2026, 1, 2);
      expect(a.isBefore(b), isTrue);
      expect(b.isAfter(a), isTrue);
      expect(a, LocalDate(2026, 1, 1));
      expect({a, LocalDate(2026, 1, 1)}.length, 1);
    });
  });
}
