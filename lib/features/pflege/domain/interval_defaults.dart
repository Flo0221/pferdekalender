import 'care_type.dart';
import 'repeat_interval.dart';

/// Vorgeschlagenes Intervall für eine Eintragsart (+ optional Variante).
/// Nur ein Vorschlag – ersetzt keine Absprache mit Tierarzt/Hufschmied.
class IntervalDefault {
  const IntervalDefault({
    required this.typeId,
    this.variantKey,
    required this.interval,
  });

  final String typeId;

  /// `null` = gilt für die Art ohne bestimmte Variante.
  final String? variantKey;
  final RepeatInterval interval;
}

/// Startwerte (in den Einstellungen änderbar).
const defaultIntervals = <IntervalDefault>[
  IntervalDefault(
    typeId: BuiltinCareTypes.huf,
    variantKey: 'beschlag',
    interval: RepeatInterval(7, IntervalUnit.weeks),
  ),
  IntervalDefault(
    typeId: BuiltinCareTypes.huf,
    variantKey: 'barhuf',
    interval: RepeatInterval(6, IntervalUnit.weeks),
  ),
  IntervalDefault(
    typeId: BuiltinCareTypes.impfung,
    variantKey: 'influenza',
    interval: RepeatInterval(6, IntervalUnit.months),
  ),
  IntervalDefault(
    typeId: BuiltinCareTypes.impfung,
    variantKey: 'herpes',
    interval: RepeatInterval(6, IntervalUnit.months),
  ),
  IntervalDefault(
    typeId: BuiltinCareTypes.impfung,
    variantKey: 'tetanus',
    interval: RepeatInterval(2, IntervalUnit.years),
  ),
  IntervalDefault(
    typeId: BuiltinCareTypes.impfung,
    variantKey: 'tollwut',
    interval: RepeatInterval(12, IntervalUnit.months),
  ),
  IntervalDefault(
    typeId: BuiltinCareTypes.impfung,
    variantKey: 'westnil',
    interval: RepeatInterval(12, IntervalUnit.months),
  ),
  IntervalDefault(
    typeId: BuiltinCareTypes.zahnarzt,
    interval: RepeatInterval(12, IntervalUnit.months),
  ),
];

/// Sucht den passendsten Vorschlag: erst Art + Variante, dann nur Art.
RepeatInterval? suggestInterval(
  List<IntervalDefault> defaults,
  String typeId,
  String? variantKey,
) {
  IntervalDefault? typeOnly;
  for (final d in defaults) {
    if (d.typeId != typeId) continue;
    if (variantKey != null && d.variantKey == variantKey) return d.interval;
    if (d.variantKey == null) typeOnly = d;
  }
  return typeOnly?.interval;
}
