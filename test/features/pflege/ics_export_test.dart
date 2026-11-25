import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:pferdekalender/core/time/local_date.dart';
import 'package:pferdekalender/features/pflege/domain/ics_export.dart';

void main() {
  final now = DateTime.utc(2026, 11, 25, 12);

  String build(List<IcsEvent> e, {int reminder = 9 * 60}) =>
      buildIcs(e, reminderMinutes: reminder, now: now, alarmText: 'Erinnerung');

  List<String> unfold(String ics) =>
      ics.replaceAll('\r\n ', '').split('\r\n')..removeLast();

  test('ganztägig mit stabiler UID, CRLF, Kalender-Rahmen', () {
    final ics = build([
      IcsEvent(
        uid: careEventUid('abc'),
        date: LocalDate(2026, 12, 3),
        summary: 'Hufschmied · Beschlag – Amigo',
      ),
    ]);
    expect(ics, startsWith('BEGIN:VCALENDAR\r\nVERSION:2.0\r\n'));
    expect(ics, endsWith('END:VCALENDAR\r\n'));
    expect(ics.replaceAll('\r\n', '').contains('\n'), isFalse);
    final lines = unfold(ics);
    expect(lines, contains('UID:care-abc@pferdekalender'));
    expect(lines, contains('DTSTAMP:20261125T120000Z'));
    expect(lines, contains('DTSTART;VALUE=DATE:20261203'));
    expect(lines, contains('DTEND;VALUE=DATE:20261204'));
    // ohne Uhrzeit keine Zeitzonen-Definition nötig
    expect(ics, isNot(contains('VTIMEZONE')));
  });

  test('gleicher Termin → gleiche UID (kein Duplikat beim Re-Import)', () {
    expect(careEventUid('x1'), careEventUid('x1'));
    expect(careEventUid('x1'), isNot(careEventUid('x2')));
  });

  test('mit Uhrzeit: TZID Europe/Berlin + VTIMEZONE, Ende +60 min', () {
    final lines = unfold(
      build([
        IcsEvent(
          uid: 'u',
          date: LocalDate(2026, 10, 25), // Zeitumstellung
          startMinutes: 14 * 60 + 30,
          summary: 'Tierarzt',
        ),
      ]),
    );
    expect(lines, contains('DTSTART;TZID=Europe/Berlin:20261025T143000'));
    expect(lines, contains('DTEND;TZID=Europe/Berlin:20261025T153000'));
    expect(lines, contains('TZID:Europe/Berlin'));
    expect(lines, contains('RRULE:FREQ=YEARLY;BYMONTH=3;BYDAY=-1SU'));
  });

  test('Termin um 23:30 endet am nächsten Tag', () {
    final lines = unfold(
      build([
        IcsEvent(
          uid: 'u',
          date: LocalDate(2026, 12, 31),
          startMinutes: 23 * 60 + 30,
          summary: 'x',
        ),
      ]),
    );
    expect(lines, contains('DTEND;TZID=Europe/Berlin:20270101T003000'));
  });

  group('Erinnerungen (VALARM) wie in der Android-App', () {
    test('ganztägig, 1 Tag vorher um 9:00 → -PT15H', () {
      expect(
        alarmTriggerMinutes(offsetDays: 1, reminderMinutes: 540),
        -15 * 60,
      );
      final lines = unfold(
        build([
          IcsEvent(
            uid: 'u',
            date: LocalDate(2026, 12, 3),
            summary: 'Wurmkur',
            alarmOffsetsDays: const [1, 7],
          ),
        ]),
      );
      expect(lines, contains('TRIGGER:-PT15H'));
      expect(lines, contains('TRIGGER:-P6DT15H'));
      expect(lines.where((l) => l == 'BEGIN:VALARM'), hasLength(2));
      expect(lines, contains('ACTION:DISPLAY'));
    });

    test('ganztägig am Tag selbst um 9:00 → PT9H', () {
      expect(
        icsDuration(alarmTriggerMinutes(offsetDays: 0, reminderMinutes: 540)),
        'PT9H',
      );
    });

    test('Termin 8:00, Erinnerung am Tag → 60 min vorher', () {
      expect(
        alarmTriggerMinutes(
          offsetDays: 0,
          reminderMinutes: 540,
          startMinutes: 8 * 60,
        ),
        -60,
      );
    });

    test('Termin 14:30, 1 Tag vorher um 9:00 → -P1DT5H30M', () {
      expect(
        icsDuration(
          alarmTriggerMinutes(
            offsetDays: 1,
            reminderMinutes: 540,
            startMinutes: 14 * 60 + 30,
          ),
        ),
        '-P1DT5H30M',
      );
    });

    test('Dauer-Format', () {
      expect(icsDuration(0), 'PT0M');
      expect(icsDuration(-60), '-PT1H');
      expect(icsDuration(-90), '-PT1H30M');
      expect(icsDuration(-24 * 60), '-P1D');
      expect(icsDuration(-(7 * 24 * 60 - 540)), '-P6DT15H');
    });
  });

  test('Sonderzeichen werden escaped, lange Zeilen gefaltet (UTF-8)', () {
    final ics = build([
      IcsEvent(
        uid: 'u',
        date: LocalDate(2026, 12, 3),
        summary: 'Impfung; Influenza, Tetanus',
        description: 'Zeile 1\nZeile 2 mit Backslash \\ und ${'ä' * 60}',
      ),
    ]);
    for (final l in ics.split('\r\n')) {
      expect(utf8.encode(l).length, lessThanOrEqualTo(75), reason: l);
    }
    final lines = unfold(ics);
    expect(lines, contains(r'SUMMARY:Impfung\; Influenza\, Tetanus'));
    final desc = lines.firstWhere((l) => l.startsWith('DESCRIPTION:'));
    expect(
      desc,
      startsWith(r'DESCRIPTION:Zeile 1\nZeile 2 mit Backslash \\ und ä'),
    );
    expect(desc, endsWith('ä' * 60));
  });

  test('Dateiname', () {
    expect(
      icsFileName(LocalDate(2026, 11, 25)),
      'pferdekalender-termine-2026-11-25.ics',
    );
  });
}
