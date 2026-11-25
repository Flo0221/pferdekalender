import 'package:flutter_test/flutter_test.dart';
import 'package:pferdekalender/core/time/local_date.dart';
import 'package:pferdekalender/features/dienstplan/domain/shift.dart';
import 'package:pferdekalender/features/dienstplan/domain/shift_logic.dart';

const frueh = ShiftTemplate(
  id: 'F',
  name: 'Früh',
  shortCode: 'F',
  colorValue: 0,
  stableMinutes: 90,
  preferredTime: DayTime.nachmittags,
);
const nacht = ShiftTemplate(
  id: 'N',
  name: 'Nacht',
  shortCode: 'N',
  colorValue: 0,
  stableMinutes: 30,
  isNight: true,
);
const frei = ShiftTemplate(
  id: 'X',
  name: 'Frei',
  shortCode: '–',
  colorValue: 0,
  stableMinutes: 150,
);
final templates = {
  for (final t in [frueh, nacht, frei]) t.id: t,
};

void main() {
  final monday = LocalDate(2026, 11, 30);

  ShiftPattern pattern(List<String?> steps, {int weeks = 2}) => ShiftPattern(
    id: 'p1',
    name: 'Wechsel',
    steps: steps,
    startDate: monday,
    weeks: weeks,
  );

  group('rolloutPattern', () {
    test('2 Früh, 2 Nacht, 4 Frei wiederholt sich über 2 Wochen', () {
      final steps = ['F', 'F', 'N', 'N', 'X', 'X', 'X', 'X'];
      final r = rolloutPattern(pattern(steps), const {});
      expect(r.days, hasLength(14));
      expect(r.days.map((d) => d.templateId).take(10), [...steps, 'F', 'F']);
      expect(r.days.every((d) => d.source == ShiftSource.pattern), isTrue);
      expect(r.days.every((d) => d.patternId == 'p1'), isTrue);
      expect(r.days.last.date, monday.addDays(13));
    });

    test('manuell geänderte Tage bleiben, außer beim Überschreiben', () {
      final manual = ShiftDay(date: monday.addDays(2), templateId: 'X');
      final existing = {manual.date: manual};
      final keep = rolloutPattern(pattern(['F']), existing);
      expect(keep.skippedManual, [manual.date]);
      expect(keep.days, hasLength(13));

      final over = rolloutPattern(
        pattern(['F']),
        existing,
        overwriteManual: true,
      );
      expect(over.skippedManual, isEmpty);
      expect(over.days, hasLength(14));
      expect(over.days[2].templateId, 'F');
    });

    test('vorherige Rhythmus-Tage werden ersetzt, Zusatzangaben bleiben', () {
      final old = ShiftDay(
        date: monday,
        templateId: 'N',
        overrideMinutes: 20,
        otherPersonCovers: true,
        note: 'Tierarzt',
        source: ShiftSource.pattern,
        patternId: 'alt',
      );
      final r = rolloutPattern(pattern(['F']), {monday: old});
      final d = r.days.first;
      expect(d.templateId, 'F');
      expect(d.overrideMinutes, 20);
      expect(d.otherPersonCovers, isTrue);
      expect(d.note, 'Tierarzt');
      expect(d.patternId, 'p1');
    });

    test('Tage ohne Schicht im Zyklus und leere Muster', () {
      final r = rolloutPattern(pattern([null, 'F'], weeks: 1), const {});
      expect(r.days.map((d) => d.templateId), [
        null,
        'F',
        null,
        'F',
        null,
        'F',
        null,
      ]);
      expect(rolloutPattern(pattern([]), const {}).days, isEmpty);
    });

    test('Ausrollen über die Zeitumstellung: 7 Tage pro Woche, lückenlos', () {
      final p = ShiftPattern(
        id: 'p',
        name: 'x',
        steps: const ['F'],
        startDate: LocalDate(2027, 3, 22),
        weeks: 2,
      );
      final dates = rolloutPattern(
        p,
        const {},
      ).days.map((d) => d.date).toList();
      expect(dates, hasLength(14));
      expect(dates.toSet(), hasLength(14));
      expect(dates.contains(LocalDate(2027, 3, 28)), isTrue);
      expect(dates.last, LocalDate(2027, 4, 4));
    });
  });

  test('compressSteps fasst Folgen zusammen', () {
    expect(compressSteps(['F', 'F', 'N', 'N', null, null, null, null]), [
      ('F', 2),
      ('N', 2),
      (null, 4),
    ]);
    expect(compressSteps([]), isEmpty);
  });

  group('availabilityFor', () {
    test('Stallzeit aus Vorlage, eigene Zeit überschreibt, Tag nach Nacht', () {
      final days = {
        monday: ShiftDay(date: monday, templateId: 'N'),
        monday.addDays(1): ShiftDay(date: monday.addDays(1), templateId: 'X'),
        monday.addDays(2): ShiftDay(
          date: monday.addDays(2),
          templateId: 'F',
          overrideMinutes: 20,
        ),
        monday.addDays(3): ShiftDay(
          date: monday.addDays(3),
          otherPersonCovers: true,
        ),
      };
      final a = availabilityFor(monday, monday.addDays(4), days, templates);
      expect(a.map((d) => d.minutes), [30, 150, 20, null, null]);
      expect(a[1].afterNightShift, isTrue);
      expect(a[0].afterNightShift, isFalse);
      expect(a[2].isOverride, isTrue);
      expect(a[2].preferredTime, DayTime.nachmittags);
      expect(a[3].otherPersonCovers, isTrue);
      expect(totalMinutes(a), 200);
    });

    test('Woche nur mit Nachtschichten', () {
      final days = {
        for (var i = 0; i < 7; i++)
          monday.addDays(i): ShiftDay(date: monday.addDays(i), templateId: 'N'),
      };
      final a = availabilityFor(monday, monday.addDays(6), days, templates);
      expect(a.skip(1).every((d) => d.afterNightShift), isTrue);
      expect(totalMinutes(a), 7 * 30);
    });
  });

  test('ShiftDay.isEmpty', () {
    expect(ShiftDay(date: monday).isEmpty, isTrue);
    expect(ShiftDay(date: monday, note: '  ').isEmpty, isTrue);
    expect(ShiftDay(date: monday, overrideMinutes: 0).isEmpty, isFalse);
  });
}
