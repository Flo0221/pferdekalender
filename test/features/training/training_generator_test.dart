import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:pferdekalender/core/time/local_date.dart';
import 'package:pferdekalender/features/dienstplan/domain/shift.dart';
import 'package:pferdekalender/features/dienstplan/domain/shift_logic.dart';
import 'package:pferdekalender/features/training/domain/training.dart';
import 'package:pferdekalender/features/training/domain/training_catalog.dart';
import 'package:pferdekalender/features/training/domain/training_generator.dart';

final catalog = TrainingCatalog.fromJson(
  (jsonDecode(File('assets/training_templates.json').readAsStringSync()) as Map)
      .cast<String, Object?>(),
);
final generator = TrainingGenerator(catalog);
final allForms = {for (final f in catalog.forms) f.key};
final start = LocalDate(2026, 11, 30); // Montag

const frueh = ShiftTemplate(
  id: 'F',
  name: 'Früh',
  shortCode: 'F',
  colorValue: 0,
  stableMinutes: 90,
);
const spaet = ShiftTemplate(
  id: 'S',
  name: 'Spät',
  shortCode: 'S',
  colorValue: 0,
  stableMinutes: 60,
);
const nacht = ShiftTemplate(
  id: 'N',
  name: 'Nacht',
  shortCode: 'N',
  colorValue: 0,
  stableMinutes: 0,
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
  for (final t in [frueh, spaet, nacht, frei]) t.id: t,
};

/// Dienstplan aus einem sich wiederholenden Wochenmuster (Mo–So).
Map<LocalDate, DayAvailability> plan(
  List<String?> week, {
  int weeks = 12,
  Map<LocalDate, ShiftDay> extra = const {},
}) {
  final days = <LocalDate, ShiftDay>{};
  for (var i = 0; i < weeks * 7 + 1; i++) {
    final d = start.addDays(i);
    days[d] = ShiftDay(date: d, templateId: week[i % 7]);
  }
  days.addAll(extra);
  final list = availabilityFor(
    start.addDays(-1),
    start.addDays(weeks * 7),
    days,
    templates,
  );
  return {for (final a in list) a.date: a};
}

TrainingParams params({
  TrainingGoal goal = TrainingGoal.muskelaufbau,
  int fitness = 3,
  int days = 5,
  int weeks = 8,
  Set<String>? forms,
  Set<String> exclusions = const {},
  int share = 100,
}) => TrainingParams(
  goal: goal,
  fitness: fitness,
  daysPerWeek: days,
  weeks: weeks,
  startDate: start,
  forms: forms ?? allForms,
  exclusions: exclusions,
  sharePercent: share,
);

/// Typische Woche: Mo–Fr gemischt, Sa/So frei.
final normalWeek = ['F', 'F', 'S', 'S', 'F', 'X', 'X'];

Map<LocalDate, int> levels(GeneratedPlan p) => {
  for (final s in p.sessions) s.date: s.level,
};

void main() {
  group('Vorlagen-Datei', () {
    test('ist vollständig und gültig', () {
      expect(catalog.units, isNotEmpty);
      expect(catalog.goals.keys, containsAll(TrainingGoal.values));
      for (final u in catalog.units) {
        expect(allForms, contains(u.form), reason: u.key);
        expect(u.level, inInclusiveRange(1, 5), reason: u.key);
        expect(u.minMinutes <= u.defaultMinutes, isTrue, reason: u.key);
        expect(u.defaultMinutes <= u.maxMinutes, isTrue, reason: u.key);
      }
      for (var l = 1; l <= 5; l++) {
        expect(catalog.units.any((u) => u.level == l), isTrue, reason: '$l');
      }
      expect(catalog.fitnessScale.keys, containsAll([1, 2, 3, 4, 5]));
      expect(catalog.load(4, 30), 15);
    });
  });

  group('Regel 1: Regeneration', () {
    for (final goal in TrainingGoal.values) {
      for (final fitness in [1, 3, 5]) {
        test(
          'nie zwei Tage ≥ 4 in Folge, nach 5 höchstens 2 ($goal, Fitness $fitness)',
          () {
            final p = generator.generate(
              params: params(goal: goal, fitness: fitness, days: 6, weeks: 12),
              availability: plan(['X', 'X', 'X', 'X', 'X', 'X', 'X']),
            );
            final l = levels(p);
            for (final MapEntry(key: d, value: level) in l.entries) {
              final next = l[d.addDays(1)] ?? 0;
              if (level >= 4) expect(next, lessThan(4), reason: '$d');
              if (level >= 5) expect(next, lessThanOrEqualTo(2), reason: '$d');
            }
          },
        );
      }
    }

    test('über die Wochengrenze: Sonntag intensiv → Montag nicht', () {
      final p = generator.generate(
        params: params(fitness: 5, days: 6),
        availability: plan(['X', 'X', 'X', 'X', 'X', 'X', 'X']),
      );
      final l = levels(p);
      for (var w = 0; w < 7; w++) {
        final sunday = start.addWeeks(w).addDays(6);
        if ((l[sunday] ?? 0) >= 4) {
          expect(l[sunday.addDays(1)] ?? 0, lessThan(4));
        }
      }
    });

    test('Stufe-5-Folgetag wird mit Begründung entlastet', () {
      final p = generator.generate(
        params: params(fitness: 5, days: 6),
        availability: plan(['X', 'X', 'X', 'X', 'X', 'X', 'X']),
      );
      final fives = p.sessions.where((s) => s.level == 5).toList();
      expect(fives, isNotEmpty);
      for (final f in fives) {
        final next = p.sessions.where((s) => s.date == f.date.addDays(1));
        for (final n in next) {
          expect(n.level, lessThanOrEqualTo(2));
        }
      }
    });
  });

  group('Regel 2: Ruhetag und Aktivpause', () {
    test('jede Woche mindestens 1 Ruhetag, auch bei 6 Wunschtagen', () {
      final p = generator.generate(
        params: params(days: 6, weeks: 12),
        availability: plan(['X', 'X', 'X', 'X', 'X', 'X', 'X']),
      );
      for (final w in p.weeks) {
        final busy = {for (final s in w.sessions) s.date};
        expect(
          busy.length,
          lessThanOrEqualTo(6),
          reason: 'Woche ${w.index + 1}',
        );
        expect(w.restDays, isNotEmpty);
      }
    });

    test('Aktivpause, wenn ein weiterer freier Tag bleibt', () {
      final p = generator.generate(
        params: params(days: 4),
        availability: plan(normalWeek),
      );
      for (final w in p.weeks) {
        expect(
          w.sessions.where((s) => s.level == 1),
          hasLength(1),
          reason: 'Woche ${w.index + 1}',
        );
        expect(w.restDays.length, greaterThanOrEqualTo(1));
        final ap = w.sessions.firstWhere((s) => s.level == 1);
        expect(ap.reason.activePause, isTrue);
      }
    });
  });

  group('Regel 3: Abwechslung', () {
    test('dieselbe Form höchstens 2× pro Woche, ≥ 3 verschiedene Formen', () {
      final p = generator.generate(
        params: params(days: 5, weeks: 8),
        availability: plan(['X', 'X', 'X', 'X', 'X', 'X', 'X']),
      );
      for (final w in p.weeks) {
        final training = w.sessions.where((s) => s.level >= 2);
        final counts = <String, int>{};
        for (final s in training) {
          counts[s.unit.form] = (counts[s.unit.form] ?? 0) + 1;
        }
        expect(counts.values.every((c) => c <= 2), isTrue, reason: '$counts');
        expect(counts.length, greaterThanOrEqualTo(3), reason: '$counts');
        expect(w.formRepeatWarning, isFalse);
      }
    });

    test('nur eine Form gewählt → Hinweis statt stiller Regelverletzung', () {
      final p = generator.generate(
        params: params(days: 5, forms: {'longieren'}),
        availability: plan(['X', 'X', 'X', 'X', 'X', 'X', 'X']),
      );
      expect(p.weeks.first.formRepeatWarning, isTrue);
    });
  });

  group('Regel 4: Progression nach Ziel', () {
    List<double> loads(GeneratedPlan p) => [for (final w in p.weeks) w.load];

    test('Muskelaufbau: steigt, jede 4. Woche ca. −30 %', () {
      final p = generator.generate(
        params: params(weeks: 8, days: 5),
        availability: plan(['X', 'X', 'X', 'X', 'X', 'X', 'X']),
      );
      final l = loads(p);
      expect(l[1], greaterThan(l[0]));
      expect(l[2], greaterThan(l[1]));
      expect(p.weeks[3].isDeload, isTrue);
      expect(l[3], lessThan(l[2] * 0.85));
      expect(l[4], greaterThan(l[3]));
      expect(p.weeks[7].isDeload, isTrue);
    });

    test('Muskelaufbau: Stufe 5 erst ab Fitness 4, max. 1× pro Woche', () {
      for (final fitness in [1, 2, 3]) {
        final p = generator.generate(
          params: params(fitness: fitness, days: 6),
          availability: plan(['X', 'X', 'X', 'X', 'X', 'X', 'X']),
        );
        expect(
          p.sessions.any((s) => s.level == 5),
          isFalse,
          reason: '$fitness',
        );
      }
      final p = generator.generate(
        params: params(fitness: 4, days: 6),
        availability: plan(['X', 'X', 'X', 'X', 'X', 'X', 'X']),
      );
      for (final w in p.weeks) {
        expect(
          w.sessions.where((s) => s.level == 5).length,
          lessThanOrEqualTo(1),
        );
      }
      expect(p.sessions.any((s) => s.level == 5), isTrue);
    });

    test('Muskelaufbau: Schwerpunkt Stufe 3–4', () {
      final p = generator.generate(
        params: params(days: 5),
        availability: plan(['X', 'X', 'X', 'X', 'X', 'X', 'X']),
      );
      final training = p.sessions.where((s) => s.level >= 2).toList();
      final mid = training.where((s) => s.level == 3 || s.level == 4).length;
      expect(mid / training.length, greaterThan(0.7));
    });

    test('Muskelerhalt: gleichbleibend, 3–4 Einheiten, Stufen 2–4', () {
      final p = generator.generate(
        params: params(goal: TrainingGoal.muskelerhalt, days: 6, weeks: 6),
        availability: plan(['X', 'X', 'X', 'X', 'X', 'X', 'X']),
      );
      final l = loads(p);
      for (final w in p.weeks) {
        final training = w.sessions.where((s) => s.level >= 2).toList();
        expect(training.length, inInclusiveRange(3, 4));
        expect(training.every((s) => s.level >= 2 && s.level <= 4), isTrue);
      }
      final avg = l.reduce((a, b) => a + b) / l.length;
      for (final x in l) {
        expect((x - avg).abs() / avg, lessThan(0.2), reason: '$l');
      }
    });

    test('Kondition: mehr Gelände/Intervall, Intervalle wachsen', () {
      final p = generator.generate(
        params: params(goal: TrainingGoal.kondition, days: 5),
        availability: plan(['X', 'X', 'X', 'X', 'X', 'X', 'X']),
      );
      final forms = p.sessions
          .where((s) => s.level >= 2)
          .map((s) => s.unit.form);
      final kond = forms.where(
        (f) => {'gelaende', 'intervall', 'huegel'}.contains(f),
      );
      expect(kond.length / forms.length, greaterThan(0.4));

      final intervals = p.sessions
          .where((s) => s.unit.key == 'gelaende_intervall')
          .toList();
      expect(intervals.length, greaterThanOrEqualTo(2));
      final first = intervals.first.content.work.first;
      final later = intervals.last.content.work.first;
      expect(first, isNot(later));
      expect(later, contains('min Trab'));
    });

    test('Wiedereinstieg mit Fitness 1: langsam, nie Stufe 5', () {
      final p = generator.generate(
        params: params(
          goal: TrainingGoal.wiedereinstieg,
          fitness: 1,
          days: 5,
          weeks: 8,
        ),
        availability: plan(['X', 'X', 'X', 'X', 'X', 'X', 'X']),
      );
      for (final w in p.weeks) {
        for (final s in w.sessions) {
          expect(s.level, lessThan(5));
          if (w.index < 2) {
            expect(
              s.level,
              lessThanOrEqualTo(2),
              reason: 'Woche ${w.index + 1}',
            );
            expect(s.minutes, lessThanOrEqualTo(30));
            expect(s.unit.tags, isNot(contains('trab')), reason: s.unit.key);
          }
          if (w.index < 3) expect(s.level, lessThan(4));
        }
      }
      expect(p.weeks[3].sessions.any((s) => s.level == 4), isTrue);
      expect(p.weeks[2].sessions.any((s) => s.level == 3), isTrue);
    });

    test('Startbelastung richtet sich nach Fitness', () {
      double firstWeek(int f) => generator
          .generate(
            params: params(fitness: f, days: 4, weeks: 1),
            availability: plan(['X', 'X', 'X', 'X', 'X', 'X', 'X']),
          )
          .weeks
          .first
          .load;
      expect(firstWeek(1), lessThan(firstWeek(5)));
    });
  });

  group('Regel 5: Dienstplan-Kopplung', () {
    test('Einheit + Puffer passt immer in die Stallzeit', () {
      final avail = plan(normalWeek);
      final p = generator.generate(
        params: params(days: 5),
        availability: avail,
      );
      for (final s in p.sessions) {
        expect(
          s.minutes + 20,
          lessThanOrEqualTo(avail[s.date]!.minutes!),
          reason: '${s.date} ${s.unit.key}',
        );
      }
    });

    test('intensive Einheiten auf den Tagen mit der meisten Zeit', () {
      final p = generator.generate(
        params: params(days: 4),
        availability: plan(['S', 'S', 'F', 'S', 'S', 'X', 'X']),
      );
      // Sa/So (150 min) liegen nebeneinander – zwei intensive Tage in Folge
      // sind verboten, also nimmt der Generator den nächstlängeren Tag (90).
      for (final w in p.weeks) {
        final high = w.sessions.where((s) => s.level >= 4).toList();
        expect(high, isNotEmpty);
        expect(high.any((s) => s.reason.availableMinutes == 150), isTrue);
        for (final s in high) {
          expect(s.reason.availableMinutes, greaterThanOrEqualTo(90));
          expect(s.reason.intensive, isTrue);
        }
      }
    });

    test('nach Nachtschicht und bei 0 min keine Trainingseinheit', () {
      final avail = plan(['N', 'N', 'X', 'F', 'F', 'X', 'X']);
      final p = generator.generate(
        params: params(days: 5),
        availability: avail,
      );
      for (final s in p.sessions) {
        final a = avail[s.date]!;
        if (a.afterNightShift || (a.minutes ?? 0) == 0) {
          expect(s.level, lessThanOrEqualTo(1), reason: '${s.date}');
        }
      }
      final w = p.weeks.first;
      expect(w.restDays[start], RestKind.noTime); // Mo: Nacht, 0 min
      // Mi (nach Nacht): Ruhetag oder Aktivpause mit Begründung.
      final wed = start.addDays(2);
      final wedSession = w.sessions.where((s) => s.date == wed).toList();
      if (wedSession.isEmpty) {
        expect(w.restDays[wed], RestKind.afterNight);
      } else {
        expect(wedSession.single.level, 1);
        expect(wedSession.single.reason.afterNightShift, isTrue);
      }
    });

    test('Beisteller-Tage bleiben frei', () {
      final covered = start.addDays(5);
      final avail = plan(
        ['X', 'X', 'X', 'X', 'X', 'X', 'X'],
        extra: {
          covered: ShiftDay(
            date: covered,
            templateId: 'X',
            otherPersonCovers: true,
          ),
        },
      );
      final p = generator.generate(
        params: params(days: 6),
        availability: avail,
      );
      expect(p.sessions.any((s) => s.date == covered), isFalse);
      expect(p.weeks.first.restDays[covered], RestKind.covered);
    });

    test('Woche nur mit Nachtschichten → Warnung, keine Trainingseinheit', () {
      final p = generator.generate(
        params: params(days: 5, weeks: 1),
        availability: plan(['N', 'N', 'N', 'N', 'N', 'N', 'N'], weeks: 1),
      );
      final w = p.weeks.single;
      expect(w.sessions.where((s) => s.level >= 2), isEmpty);
      expect(w.warning, isNotNull);
      expect(w.warning!.achieved, 0);
      expect(w.warning!.requested, 5);
      expect(w.warning!.nightDays + w.warning!.noTimeDays, 7);
    });

    test('6 Tage gewünscht, nur 3 freie Tage → 3 Einheiten + Warnung', () {
      final p = generator.generate(
        params: params(days: 6, weeks: 1),
        availability: plan(['N', 'N', 'X', 'X', 'N', 'X', 'N'], weeks: 1),
      );
      final w = p.weeks.single;
      // Mi, Do (Do = nach Nacht? nein: Mi nach Nacht!) – frei und nicht nach Nacht:
      final training = w.sessions.where((s) => s.level >= 2).toList();
      expect(w.warning, isNotNull);
      expect(w.warning!.requested, 6);
      expect(w.warning!.achieved, training.length);
      expect(training.length, lessThanOrEqualTo(3));
      expect(w.warning!.nightDays, greaterThan(0));
    });

    test('kürzere Einheiten werden vorgeschlagen, wenn es knapp ist', () {
      const kurz = ShiftTemplate(
        id: 'K',
        name: 'Kurz',
        shortCode: 'K',
        colorValue: 0,
        stableMinutes: 37,
      );
      final days = <LocalDate, ShiftDay>{
        for (var i = 0; i < 7; i++)
          start.addDays(i): ShiftDay(date: start.addDays(i), templateId: 'K'),
      };
      final avail = {
        for (final a in availabilityFor(start, start.addDays(6), days, {
          'K': kurz,
        }))
          a.date: a,
      };
      final p = generator.generate(
        params: params(days: 4, weeks: 1),
        availability: avail,
      );
      final w = p.weeks.single;
      expect(w.warning, isNotNull);
      expect(w.warning!.shorterPossible, greaterThan(0));
    });

    test('ohne Dienstplan: Standardzeit angenommen und gekennzeichnet', () {
      final p = generator.generate(
        params: params(days: 4, weeks: 2),
        availability: const {},
      );
      expect(p.sessions, isNotEmpty);
      expect(p.sessions.every((s) => s.reason.assumedMinutes), isTrue);
    });

    test('Stallzeit-Aufteilung bei mehreren Pferden', () {
      final avail = plan(normalWeek);
      final p = generator.generate(
        params: params(days: 4, share: 50),
        availability: avail,
      );
      for (final s in p.sessions) {
        final half = (avail[s.date]!.minutes! * 0.5).floor();
        expect(s.reason.availableMinutes, half);
        expect(s.minutes + 20, lessThanOrEqualTo(half));
      }
    });
  });

  group('Regel 6: Neu verteilen', () {
    test('fixierte Einheiten bleiben, Tage vor „ab“ werden nicht belegt', () {
      final avail = plan(['X', 'X', 'X', 'X', 'X', 'X', 'X']);
      final pinned = FixedSession(
        date: start.addDays(9),
        level: 4,
        form: 'huegel',
      );
      final from = start.addDays(8);
      final p = generator.generate(
        params: params(days: 4),
        availability: avail,
        fixed: [pinned],
        from: from,
      );
      expect(p.sessions.any((s) => s.date.isBefore(from)), isFalse);
      expect(p.sessions.any((s) => s.date == pinned.date), isFalse);
      // Regeneration auch gegenüber der fixierten Einheit.
      final l = levels(p);
      expect(l[pinned.date.addDays(1)] ?? 0, lessThan(4));
      expect(l[pinned.date.addDays(-1)] ?? 0, lessThan(4));
    });
  });

  group('Regel 8: Begründungen und Inhalt', () {
    test('jede Einheit hat Begründung, Aufwärmen, Arbeit, Abwärmen', () {
      final p = generator.generate(
        params: params(days: 5),
        availability: plan(normalWeek),
      );
      for (final s in p.sessions) {
        expect(s.reason.availableMinutes, isNotNull);
        expect(s.reason.shiftName, isNotNull);
        expect(s.content.warmup, isNotEmpty);
        expect(s.content.work, isNotEmpty);
        expect(s.content.cooldown, isNotEmpty);
        expect(s.content.warmup.first, contains('10 min'));
        if (s.level >= 2) expect(s.content.pauseHint, isNotNull);
      }
      expect(
        p.sessions.any((s) => s.reason.daysSinceIntensive != null),
        isTrue,
      );
    });

    test('Ausschlüsse: kein Galopp, kein Springen', () {
      final p = generator.generate(
        params: params(fitness: 5, days: 6, exclusions: {'galopp', 'sprung'}),
        availability: plan(['X', 'X', 'X', 'X', 'X', 'X', 'X']),
      );
      for (final s in p.sessions) {
        expect(s.unit.tags.intersection({'galopp', 'sprung'}), isEmpty);
      }
    });

    test('Tauschen liefert eine andere Einheit derselben Stufe', () {
      final ps = params(days: 5);
      final p = generator.generate(params: ps, availability: plan(normalWeek));
      final s = p.sessions.firstWhere((s) => s.level == 3);
      final alt = generator.alternative(s, ps, 0);
      expect(alt, isNotNull);
      expect(alt!.level, 3);
      expect(alt.unit.key, isNot(s.unit.key));
      expect(alt.date, s.date);
    });

    test('Ergebnis ist deterministisch', () {
      GeneratedPlan run() => generator.generate(
        params: params(days: 5),
        availability: plan(normalWeek),
      );
      final a = run().sessions.map(
        (s) => '${s.date}-${s.unit.key}-${s.minutes}',
      );
      final b = run().sessions.map(
        (s) => '${s.date}-${s.unit.key}-${s.minutes}',
      );
      expect(a.toList(), b.toList());
    });
  });

  test('Parameter überleben JSON hin und zurück', () {
    final p = params(exclusions: {'galopp'}, share: 50);
    final back = TrainingParams.fromJson(
      jsonDecode(jsonEncode(p.toJson())) as Map<String, Object?>,
    );
    expect(back.goal, p.goal);
    expect(back.forms, p.forms);
    expect(back.exclusions, {'galopp'});
    expect(back.startDate, start);
    expect(back.sharePercent, 50);
    expect(formatMinutes(3.5), '3,5');
    expect(formatMinutes(4), '4');
  });
}
