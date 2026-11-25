import 'blood.dart';

/// Bewertung eines einzelnen eingetragenen Werts.
class ValueFinding {
  const ValueFinding({
    required this.parameter,
    required this.value,
    required this.low,
    required this.high,
    required this.direction,
    required this.strong,
  });

  final BloodParameter parameter;
  final BloodValue value;

  /// Tatsächlich verwendete Grenzen (Befund > saisonal > Referenz).
  final double? low;
  final double? high;

  /// `null` = im Referenzbereich.
  final Direction? direction;

  /// Deutlich außerhalb des Bereichs.
  final bool strong;
}

/// Ein Auswertungshinweis (Einzelwert oder Muster).
class Interpretation {
  const Interpretation({
    required this.title,
    required this.text,
    required this.vetFirst,
    required this.suggestions,
    this.isCombo = false,
    this.paramKey,
  });

  final String title;
  final String text;

  /// Zuerst tierärztlich abklären.
  final bool vetFirst;
  final List<String> suggestions;
  final bool isCombo;
  final String? paramKey;
}

/// Ergebnis der Auswertung eines Blutbilds.
class BloodEvaluation {
  const BloodEvaluation({
    required this.findings,
    required this.interpretations,
    required this.suggestions,
    required this.summary,
    required this.controlWeeks,
    required this.vetFirst,
  });

  /// Alle eingetragenen Werte (auch solche im Bereich).
  final List<ValueFinding> findings;
  final List<Interpretation> interpretations;

  /// Eindeutige Vorschläge in sinnvoller Reihenfolge.
  final List<BloodSuggestion> suggestions;

  /// Kurzinfo, z. B. „Leberwerte erhöht“, „Selen zu niedrig“.
  final List<String> summary;

  /// Empfohlene Kontrolle in Wochen (kleinster Wert der Regeln) oder `null`.
  final int? controlWeeks;

  /// Mindestens ein Hinweis rät, zuerst den Tierarzt zu fragen.
  final bool vetFirst;

  List<ValueFinding> get deviations =>
      findings.where((f) => f.direction != null).toList();
}

/// Bewertet einen Wert gegen seinen Referenzbereich.
ValueFinding judge(BloodParameter p, BloodValue v, int month) {
  final (seasonHigh, seasonStrong) = p.highFor(month);
  final low = v.refLow ?? p.low;
  final high = v.refHigh ?? seasonHigh;
  Direction? dir;
  var strong = false;
  if (low != null && v.value < low) {
    dir = Direction.low;
    final limit = p.strongLow ?? low * 0.5;
    strong = v.value < limit;
  } else if (high != null && v.value > high) {
    dir = Direction.high;
    final limit = (v.refHigh == null ? seasonStrong : null) ?? high * 2;
    strong = v.value > limit;
  }
  return ValueFinding(
    parameter: p,
    value: v,
    low: low,
    high: high,
    direction: dir,
    strong: strong,
  );
}

/// Regelbasierte Auswertung. Nicht eingetragene Werte gelten als im
/// Referenzbereich. Reines Dart; Texte stammen aus der Referenzdatei.
BloodEvaluation evaluate(BloodTest test, BloodCatalog catalog) {
  final findings = <ValueFinding>[
    for (final v in test.values)
      if (catalog.parameter(v.paramKey) case final p?)
        judge(p, v, test.date.month),
  ];
  final dirOf = {
    for (final f in findings)
      if (f.direction != null) f.parameter.key: f.direction!,
  };
  bool holds(Condition c) => dirOf[c.$1] == c.$2;

  final interpretations = <Interpretation>[];
  final suggestionKeys = <String>[];
  void addSuggestions(Iterable<String> keys) {
    for (final k in keys) {
      if (!suggestionKeys.contains(k)) suggestionKeys.add(k);
    }
  }

  // 1. Muster aus mehreren Werten.
  for (final c in catalog.combos) {
    final ok =
        c.all.every(holds) &&
        (c.any.isEmpty || c.any.any(holds)) &&
        !c.none.any(holds);
    if (!ok) continue;
    interpretations.add(
      Interpretation(
        title: c.title,
        text: c.text,
        vetFirst: c.vetFirst,
        suggestions: c.suggestions,
        isCombo: true,
      ),
    );
    addSuggestions(c.suggestions);
  }

  // 2. Einzelwerte.
  int? control;
  for (final f in findings) {
    final dir = f.direction;
    if (dir == null) continue;
    for (final r in catalog.rules) {
      if (r.param != f.parameter.key || r.direction != dir) continue;
      final vet = r.vetFirst || (f.strong && r.vetIfStrong);
      interpretations.add(
        Interpretation(
          title: f.parameter.name,
          text: r.text,
          vetFirst: vet,
          suggestions: r.suggestions,
          paramKey: f.parameter.key,
        ),
      );
      addSuggestions(r.suggestions);
      if (r.controlWeeks != null &&
          (control == null || r.controlWeeks! < control)) {
        control = r.controlWeeks;
      }
    }
  }

  final vetFirst = interpretations.any((i) => i.vetFirst);
  if (vetFirst) addSuggestions(['tierarzt']);
  if (control != null) addSuggestions(['kontrolle']);

  // Reihenfolge: Tierarzt, Futter, Fütterung, Management, Termine.
  int rank(BloodSuggestion s) => switch (s.kind) {
    SuggestionKind.care when s.key == 'tierarzt' => 0,
    SuggestionKind.supplement => 1,
    SuggestionKind.ration => 2,
    SuggestionKind.management => 3,
    SuggestionKind.care => 4,
  };
  final suggestions = [for (final k in suggestionKeys) ?catalog.suggestions[k]]
    ..sort((a, b) => rank(a).compareTo(rank(b)));

  return BloodEvaluation(
    findings: findings,
    interpretations: interpretations,
    suggestions: suggestions,
    summary: summaryLabels(findings, catalog),
    controlWeeks: control,
    vetFirst: vetFirst,
  );
}

/// „Leberwerte erhöht“, „Selen zu niedrig“ … (eindeutig, Reihenfolge der
/// Eingabe).
List<String> summaryLabels(List<ValueFinding> findings, BloodCatalog catalog) {
  final out = <String>[];
  for (final f in findings) {
    final dir = f.direction;
    if (dir == null) continue;
    final label = f.parameter.summaryByParameter
        ? '${f.parameter.name} ${dir == Direction.high ? 'zu hoch' : 'zu niedrig'}'
        : '${catalog.categories[f.parameter.category] ?? f.parameter.name} '
              '${dir == Direction.high ? 'erhöht' : 'erniedrigt'}';
    if (!out.contains(label)) out.add(label);
  }
  return out;
}

/// Suche über Name, Kürzel und Synonyme (ohne Groß-/Kleinschreibung,
/// Umlaute und Sonderzeichen).
List<BloodParameter> searchParameters(
  List<BloodParameter> params,
  String query,
) {
  final q = normalizeSearch(query);
  if (q.isEmpty) return params;
  return [
    for (final p in params)
      if ([
        p.name,
        p.key,
        ...p.aliases,
      ].any((s) => normalizeSearch(s).contains(q)))
        p,
  ];
}

String normalizeSearch(String s) => s
    .toLowerCase()
    .replaceAll('ä', 'ae')
    .replaceAll('ö', 'oe')
    .replaceAll('ü', 'ue')
    .replaceAll('ß', 'ss')
    .replaceAll('γ', 'g')
    .replaceAll('α', 'a')
    .replaceAll('β', 'b')
    .replaceAll(RegExp(r'[^a-z0-9]'), '');
