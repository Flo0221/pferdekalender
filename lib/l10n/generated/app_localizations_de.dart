// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'Pferdekalender';

  @override
  String get tabPflege => 'Pflege';

  @override
  String get tabTraining => 'Training';

  @override
  String get tabFutter => 'Futter';

  @override
  String get tabDienst => 'Dienst';

  @override
  String get tabPferd => 'Pferd';

  @override
  String get titlePflege => 'Pflege-Kalender';

  @override
  String get titleTraining => 'Training';

  @override
  String get titleFutter => 'Futterplan';

  @override
  String get titleDienst => 'Mein Dienstplan';

  @override
  String get titlePferd => 'Pferd';

  @override
  String get titleSettings => 'Einstellungen';

  @override
  String get actionSettings => 'Einstellungen öffnen';

  @override
  String get emptyPflegeTitle => 'Noch keine Pflegetermine';

  @override
  String get emptyPflegeMessage =>
      'Hier erscheinen bald Hufe, Wurmkuren, Impfungen und Tierarzttermine.';

  @override
  String get emptyTrainingTitle => 'Noch kein Training geplant';

  @override
  String get emptyTrainingMessage =>
      'Hier erscheinen bald Trainingseinheiten und der Plan-Generator.';

  @override
  String get emptyFutterTitle => 'Noch kein Futterplan';

  @override
  String get emptyFutterMessage =>
      'Hier erscheinen bald Futtermittel, Mahlzeiten und Rationen.';

  @override
  String get emptyDienstTitle => 'Noch keine Schichten';

  @override
  String get emptyDienstMessage =>
      'Hier erscheinen bald deine Schichten und die Stallzeit pro Tag.';

  @override
  String get emptyPferdTitle => 'Noch kein Pferd angelegt';

  @override
  String get emptyPferdMessage =>
      'Hier legst du bald deine Pferde mit Profil und Fotos an.';

  @override
  String get settingsAppearance => 'Darstellung';

  @override
  String get settingsThemeSystem => 'Wie System';

  @override
  String get settingsThemeLight => 'Hell';

  @override
  String get settingsThemeDark => 'Dunkel';

  @override
  String get settingsNoticeTitle => 'Hinweis';

  @override
  String get disclaimer =>
      'Intervalle und Trainingsvorschläge ersetzen keine Absprache mit Tierarzt, Hufschmied oder Trainer.';

  @override
  String get settingsPrivacyTitle => 'Datenschutz';

  @override
  String get settingsPrivacyText =>
      'Alle Daten bleiben auf diesem Gerät. Die App hat keinen Internetzugriff und nimmt nicht an der automatischen Android-Sicherung teil. Sichere deine Daten über den Export (folgt in einer späteren Version).';

  @override
  String get settingsAbout => 'Über die App';
}
