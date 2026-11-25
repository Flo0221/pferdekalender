import 'package:flutter_test/flutter_test.dart';
import 'package:pferdekalender/core/time/local_date.dart';
import 'package:pferdekalender/features/einstellungen/domain/reminder_settings.dart';
import 'package:pferdekalender/features/pflege/domain/reminder_planner.dart';

ReminderSource src(
  String id,
  LocalDate date,
  List<int> offsets, {
  int? eventMinutes,
}) => ReminderSource(
  payload: id,
  date: date,
  offsets: offsets,
  eventMinutes: eventMinutes,
  title: 'Titel $id',
  bodyFor: (o) => '$id-$o',
);

void main() {
  final now = DateTime(2026, 11, 25, 12, 0);

  test('Tage vorher um die Erinnerungszeit, vergangene entfallen', () {
    final plan = planNotifications(
      [
        src('a', LocalDate(2026, 12, 1), [0, 1, 7]),
      ],
      now: now,
      reminderMinutes: 9 * 60,
    );
    // 7 Tage vorher = 24.11. → schon vorbei.
    expect(plan.map((p) => p.body), ['a-1', 'a-0']);
    expect(plan.first.date, LocalDate(2026, 11, 30));
    expect(plan.first.minutes, 540);
    expect(plan.map((p) => p.id), [1, 2]);
  });

  test('heute 9:00 ist vorbei, heute 18:00 noch nicht', () {
    final today = LocalDate(2026, 11, 25);
    expect(
      planNotifications(
        [
          src('a', today, [0]),
        ],
        now: now,
        reminderMinutes: 540,
      ),
      isEmpty,
    );
    expect(
      planNotifications(
        [
          src('a', today, [0]),
        ],
        now: now,
        reminderMinutes: 1080,
      ),
      hasLength(1),
    );
  });

  test('Termin früh am Morgen: Erinnerung am Tag 60 min vorher', () {
    final plan = planNotifications(
      [
        src('a', LocalDate(2026, 12, 1), [0], eventMinutes: 7 * 60 + 30),
      ],
      now: now,
      reminderMinutes: 9 * 60,
    );
    expect(plan.single.minutes, 6 * 60 + 30);
    final veryEarly = planNotifications(
      [
        src('b', LocalDate(2026, 12, 1), [0], eventMinutes: 30),
      ],
      now: now,
      reminderMinutes: 9 * 60,
    );
    expect(veryEarly.single.minutes, 0);
  });

  test('Termin nach der Erinnerungszeit: bleibt bei der Erinnerungszeit', () {
    final plan = planNotifications(
      [
        src('a', LocalDate(2026, 12, 1), [0], eventMinutes: 15 * 60),
      ],
      now: now,
      reminderMinutes: 9 * 60,
    );
    expect(plan.single.minutes, 540);
  });

  test('sortiert nach Zeitpunkt und begrenzt', () {
    final plan = planNotifications(
      [
        for (var i = 30; i > 0; i--)
          src('e$i', LocalDate(2026, 12, 1).addDays(i), [0]),
      ],
      now: now,
      reminderMinutes: 540,
      limit: 5,
    );
    expect(plan.map((p) => p.payload), ['e1', 'e2', 'e3', 'e4', 'e5']);
  });

  test('Erinnerung am Tag der Zeitumstellung bleibt 9:00 Ortszeit', () {
    final plan = planNotifications(
      [
        src('a', LocalDate(2027, 3, 28), [0]),
      ],
      now: now,
      reminderMinutes: 540,
    );
    expect(plan.single.localDateTime, DateTime(2027, 3, 28, 9));
    expect(plan.single.localDateTime.hour, 9);
  });

  group('ReminderSettings', () {
    test('Standardwerte und Parsing', () {
      expect(ReminderSettings.parseMinutes(null), 540);
      expect(ReminderSettings.parseMinutes('1500'), 540);
      expect(ReminderSettings.parseMinutes('420'), 420);
      expect(ReminderSettings.parseOffsets(null), [1]);
      expect(ReminderSettings.parseOffsets(''), isEmpty);
      expect(ReminderSettings.parseOffsets('7, 1,x,1'), [1, 7]);
      expect(ReminderSettings.encodeOffsets([7, 0, 7]), '0,7');
    });
  });
}
