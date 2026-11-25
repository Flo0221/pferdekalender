/// Welches Formular eine Eintragsart nutzt.
enum CareKind {
  huf('huf'),
  wurmkur('wurmkur'),
  kotprobe('kotprobe'),
  impfung('impfung'),
  allgemein('allgemein');

  const CareKind(this.key);
  final String key;

  static CareKind fromKey(String? key) =>
      values.firstWhere((k) => k.key == key, orElse: () => CareKind.allgemein);
}

/// Eine Eintragsart im Pflege-Kalender (Hufe, Wurmkur, …). Eingebaute Arten
/// haben feste IDs (siehe [BuiltinCareTypes]); eigene Arten eine UUID.
class CareType {
  const CareType({
    required this.id,
    required this.name,
    required this.kind,
    required this.colorValue,
    required this.iconKey,
    this.builtin = false,
    this.archived = false,
    this.sortOrder = 0,
  });

  final String id;
  final String name;
  final CareKind kind;

  /// ARGB-Farbwert (0xFFRRGGBB).
  final int colorValue;

  /// Schlüssel für das Icon (siehe UI: `careIconFor`).
  final String iconKey;
  final bool builtin;
  final bool archived;
  final int sortOrder;
}

/// Varianten (z. B. Beschlagsart, Impfung). Die Schlüssel werden gespeichert.
abstract final class CareVariants {
  static const huf = [
    'barhuf',
    'beschlag',
    'kunststoff',
    'orthopaedisch',
    'hufschuhe',
  ];
  static const impfung = [
    'tetanus',
    'influenza',
    'herpes',
    'tollwut',
    'westnil',
    'druse',
    'sonstige',
  ];

  static List<String> forKind(CareKind kind) => switch (kind) {
    CareKind.huf => huf,
    CareKind.impfung => impfung,
    _ => const [],
  };
}

/// Eingebaute Eintragsarten. IDs nie ändern (stehen in Daten und Backups).
abstract final class BuiltinCareTypes {
  static const huf = 'builtin_huf';
  static const wurmkur = 'builtin_wurmkur';
  static const kotprobe = 'builtin_kotprobe';
  static const impfung = 'builtin_impfung';
  static const tierarzt = 'builtin_tierarzt';
  static const zahnarzt = 'builtin_zahnarzt';
  static const physio = 'builtin_physio';
  static const sattler = 'builtin_sattler';
  static const sonstiges = 'builtin_sonstiges';

  /// Name, Art, Farbe, Icon – Startwerte, vom Nutzer änderbar (außer Art).
  static const all = <CareType>[
    CareType(
      id: huf,
      name: 'Hufbearbeitung',
      kind: CareKind.huf,
      colorValue: 0xFF8D6E63,
      iconKey: 'huf',
      builtin: true,
      sortOrder: 0,
    ),
    CareType(
      id: wurmkur,
      name: 'Wurmkur',
      kind: CareKind.wurmkur,
      colorValue: 0xFF7CB342,
      iconKey: 'wurmkur',
      builtin: true,
      sortOrder: 1,
    ),
    CareType(
      id: kotprobe,
      name: 'Kotprobe',
      kind: CareKind.kotprobe,
      colorValue: 0xFF9E9D24,
      iconKey: 'kotprobe',
      builtin: true,
      sortOrder: 2,
    ),
    CareType(
      id: impfung,
      name: 'Impfung',
      kind: CareKind.impfung,
      colorValue: 0xFF1E88E5,
      iconKey: 'impfung',
      builtin: true,
      sortOrder: 3,
    ),
    CareType(
      id: tierarzt,
      name: 'Tierarzt',
      kind: CareKind.allgemein,
      colorValue: 0xFFE53935,
      iconKey: 'tierarzt',
      builtin: true,
      sortOrder: 4,
    ),
    CareType(
      id: zahnarzt,
      name: 'Zahnarzt',
      kind: CareKind.allgemein,
      colorValue: 0xFF00ACC1,
      iconKey: 'zahnarzt',
      builtin: true,
      sortOrder: 5,
    ),
    CareType(
      id: physio,
      name: 'Osteopath/Physio',
      kind: CareKind.allgemein,
      colorValue: 0xFF8E24AA,
      iconKey: 'physio',
      builtin: true,
      sortOrder: 6,
    ),
    CareType(
      id: sattler,
      name: 'Sattler',
      kind: CareKind.allgemein,
      colorValue: 0xFFF4511E,
      iconKey: 'sattler',
      builtin: true,
      sortOrder: 7,
    ),
    CareType(
      id: sonstiges,
      name: 'Sonstiges',
      kind: CareKind.allgemein,
      colorValue: 0xFF757575,
      iconKey: 'sonstiges',
      builtin: true,
      sortOrder: 8,
    ),
  ];
}
