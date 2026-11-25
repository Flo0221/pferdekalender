import 'package:flutter_test/flutter_test.dart';
import 'package:pferdekalender/core/time/local_date.dart';
import 'package:pferdekalender/features/pflege/domain/care_event.dart';
import 'package:pferdekalender/features/pflege/domain/care_logic.dart';
import 'package:pferdekalender/features/pflege/domain/care_type.dart';
import 'package:pferdekalender/features/pflege/domain/interval_defaults.dart';
import 'package:pferdekalender/features/pflege/domain/repeat_interval.dart';

CareEvent ev(
  String id,
  LocalDate date, {
  bool done = false,
  RepeatInterval? repeat,
  String? parent,
  String type = BuiltinCareTypes.huf,
}) => CareEvent(
  id: id,
  horseId: 'h',
  typeId: type,
  date: date,
  done: done,
  repeat: repeat,
  parentEventId: parent,
);

void main() {
  const sevenWeeks = RepeatInterval(7, IntervalUnit.weeks);

  group('RepeatInterval', () {
    test('Tage, Wochen, Monate, Jahre', () {
      final d = LocalDate(2026, 1, 31);
      expect(
        const RepeatInterval(10, IntervalUnit.days).addTo(d),
        LocalDate(2026, 2, 10),
      );
      expect(sevenWeeks.addTo(d), LocalDate(2026, 3, 21));
      expect(
        const RepeatInterval(1, IntervalUnit.months).addTo(d),
        LocalDate(2026, 2, 28),
      );
      expect(
        const RepeatInterval(
          2,
          IntervalUnit.years,
        ).addTo(LocalDate(2024, 2, 29)),
        LocalDate(2026, 2, 28),
      );
    });

    test('über Sommerzeit hinweg kein Tagesversatz', () {
      // 7 Wochen ab Montag 09.03.2026 über den 29.03. → wieder Montag.
      final next = sevenWeeks.addTo(LocalDate(2026, 3, 9));
      expect(next, LocalDate(2026, 4, 27));
      expect(next.weekday, DateTime.monday);
    });

    test('unvollständige Werte ergeben null', () {
      expect(RepeatInterval.tryCreate(null, 'weeks'), isNull);
      expect(RepeatInterval.tryCreate(0, 'weeks'), isNull);
      expect(RepeatInterval.tryCreate(3, 'fortnights'), isNull);
      expect(
        RepeatInterval.tryCreate(3, 'months'),
        const RepeatInterval(3, IntervalUnit.months),
      );
    });
  });

  group('planFollowUp', () {
    final d = LocalDate(2026, 5, 4);

    test('neuer Eintrag mit Wiederholung legt Folgetermin an', () {
      final a = planFollowUp(
        ev('a', d, repeat: sevenWeeks),
        null,
        recalculate: false,
      );
      expect(a, isA<FollowUpCreate>());
      expect((a as FollowUpCreate).date, LocalDate(2026, 6, 22));
    });

    test('ohne Wiederholung kein Folgetermin', () {
      expect(
        planFollowUp(ev('a', d), null, recalculate: false),
        isA<FollowUpNone>(),
      );
    });

    test('offener Folgetermin wird nicht weiter vorausgeplant', () {
      // Ein automatisch erzeugter, noch offener Termin bekommt erst beim
      // Erledigen einen eigenen Folgetermin.
      final f = ev('f', d, repeat: sevenWeeks, parent: 'a');
      expect(planFollowUp(f, null, recalculate: false), isA<FollowUpNone>());
      final done = ev('f', d, repeat: sevenWeeks, parent: 'a', done: true);
      expect(
        planFollowUp(done, null, recalculate: false),
        isA<FollowUpCreate>(),
      );
    });

    test('Verschieben nur nach Zustimmung', () {
      final event = ev(
        'a',
        LocalDate(2026, 5, 11),
        repeat: sevenWeeks,
        done: true,
      );
      final followUp = ev('f', LocalDate(2026, 6, 22), parent: 'a');
      expect(
        planFollowUp(event, followUp, recalculate: false),
        isA<FollowUpNone>(),
      );
      final move = planFollowUp(event, followUp, recalculate: true);
      expect(move, isA<FollowUpMove>());
      expect((move as FollowUpMove).date, LocalDate(2026, 6, 29));
    });

    test('erledigter Folgetermin bleibt immer unangetastet', () {
      final event = ev('a', d, repeat: sevenWeeks);
      final done = ev('f', LocalDate(2026, 6, 20), parent: 'a', done: true);
      expect(planFollowUp(event, done, recalculate: true), isA<FollowUpNone>());
      expect(
        planFollowUp(ev('a', d), done, recalculate: true),
        isA<FollowUpNone>(),
      );
    });

    test('Wiederholung entfernt → offenen Folgetermin löschen', () {
      final open = ev('f', LocalDate(2026, 6, 22), parent: 'a');
      final a = planFollowUp(ev('a', d), open, recalculate: false);
      expect(a, isA<FollowUpDelete>());
      expect((a as FollowUpDelete).followUpId, 'f');
    });

    test('buildFollowUp übernimmt Art, Erinnerungen, Serie – ohne Kosten', () {
      final e = CareEvent(
        id: 'a',
        horseId: 'h',
        typeId: BuiltinCareTypes.huf,
        date: d,
        done: true,
        variantKey: 'beschlag',
        person: 'Schmied Meier',
        costCents: 12000,
        repeat: sevenWeeks,
        reminderOffsets: const [1, 7],
      );
      final f = buildFollowUp(e, LocalDate(2026, 6, 22), 'f');
      expect(f.id, 'f');
      expect(f.done, isFalse);
      expect(f.parentEventId, 'a');
      expect(f.seriesId, 'a');
      expect(f.variantKey, 'beschlag');
      expect(f.person, 'Schmied Meier');
      expect(f.costCents, isNull);
      expect(f.reminderOffsets, [1, 7]);
      expect(f.repeat, sevenWeeks);
    });
  });

  group('Listen', () {
    final today = LocalDate(2026, 11, 25);
    final events = [
      ev('zukunft', LocalDate(2026, 12, 10)),
      ev('ueberfaellig_alt', LocalDate(2026, 10, 1)),
      ev('erledigt', LocalDate(2026, 11, 1), done: true),
      ev('ueberfaellig', LocalDate(2026, 11, 20)),
      ev(
        'wurm',
        LocalDate(2026, 9, 1),
        done: true,
        type: BuiltinCareTypes.wurmkur,
      ),
    ];

    test('Anstehend: offene sortiert, überfällige zuerst', () {
      final list = upcomingSorted(events);
      expect(list.map((e) => e.id), [
        'ueberfaellig_alt',
        'ueberfaellig',
        'zukunft',
      ]);
      expect(list.first.isOverdue(today), isTrue);
      expect(list.last.isOverdue(today), isFalse);
    });

    test('Historie: erledigte neueste zuerst, Filter nach Art', () {
      expect(historySorted(events).map((e) => e.id), ['erledigt', 'wurm']);
      expect(
        historySorted(
          events,
          typeId: BuiltinCareTypes.wurmkur,
        ).map((e) => e.id),
        ['wurm'],
      );
    });
  });

  test('Vorschläge ohne Duplikate (Groß-/Kleinschreibung egal)', () {
    expect(
      distinctSuggestions([
        'Equest',
        'equest ',
        null,
        '',
        'Banminth',
        'EQUEST',
      ]),
      ['Equest', 'Banminth'],
    );
  });

  test('Erinnerungs-Offsets bereinigt', () {
    expect(normalizeOffsets([7, 1, 1, -3, 0]), [0, 1, 7]);
  });

  group('suggestInterval', () {
    test('Variante vor Art', () {
      expect(
        suggestInterval(defaultIntervals, BuiltinCareTypes.huf, 'beschlag'),
        sevenWeeks,
      );
      expect(
        suggestInterval(defaultIntervals, BuiltinCareTypes.huf, 'barhuf'),
        const RepeatInterval(6, IntervalUnit.weeks),
      );
      expect(
        suggestInterval(defaultIntervals, BuiltinCareTypes.impfung, 'tetanus'),
        const RepeatInterval(2, IntervalUnit.years),
      );
      expect(
        suggestInterval(
          defaultIntervals,
          BuiltinCareTypes.impfung,
          'influenza',
        ),
        const RepeatInterval(6, IntervalUnit.months),
      );
    });

    test('Wurmkur und unbekannte Varianten ohne Vorschlag', () {
      expect(
        suggestInterval(defaultIntervals, BuiltinCareTypes.wurmkur, null),
        isNull,
      );
      expect(
        suggestInterval(defaultIntervals, BuiltinCareTypes.huf, 'hufschuhe'),
        isNull,
      );
      expect(
        suggestInterval(defaultIntervals, BuiltinCareTypes.zahnarzt, null),
        const RepeatInterval(12, IntervalUnit.months),
      );
    });
  });
}
