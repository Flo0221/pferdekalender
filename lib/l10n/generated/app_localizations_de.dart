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
      'Lege Hufbearbeitung, Wurmkur, Impfung oder Tierarzttermine an. Mit Wiederholung plant die App den nächsten Termin automatisch.';

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
      'Lege dein Pferd mit Profil, Fotos, Gewicht und Kontakten an. Alle Bereiche der App beziehen sich dann auf das ausgewählte Pferd.';

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

  @override
  String get actionSave => 'Speichern';

  @override
  String get actionCancel => 'Abbrechen';

  @override
  String get actionDelete => 'Löschen';

  @override
  String get actionEdit => 'Bearbeiten';

  @override
  String get actionAdd => 'Hinzufügen';

  @override
  String get actionClose => 'Schließen';

  @override
  String get actionRemove => 'Entfernen';

  @override
  String get fieldRequired => 'Bitte ausfüllen';

  @override
  String get fieldInvalidNumber => 'Bitte eine gültige Zahl eingeben';

  @override
  String get notSet => 'Nicht angegeben';

  @override
  String get emptyPferdAction => 'Erstes Pferd anlegen';

  @override
  String get horseSwitcherTooltip => 'Pferd wechseln';

  @override
  String get horseSwitcherManage => 'Pferde verwalten';

  @override
  String get horseListTitle => 'Meine Pferde';

  @override
  String get horseListActive => 'Aktiv';

  @override
  String get horseListArchived => 'Archiviert';

  @override
  String get horseListEmptyArchived => 'Keine archivierten Pferde';

  @override
  String get horseAdd => 'Pferd anlegen';

  @override
  String get horseNew => 'Neues Pferd';

  @override
  String get horseEditTitle => 'Pferd bearbeiten';

  @override
  String get horseArchive => 'Archivieren';

  @override
  String get horseUnarchive => 'Wiederherstellen';

  @override
  String horseArchiveConfirmTitle(String name) {
    return '$name archivieren?';
  }

  @override
  String get horseArchiveConfirmText =>
      'Das Pferd wird ausgeblendet. Alle Daten bleiben erhalten und du kannst es jederzeit wiederherstellen.';

  @override
  String get horseDeleteForever => 'Endgültig löschen';

  @override
  String horseDeleteConfirmTitle(String name) {
    return '$name endgültig löschen?';
  }

  @override
  String get horseDeleteConfirmText =>
      'Alle Daten dieses Pferdes (Fotos, Gewichte, Kontakt-Zuordnungen und später auch Termine, Trainings- und Futterpläne) werden unwiderruflich gelöscht. Das kann nicht rückgängig gemacht werden.';

  @override
  String get horseDeleteConfirmContinue => 'Weiter';

  @override
  String horseDeleteTypeName(String name) {
    return 'Zur Bestätigung den Namen „$name“ eingeben';
  }

  @override
  String horseDeleted(String name) {
    return '$name wurde gelöscht';
  }

  @override
  String horseArchived(String name) {
    return '$name wurde archiviert';
  }

  @override
  String get horseSectionGeneral => 'Allgemein';

  @override
  String get horseSectionIdentification => 'Identifikation';

  @override
  String get horseSectionPedigree => 'Abstammung';

  @override
  String get horseSectionKeeping => 'Haltung & Besitz';

  @override
  String get horseSectionHealth => 'Gesundheit';

  @override
  String get horseSectionNotes => 'Notizen';

  @override
  String get horseSectionContacts => 'Kontakte';

  @override
  String get horseSectionWeight => 'Gewicht';

  @override
  String get horseSectionPhotos => 'Fotos';

  @override
  String get horseFieldName => 'Name';

  @override
  String get horseFieldCallName => 'Rufname';

  @override
  String get horseFieldBirthDate => 'Geburtstag';

  @override
  String get horseFieldSex => 'Geschlecht';

  @override
  String get horseFieldBreed => 'Rasse';

  @override
  String get horseFieldColor => 'Farbe / Abzeichen';

  @override
  String get horseFieldHeight => 'Stockmaß (cm)';

  @override
  String get horseFieldUeln => 'UELN / Lebensnummer';

  @override
  String get horseFieldChip => 'Chipnummer';

  @override
  String get horseFieldPassport => 'Equidenpass-Nummer';

  @override
  String get horseFieldSire => 'Vater';

  @override
  String get horseFieldDam => 'Mutter';

  @override
  String get horseFieldStable => 'Stall / Standort';

  @override
  String get horseFieldKeeping => 'Haltungsform';

  @override
  String get horseFieldKeepingHint =>
      'z. B. Offenstall, Box mit Paddock, Weide';

  @override
  String get horseFieldOwner => 'Besitzer';

  @override
  String get horseFieldInsurance => 'Versicherung';

  @override
  String get horseFieldIntolerances => 'Unverträglichkeiten';

  @override
  String get horseFieldMedicalHistory => 'Vorerkrankungen';

  @override
  String get horseFieldNotes => 'Notizen';

  @override
  String get horseSexStute => 'Stute';

  @override
  String get horseSexWallach => 'Wallach';

  @override
  String get horseSexHengst => 'Hengst';

  @override
  String horseHeightValue(int cm) {
    return '$cm cm';
  }

  @override
  String ageYears(int years) {
    String _temp0 = intl.Intl.pluralLogic(
      years,
      locale: localeName,
      other: '$years Jahre',
      one: '1 Jahr',
    );
    return '$_temp0';
  }

  @override
  String ageMonths(int months) {
    String _temp0 = intl.Intl.pluralLogic(
      months,
      locale: localeName,
      other: '$months Monate',
      one: '1 Monat',
      zero: 'unter 1 Monat',
    );
    return '$_temp0';
  }

  @override
  String ageBirthday(String age, String date) {
    return '$age (geb. $date)';
  }

  @override
  String get dateClear => 'Datum entfernen';

  @override
  String get datePick => 'Datum wählen';

  @override
  String get profileNoData =>
      'Noch keine weiteren Angaben. Tippe auf den Stift, um das Profil zu ergänzen.';

  @override
  String get photoAdd => 'Foto hinzufügen';

  @override
  String get photoFromGallery => 'Aus Galerie wählen';

  @override
  String get photoFromCamera => 'Mit Kamera aufnehmen';

  @override
  String get photoSetProfile => 'Als Profilbild';

  @override
  String get photoIsProfile => 'Profilbild';

  @override
  String get photoDeleteConfirm => 'Foto löschen?';

  @override
  String get photoDeleteConfirmText =>
      'Das Foto wird aus der App gelöscht. Das Original in deiner Galerie bleibt erhalten.';

  @override
  String get photoError => 'Foto konnte nicht übernommen werden.';

  @override
  String photoOf(String name) {
    return 'Foto von $name';
  }

  @override
  String get photosEmpty => 'Noch keine Fotos';

  @override
  String get weightAdd => 'Gewicht eintragen';

  @override
  String get weightKg => 'Gewicht (kg)';

  @override
  String weightValue(String kg) {
    return '$kg kg';
  }

  @override
  String get weightDate => 'Datum';

  @override
  String get weightNote => 'Notiz (optional)';

  @override
  String get weightEmpty => 'Noch kein Gewicht eingetragen';

  @override
  String weightLatest(String kg, String date) {
    return 'Zuletzt $kg kg am $date';
  }

  @override
  String weightChartLabel(String from, String to, String min, String max) {
    return 'Gewichtsverlauf von $from bis $to, zwischen $min und $max kg';
  }

  @override
  String weightShowAll(int count) {
    return 'Alle $count Einträge anzeigen';
  }

  @override
  String get weightDeleteConfirm => 'Gewichtseintrag löschen?';

  @override
  String get contactAdd => 'Kontakt hinzufügen';

  @override
  String get contactNew => 'Neuer Kontakt';

  @override
  String get contactEdit => 'Kontakt bearbeiten';

  @override
  String get contactExisting => 'Vorhandenen Kontakt zuordnen';

  @override
  String get contactName => 'Name';

  @override
  String get contactRole => 'Rolle';

  @override
  String get contactPhone => 'Telefon';

  @override
  String get contactEmail => 'E-Mail';

  @override
  String get contactNotes => 'Notiz';

  @override
  String get contactSharedHint =>
      'Änderungen gelten für alle Pferde mit diesem Kontakt.';

  @override
  String contactCall(String name) {
    return '$name anrufen';
  }

  @override
  String get contactUnlink => 'Von diesem Pferd entfernen';

  @override
  String get contactsEmpty => 'Noch keine Kontakte';

  @override
  String get contactCallFailed => 'Telefon-App konnte nicht geöffnet werden.';

  @override
  String get contactRole_tierarzt => 'Tierarzt';

  @override
  String get contactRole_hufschmied => 'Hufschmied / Hufpfleger';

  @override
  String get contactRole_zahnarzt => 'Pferdezahnarzt';

  @override
  String get contactRole_physio => 'Osteopath / Physio';

  @override
  String get contactRole_sattler => 'Sattler';

  @override
  String get contactRole_trainer => 'Trainer';

  @override
  String get contactRole_stall => 'Stall';

  @override
  String get contactRole_besitzer => 'Besitzer';

  @override
  String get contactRole_notfall => 'Notfallkontakt';

  @override
  String get contactRole_sonstige => 'Sonstige';

  @override
  String get emptyPflegeNoHorse => 'Lege zuerst im Tab „Pferd“ ein Pferd an.';

  @override
  String get careViewCalendar => 'Kalender';

  @override
  String get careViewUpcoming => 'Anstehend';

  @override
  String get careViewHistory => 'Historie';

  @override
  String get careAdd => 'Eintrag hinzufügen';

  @override
  String get careNew => 'Neuer Eintrag';

  @override
  String get careEdit => 'Eintrag bearbeiten';

  @override
  String get careDayEmpty => 'Keine Einträge an diesem Tag';

  @override
  String get careUpcomingEmpty => 'Keine offenen Termine';

  @override
  String get careHistoryEmpty => 'Noch keine erledigten Einträge';

  @override
  String get careFilterAll => 'Alle Arten';

  @override
  String get careOverdue => 'Überfällig';

  @override
  String careOverdueSince(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days Tagen',
      one: '1 Tag',
    );
    return 'überfällig seit $_temp0';
  }

  @override
  String get careToday => 'heute';

  @override
  String get careTomorrow => 'morgen';

  @override
  String careInDays(int days) {
    return 'in $days Tagen';
  }

  @override
  String get careFormatMonth => 'Monat';

  @override
  String get careFormat2Weeks => '2 Wochen';

  @override
  String get careFormatWeek => 'Woche';

  @override
  String get careDone => 'Erledigt';

  @override
  String get carePlanned => 'Geplant';

  @override
  String get careMarkDone => 'Als erledigt markieren';

  @override
  String get careMarkOpen => 'Wieder öffnen';

  @override
  String get careDoneDateTitle => 'Wann wurde es erledigt?';

  @override
  String get careRecalcTitle => 'Folgetermin neu berechnen?';

  @override
  String careRecalcText(String old, String neu) {
    return 'Der Folgetermin steht auf dem $old. Ab dem tatsächlichen Datum gerechnet wäre er am $neu.';
  }

  @override
  String get careRecalcYes => 'Neu berechnen';

  @override
  String get careRecalcNo => 'Beibehalten';

  @override
  String careFollowUpCreated(String date) {
    return 'Folgetermin am $date angelegt';
  }

  @override
  String get careDeleteTitle => 'Eintrag löschen?';

  @override
  String get careDeleteText => 'Der Eintrag wird unwiderruflich gelöscht.';

  @override
  String careDeleteWithFollowUp(String date) {
    return 'Auch den offenen Folgetermin am $date löschen';
  }

  @override
  String get careFieldType => 'Art';

  @override
  String get careFieldDate => 'Datum';

  @override
  String get careFieldTime => 'Uhrzeit (optional)';

  @override
  String get careFieldTimeClear => 'Uhrzeit entfernen';

  @override
  String get careFieldTitle => 'Titel';

  @override
  String get careFieldPerson => 'Person';

  @override
  String get careFieldHufschmied => 'Hufschmied / Hufpfleger';

  @override
  String get careFieldTierarzt => 'Tierarzt';

  @override
  String get careFieldCost => 'Kosten in € (optional)';

  @override
  String get careFieldNotes => 'Notiz';

  @override
  String get careFieldHufArt => 'Bearbeitung';

  @override
  String get careFieldPraeparat => 'Präparat';

  @override
  String get careFieldWirkstoff => 'Wirkstoff';

  @override
  String get careFieldDosierung => 'Dosierung / Menge';

  @override
  String get careFieldLabor => 'Labor';

  @override
  String get careFieldEpg => 'Ergebnis EpG (Eier pro Gramm)';

  @override
  String get careFieldErgebnis => 'Ergebnis (Freitext)';

  @override
  String get careFieldImpfung => 'Impfung';

  @override
  String get careFieldImpfungName => 'Name der Impfung';

  @override
  String get careFieldImpfstoff => 'Impfstoff / Charge';

  @override
  String get careFieldGrundimmunisierung => 'Grundimmunisierung';

  @override
  String get careFieldDone => 'Bereits erledigt';

  @override
  String get careSectionRepeat => 'Nächster Termin';

  @override
  String get careRepeatNone => 'Keine Wiederholung';

  @override
  String get careRepeatAfter => 'Wiederholen nach';

  @override
  String get careRepeatValue => 'Anzahl';

  @override
  String careRepeatSuggestion(String interval) {
    return 'Vorschlag: $interval';
  }

  @override
  String careRepeatNextOn(String date) {
    return 'Folgetermin am $date';
  }

  @override
  String get careSectionReminders => 'Erinnerung';

  @override
  String get careReminderNone => 'Keine Erinnerung';

  @override
  String get careReminderOnDay => 'Am Tag';

  @override
  String careReminderDaysBefore(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days Tage vorher',
      one: '1 Tag vorher',
    );
    return '$_temp0';
  }

  @override
  String get careReminderPermissionDenied =>
      'Benachrichtigungen sind für die App ausgeschaltet. Erinnerungen werden gespeichert, aber erst angezeigt, wenn du sie in den Android-Einstellungen erlaubst.';

  @override
  String unitDays(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'Tage',
      one: 'Tag',
    );
    return '$_temp0';
  }

  @override
  String unitWeeks(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'Wochen',
      one: 'Woche',
    );
    return '$_temp0';
  }

  @override
  String unitMonths(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'Monate',
      one: 'Monat',
    );
    return '$_temp0';
  }

  @override
  String unitYears(int n) {
    String _temp0 = intl.Intl.pluralLogic(
      n,
      locale: localeName,
      other: 'Jahre',
      one: 'Jahr',
    );
    return '$_temp0';
  }

  @override
  String intervalText(int n, String unit) {
    return '$n $unit';
  }

  @override
  String get careHintHuf =>
      'Übliche Abstände: Beschlag 6–8 Wochen, Barhuf 4–8 Wochen.';

  @override
  String get careHintWurmkur =>
      'Kein fester Standard. Vorschlag: Kotprobe alle 3 Monate in der Weidesaison, mindestens 1 Entwurmung pro Jahr – Intervall frei wählbar.';

  @override
  String get careHintInfluenza =>
      'Influenza: 6 Monate (FN-Turnierpflicht), alternativ 12 Monate.';

  @override
  String get careHintTetanus => 'Tetanus: je nach Impfstoff 2–3 Jahre.';

  @override
  String get careDisclaimerShort =>
      'Nur ein Vorschlag – ersetzt keine Absprache mit Tierarzt, Hufschmied oder Trainer.';

  @override
  String get careVariant_barhuf => 'Barhuf';

  @override
  String get careVariant_beschlag => 'Beschlag';

  @override
  String get careVariant_kunststoff => 'Kunststoff';

  @override
  String get careVariant_orthopaedisch => 'Orthopädisch';

  @override
  String get careVariant_hufschuhe => 'Hufschuhe';

  @override
  String get careVariant_tetanus => 'Tetanus';

  @override
  String get careVariant_influenza => 'Influenza';

  @override
  String get careVariant_herpes => 'Herpes (EHV)';

  @override
  String get careVariant_tollwut => 'Tollwut';

  @override
  String get careVariant_westnil => 'West-Nil-Virus';

  @override
  String get careVariant_druse => 'Druse';

  @override
  String get careVariant_sonstige => 'Sonstige';

  @override
  String careEpgValue(int epg) {
    return '$epg EpG';
  }

  @override
  String careCostValue(String amount) {
    return '$amount €';
  }

  @override
  String careHistoryActiveIngredients(String list) {
    return 'Wirkstoffe zuletzt: $list';
  }

  @override
  String get notificationChannelName => 'Erinnerungen';

  @override
  String get notificationChannelDescription =>
      'Erinnerungen an Pflegetermine und Geburtstage';

  @override
  String notificationCareBody(String type, String horse, String when) {
    return '$type für $horse – $when';
  }

  @override
  String get notificationBirthdayTitle => 'Geburtstag 🎉';

  @override
  String notificationBirthdayBody(String horse, String when, int years) {
    String _temp0 = intl.Intl.pluralLogic(
      years,
      locale: localeName,
      other: '$years Jahre',
      one: '1 Jahr',
    );
    return '$horse wird $when $_temp0 alt.';
  }

  @override
  String get notificationTestTitle => 'Pferdekalender';

  @override
  String get notificationTestBody => 'So sehen Erinnerungen aus.';

  @override
  String get settingsReminders => 'Erinnerungen';

  @override
  String get settingsReminderTime => 'Uhrzeit der Erinnerungen';

  @override
  String get settingsReminderDefaults => 'Vorbelegung für neue Termine';

  @override
  String get settingsReminderExact => 'Pünktliche Erinnerungen';

  @override
  String get settingsReminderExactHint =>
      'Ohne diese Option kann Android Erinnerungen um einige Minuten verschieben, um Akku zu sparen.';

  @override
  String get settingsReminderExactDenied =>
      'Bitte in den Android-Einstellungen „Wecker & Erinnerungen“ für den Pferdekalender erlauben.';

  @override
  String get settingsReminderPermission => 'Benachrichtigungen erlaubt';

  @override
  String get settingsReminderPermissionOff =>
      'Benachrichtigungen sind ausgeschaltet – tippen zum Erlauben';

  @override
  String get settingsReminderTest => 'Test-Benachrichtigung senden';

  @override
  String get settingsCareTypes => 'Eintragsarten';

  @override
  String get settingsCareTypesHint =>
      'Namen, Farben und eigene Arten im Pflege-Kalender';

  @override
  String get settingsIntervals => 'Standard-Intervalle';

  @override
  String get settingsIntervalsHint => 'Vorschläge für „Wiederholen nach“';

  @override
  String get careTypeNew => 'Neue Art';

  @override
  String get careTypeEdit => 'Art bearbeiten';

  @override
  String get careTypeName => 'Name';

  @override
  String get careTypeColor => 'Farbe';

  @override
  String get careTypeIcon => 'Symbol';

  @override
  String get careTypeArchive => 'Ausblenden';

  @override
  String get careTypeUnarchive => 'Wieder einblenden';

  @override
  String get careTypeArchivedLabel => 'ausgeblendet';

  @override
  String get careTypeBuiltinHint =>
      'Eingebaute Art – Formular und Symbol sind fest.';

  @override
  String get intervalNone => 'Kein Vorschlag';

  @override
  String get intervalGeneral => 'Allgemein';

  @override
  String get horseFieldBirthdayReminder => 'Geburtstagserinnerung';

  @override
  String get calendarPrevious => 'Zurück';

  @override
  String get calendarNext => 'Weiter';

  @override
  String calendarEntries(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Einträge',
      one: '1 Eintrag',
    );
    return '$_temp0';
  }
}
