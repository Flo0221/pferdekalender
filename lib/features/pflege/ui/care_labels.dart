import 'package:material_ui/material_ui.dart';

import '../../../core/format/formatters.dart';
import '../../../core/time/local_date.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../domain/care_event.dart';
import '../domain/repeat_interval.dart';

/// Wählbare Symbole für Eintragsarten (Schlüssel wird gespeichert).
const careIcons = <String, IconData>{
  'huf': Icons.construction_outlined,
  'wurmkur': Icons.medication_outlined,
  'kotprobe': Icons.science_outlined,
  'impfung': Icons.vaccines_outlined,
  'tierarzt': Icons.medical_services_outlined,
  'zahnarzt': Icons.mood_outlined,
  'physio': Icons.self_improvement_outlined,
  'sattler': Icons.chair_outlined,
  'sonstiges': Icons.event_note_outlined,
  'pflege': Icons.spa_outlined,
  'transport': Icons.local_shipping_outlined,
  'turnier': Icons.emoji_events_outlined,
  'futter': Icons.grass_outlined,
  'stern': Icons.star_outline,
};

IconData careIconFor(String key) => careIcons[key] ?? Icons.event_note_outlined;

/// Wählbare Farben für eigene Arten.
const careColors = <int>[
  0xFF8D6E63,
  0xFF7CB342,
  0xFF9E9D24,
  0xFF1E88E5,
  0xFFE53935,
  0xFF00ACC1,
  0xFF8E24AA,
  0xFFF4511E,
  0xFF757575,
  0xFF3949AB,
  0xFFD81B60,
  0xFF00897B,
];

String variantLabel(AppLocalizations l10n, String key) => switch (key) {
  'barhuf' => l10n.careVariant_barhuf,
  'beschlag' => l10n.careVariant_beschlag,
  'kunststoff' => l10n.careVariant_kunststoff,
  'orthopaedisch' => l10n.careVariant_orthopaedisch,
  'hufschuhe' => l10n.careVariant_hufschuhe,
  'tetanus' => l10n.careVariant_tetanus,
  'influenza' => l10n.careVariant_influenza,
  'herpes' => l10n.careVariant_herpes,
  'tollwut' => l10n.careVariant_tollwut,
  'westnil' => l10n.careVariant_westnil,
  'druse' => l10n.careVariant_druse,
  'sonstige' => l10n.careVariant_sonstige,
  _ => key,
};

String unitLabel(AppLocalizations l10n, IntervalUnit unit, int n) =>
    switch (unit) {
      IntervalUnit.days => l10n.unitDays(n),
      IntervalUnit.weeks => l10n.unitWeeks(n),
      IntervalUnit.months => l10n.unitMonths(n),
      IntervalUnit.years => l10n.unitYears(n),
    };

String intervalLabel(AppLocalizations l10n, RepeatInterval i) =>
    l10n.intervalText(i.value, unitLabel(l10n, i.unit, i.value));

/// „Hufbearbeitung · Beschlag“, „Impfung · Influenza“, „Tierarzt · Kolik“.
String eventTitle(AppLocalizations l10n, CareEvent e, String typeName) {
  final customVaccine = e.fields[CareFields.impfungName];
  final praeparat = e.fields[CareFields.praeparat];
  final String? detail;
  if (e.variantKey == 'sonstige' && customVaccine is String) {
    detail = customVaccine;
  } else if (e.variantKey != null) {
    detail = variantLabel(l10n, e.variantKey!);
  } else if (e.title != null) {
    detail = e.title;
  } else if (praeparat is String) {
    detail = praeparat;
  } else {
    detail = null;
  }
  return detail == null || detail.isEmpty ? typeName : '$typeName · $detail';
}

/// Kurze Zusatzinfo für Listen (Uhrzeit, Person, Präparat, EpG …).
String eventSubtitle(AppLocalizations l10n, CareEvent e) {
  final parts = <String>[
    if (e.timeMinutes != null) Fmt.time(e.timeMinutes!),
    ?e.person,
    if (e.fields[CareFields.wirkstoff] case final String w) w,
    if (e.fields[CareFields.labor] case final String lab) lab,
    if (e.fields[CareFields.epg] case final int epg) l10n.careEpgValue(epg),
    if (e.costCents != null) l10n.careCostValue(Fmt.money(e.costCents!)),
  ];
  return parts.join(' · ');
}

/// „heute“, „morgen“, „in 5 Tagen“ oder Datum.
String relativeDay(AppLocalizations l10n, LocalDate date, LocalDate today) {
  final d = today.daysUntil(date);
  if (d == 0) return l10n.careToday;
  if (d == 1) return l10n.careTomorrow;
  if (d > 1 && d <= 14) return l10n.careInDays(d);
  return Fmt.date(date);
}
