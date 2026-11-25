import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:pferdekalender/core/time/local_date.dart';
import 'package:pferdekalender/features/gesundheit/domain/blood.dart';
import 'package:pferdekalender/features/gesundheit/domain/blood_evaluation.dart';

final catalog = BloodCatalog.fromJson(
  (jsonDecode(File('assets/blood_reference.json').readAsStringSync()) as Map)
      .cast<String, Object?>(),
);

BloodTest test0(List<BloodValue> values, {LocalDate? date}) => BloodTest(
  id: 't',
  horseId: 'h',
  date: date ?? LocalDate(2026, 11, 20),
  values: values,
);

BloodValue v(String k, double x, {double? low, double? high}) =>
    BloodValue(paramKey: k, value: x, refLow: low, refHigh: high);

void main() {
  group('Referenzdatei', () {
    test('Laboklin-Werte 2025/26 korrekt hinterlegt', () {
      expect(catalog.parameters.length, greaterThanOrEqualTo(50));
      expect(catalog.parameter('ggt')!.high, 44);
      expect(catalog.parameter('gldh')!.high, 13);
      expect(catalog.parameter('ast')!.high, 568);
      expect(catalog.parameter('ck')!.high, 452);
      expect(catalog.parameter('selen')!.low, 100);
      expect(catalog.parameter('selen')!.high, 200);
      expect(catalog.parameter('zink')!.low, 5.0);
      expect(catalog.parameter('zink')!.high, 14.4);
      expect(catalog.parameter('harnstoff')!.low, 3.3);
      expect(catalog.parameter('haemoglobin')!.low, 110);
      expect(catalog.parameter('vitamin_e')!.low, 2.0);
      expect(catalog.parameter('vitamin_e')!.high, isNull);
      expect(catalog.source, contains('Laboklin'));
    });

    test('jede Regel verweist auf bekannte Werte und Bausteine', () {
      final keys = {for (final p in catalog.parameters) p.key};
      for (final r in catalog.rules) {
        expect(keys, contains(r.param));
        for (final s in r.suggestions) {
          expect(catalog.suggestions, contains(s), reason: s);
        }
      }
      expect(catalog.suggestions['tierarzt'], isNotNull);
      expect(catalog.suggestions['kontrolle'], isNotNull);
      for (final p in catalog.parameters) {
        expect(catalog.categories, contains(p.category), reason: p.key);
      }
    });

    test('Bausteine ohne Markennamen', () {
      for (final s in catalog.suggestions.values) {
        expect(s.title, isNot(contains('®')));
        expect(s.itemName ?? '', isNot(contains('®')));
      }
    });
  });

  group('Bewertung', () {
    test('nicht eingetragene Werte gelten als im Bereich', () {
      final e = evaluate(test0(const []), catalog);
      expect(e.deviations, isEmpty);
      expect(e.interpretations, isEmpty);
      expect(e.summary, isEmpty);
      expect(e.suggestions, isEmpty);
    });

    test('Wert im Bereich erzeugt keinen Hinweis', () {
      final e = evaluate(test0([v('ggt', 30)]), catalog);
      expect(e.findings.single.direction, isNull);
      expect(e.interpretations, isEmpty);
    });

    test('γ-GT leicht erhöht: Leber-Baustein, Kontrolle nach 3 Wochen', () {
      final e = evaluate(test0([v('ggt', 60)]), catalog);
      expect(e.findings.single.direction, Direction.high);
      expect(e.findings.single.strong, isFalse);
      expect(e.summary, ['Leberwerte erhöht']);
      expect(
        e.suggestions.map((s) => s.key),
        containsAll(['leber_ergaenzung', 'heu_hygiene', 'kontrolle']),
      );
      expect(e.controlWeeks, 3);
      expect(e.vetFirst, isFalse);
    });

    test('γ-GT stark erhöht → zuerst Tierarzt', () {
      final e = evaluate(test0([v('ggt', 200)]), catalog);
      expect(e.findings.single.strong, isTrue);
      expect(e.vetFirst, isTrue);
      expect(e.suggestions.first.key, 'tierarzt');
    });

    test('Muster GLDH + γ-GT → Kombi-Hinweis mit Tierarzt', () {
      final e = evaluate(test0([v('gldh', 20), v('ggt', 60)]), catalog);
      final combo = e.interpretations.firstWhere((i) => i.isCombo);
      expect(combo.title, contains('Leber'));
      expect(combo.vetFirst, isTrue);
    });

    test('CK + AST bei normaler GLDH → Muskel statt Leber', () {
      final e = evaluate(test0([v('ck', 900), v('ast', 700)]), catalog);
      expect(
        e.interpretations.any((i) => i.isCombo && i.title.contains('Muskel')),
        isTrue,
      );
      expect(e.summary, ['Muskelwerte erhöht']);
      final withGldh = evaluate(
        test0([v('ck', 900), v('ast', 700), v('gldh', 20)]),
        catalog,
      );
      expect(
        withGldh.interpretations.any(
          (i) => i.isCombo && i.title.contains('Muskel'),
        ),
        isFalse,
      );
    });

    test('Selen und Vitamin E niedrig → kombinierte Ergänzung, keine Tierarzt-Pflicht', () {
      final e = evaluate(test0([v('selen', 80), v('vitamin_e', 1.7)]), catalog);
      expect(e.summary, ['Selen zu niedrig', 'Vitamin E zu niedrig']);
      expect(
        e.suggestions.map((s) => s.key),
        containsAll(['selen_vite', 'vitamin_e']),
      );
      expect(e.vetFirst, isFalse);
      final sel = e.suggestions.firstWhere((s) => s.key == 'selen_vite');
      expect(sel.text, contains('giftig'));
      expect(sel.itemName, isNotNull);
      expect(sel.weeks, 8);
    });

    test('Selen über 300 ist „deutlich“ erhöht', () {
      final e = evaluate(test0([v('selen', 320)]), catalog);
      expect(e.findings.single.strong, isTrue);
      expect(e.summary, ['Selen zu hoch']);
      expect(e.suggestions.map((s) => s.key), contains('ergaenzung_pruefen'));
    });

    test('Eisen niedrig: kein Eisen-Zusatz, sondern Tierarzt + Kotprobe', () {
      final e = evaluate(test0([v('eisen', 12)]), catalog);
      expect(e.vetFirst, isTrue);
      expect(
        e.suggestions.map((s) => s.key),
        containsAll(['tierarzt', 'kotprobe']),
      );
      expect(
        e.suggestions.any((s) => s.kind == SuggestionKind.supplement),
        isFalse,
      );
    });

    test('eigener Referenzbereich vom Befund hat Vorrang', () {
      final own = evaluate(test0([v('ggt', 50, high: 60)]), catalog);
      expect(own.findings.single.direction, isNull);
      expect(own.findings.single.high, 60);
      final low = evaluate(
        test0([v('zink', 8, low: 9.2, high: 19.9)]),
        catalog,
      );
      expect(low.findings.single.direction, Direction.low);
    });

    test('ACTH wird saisonal bewertet', () {
      // 25 pg/ml: im Mai erhöht, im September normal.
      final may = evaluate(
        test0([v('acth', 25)], date: LocalDate(2026, 5, 10)),
        catalog,
      );
      expect(may.findings.single.direction, Direction.high);
      final sep = evaluate(
        test0([v('acth', 25)], date: LocalDate(2026, 9, 10)),
        catalog,
      );
      expect(sep.findings.single.direction, isNull);
      final strong = evaluate(
        test0([v('acth', 60)], date: LocalDate(2026, 3, 1)),
        catalog,
      );
      expect(strong.findings.single.strong, isTrue);
    });

    test('Insulin + Glucose → EMS-Hinweis, stärke-/zuckerarm', () {
      final e = evaluate(test0([v('insulin', 28), v('glucose', 6)]), catalog);
      expect(
        e.interpretations.any(
          (i) => i.isCombo && i.title.contains('Metabolisch'),
        ),
        isTrue,
      );
      expect(e.suggestions.map((s) => s.key), contains('zuckerarm'));
    });

    test('Kontrolle = kürzeste Frist aller Regeln', () {
      final e = evaluate(test0([v('ck', 900), v('selen', 80)]), catalog);
      expect(e.controlWeeks, 1);
    });
  });

  group('Suche', () {
    test('findet über Name, Kürzel, Synonyme, ohne Umlaute', () {
      List<String> s(String q) =>
          searchParameters(catalog.parameters, q).map((p) => p.key).toList();
      expect(s('ggt'), contains('ggt'));
      expect(s('gamma'), contains('ggt'));
      expect(s('Hämo'), contains('haemoglobin'));
      expect(s('haemo'), contains('haemoglobin'));
      expect(s('zink'), ['zink']);
      expect(s('Glukose'), contains('glucose'));
      expect(s(''), hasLength(catalog.parameters.length));
      expect(s('xyz'), isEmpty);
    });
  });
}
