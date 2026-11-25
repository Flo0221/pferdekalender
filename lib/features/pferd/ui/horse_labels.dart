import '../../../core/time/local_date.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../domain/contact.dart';
import '../domain/horse.dart';
import '../domain/horse_logic.dart';

/// Deutsche Bezeichnungen für Domain-Enums.
extension HorseSexLabel on HorseSex {
  String label(AppLocalizations l10n) => switch (this) {
    HorseSex.stute => l10n.horseSexStute,
    HorseSex.wallach => l10n.horseSexWallach,
    HorseSex.hengst => l10n.horseSexHengst,
  };
}

extension ContactRoleLabel on ContactRole {
  String label(AppLocalizations l10n) => switch (this) {
    ContactRole.tierarzt => l10n.contactRole_tierarzt,
    ContactRole.hufschmied => l10n.contactRole_hufschmied,
    ContactRole.zahnarzt => l10n.contactRole_zahnarzt,
    ContactRole.physio => l10n.contactRole_physio,
    ContactRole.sattler => l10n.contactRole_sattler,
    ContactRole.trainer => l10n.contactRole_trainer,
    ContactRole.stall => l10n.contactRole_stall,
    ContactRole.besitzer => l10n.contactRole_besitzer,
    ContactRole.notfall => l10n.contactRole_notfall,
    ContactRole.sonstige => l10n.contactRole_sonstige,
  };
}

/// „12 Jahre“ bzw. „8 Monate“ für Fohlen; `null` ohne Geburtstag.
String? ageLabel(AppLocalizations l10n, LocalDate? birthDate, LocalDate today) {
  if (birthDate == null) return null;
  final age = ageOn(birthDate, today);
  if (age == null) return null;
  return age.years >= 1 ? l10n.ageYears(age.years) : l10n.ageMonths(age.months);
}
