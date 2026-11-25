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
      'Trage Einheiten von Hand ein oder lass dir mit dem Plan-Generator einen Trainingsplan passend zu deinem Dienstplan erstellen.';

  @override
  String get emptyFutterTitle => 'Noch kein Futterplan';

  @override
  String get emptyFutterMessage =>
      'Lege einen Futterplan mit Mahlzeiten an. Änderungen speicherst du als neue Version – die alte bleibt in der Historie.';

  @override
  String get emptyDienstTitle => 'Noch keine Schichten';

  @override
  String get emptyDienstMessage =>
      'Lege deine Schichten an – Standard-Schichten mit einem Tipp oder eigene wie „Bereitschaft“ oder „Homeoffice“ – jeweils mit der Stallzeit, die dir an solchen Tagen für dein Pferd bleibt. Daraus plant später der Trainings-Generator.';

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

  @override
  String get shiftCreateDefaults => 'Standard-Schichten anlegen';

  @override
  String get shiftCreateDefaultsHint =>
      'Früh, Spät, Nacht, Frei, Urlaub – alles anpassbar';

  @override
  String get shiftTemplates => 'Meine Schichten';

  @override
  String get shiftTemplateNew => 'Eigene Schicht anlegen';

  @override
  String get shiftTemplateEdit => 'Schicht bearbeiten';

  @override
  String get shiftTemplateName => 'Name';

  @override
  String get shiftTemplateShort => 'Kürzel';

  @override
  String get shiftTemplateShortHint => '1–3 Zeichen, z. B. F';

  @override
  String get shiftTemplateStart => 'Beginn';

  @override
  String get shiftTemplateEnd => 'Ende';

  @override
  String get shiftTemplateNoTime => 'Ohne Uhrzeit';

  @override
  String get shiftTemplateStable => 'Stallzeit an diesem Tag';

  @override
  String get shiftTemplateStableHint =>
      'Wie viel Zeit bleibt dir an solchen Tagen für dein Pferd (inkl. Putzen)?';

  @override
  String get shiftTemplatePreferred => 'Bevorzugte Stallzeit';

  @override
  String get shiftTemplatePreferredNone => 'Egal';

  @override
  String get shiftTemplateNight => 'Nachtschicht';

  @override
  String get shiftTemplateNightHint =>
      'Der Tag danach wird im Trainingsplan geschont.';

  @override
  String get shiftTemplateRemoved => 'Schicht gelöscht';

  @override
  String get shiftTemplateArchived =>
      'Die Schicht wird noch verwendet und wurde daher nur ausgeblendet.';

  @override
  String shiftTemplateRemoveTitle(String name) {
    return '$name entfernen?';
  }

  @override
  String get shiftTemplateRemoveText =>
      'Wird die Schicht noch im Dienstplan verwendet, wird sie nur ausgeblendet; die Tage behalten ihre Schicht.';

  @override
  String get dayTime_morgens => 'Morgens';

  @override
  String get dayTime_nachmittags => 'Nachmittags';

  @override
  String get dayTime_abends => 'Abends';

  @override
  String minutesValue(int value) {
    return '$value min';
  }

  @override
  String get shiftQuickMode => 'Schnell eintragen';

  @override
  String get shiftQuickModeEnd => 'Fertig';

  @override
  String get shiftQuickHint => 'Schicht wählen, dann Tage antippen.';

  @override
  String get shiftQuickClear => 'Leeren';

  @override
  String get shiftNoShift => 'Keine Schicht';

  @override
  String get shiftDayEdit => 'Tag bearbeiten';

  @override
  String get shiftStableToday => 'Stallzeit';

  @override
  String get shiftOverride => 'Eigene Stallzeit für diesen Tag';

  @override
  String get shiftOverrideHint => 'z. B. heute nur 20 min';

  @override
  String get shiftOtherPerson => 'Beisteller/Reitbeteiligung übernimmt';

  @override
  String get shiftOtherPersonHint =>
      'An diesem Tag bewegt jemand anderes das Pferd.';

  @override
  String get shiftNote => 'Notiz';

  @override
  String shiftFromPattern(String name) {
    return 'aus Rhythmus „$name“';
  }

  @override
  String get shiftDayEmpty => 'Noch nichts eingetragen';

  @override
  String shiftWeekTotal(String duration) {
    return 'Diese Woche: $duration Stallzeit';
  }

  @override
  String shiftTimeRange(String start, String end) {
    return '$start–$end';
  }

  @override
  String get shiftPatterns => 'Rhythmen';

  @override
  String get shiftPatternNew => 'Neuer Rhythmus';

  @override
  String get shiftPatternName => 'Name';

  @override
  String get shiftPatternNameHint => 'z. B. Wechselschicht';

  @override
  String get shiftPatternSteps => 'Ablauf';

  @override
  String get shiftPatternStepsHint =>
      'Tippe die Schichten in der Reihenfolge an. Der Ablauf wiederholt sich.';

  @override
  String shiftPatternCycle(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days Tage',
      one: '1 Tag',
    );
    return 'Zyklus: $_temp0';
  }

  @override
  String get shiftPatternUndo => 'Letzten Schritt entfernen';

  @override
  String get shiftPatternStart => 'Startdatum';

  @override
  String shiftPatternWeeks(int weeks) {
    String _temp0 = intl.Intl.pluralLogic(
      weeks,
      locale: localeName,
      other: '$weeks Wochen',
      one: '1 Woche',
    );
    return 'Dauer: $_temp0';
  }

  @override
  String get shiftPatternOverwrite => 'Manuell geänderte Tage überschreiben';

  @override
  String get shiftPatternOverwriteHint =>
      'Sonst bleiben einzeln geänderte Tage erhalten.';

  @override
  String get shiftPatternPreview => 'Vorschau';

  @override
  String get shiftPatternApply => 'Ausrollen';

  @override
  String shiftPatternApplied(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Tage eingetragen',
      one: '1 Tag eingetragen',
    );
    return '$_temp0';
  }

  @override
  String shiftPatternSkipped(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count manuell geänderte Tage blieben erhalten',
      one: '1 manuell geänderter Tag blieb erhalten',
    );
    return '$_temp0';
  }

  @override
  String get shiftPatternEmpty => 'Noch keine Rhythmen';

  @override
  String shiftPatternRange(String from, String to) {
    return '$from – $to';
  }

  @override
  String get shiftPatternReapply => 'Erneut ausrollen';

  @override
  String get shiftPatternDelete => 'Rhythmus löschen';

  @override
  String get shiftPatternDeleteText =>
      'Sollen auch die vom Rhythmus eingetragenen Tage ab heute entfernt werden? Manuell geänderte Tage bleiben immer erhalten.';

  @override
  String get shiftPatternDeleteKeepDays => 'Nur Rhythmus löschen';

  @override
  String get shiftPatternDeleteWithDays => 'Mit Tagen ab heute';

  @override
  String get shiftNeedTemplates => 'Lege zuerst mindestens eine Schicht an.';

  @override
  String get shiftPatternDefaultName => 'Rhythmus';

  @override
  String get shiftCustomAdd => 'Eigene Schicht';

  @override
  String get shiftTemplatesHint =>
      'Lege beliebig viele eigene Schichten an, z. B. „Bereitschaft“, „Homeoffice“ oder „Kurzdienst“ – mit eigener Stallzeit. Sie stehen danach überall zur Auswahl.';

  @override
  String get trainingNoHorse => 'Lege zuerst im Tab „Pferd“ ein Pferd an.';

  @override
  String get trainingViewCalendar => 'Kalender';

  @override
  String get trainingViewWeek => 'Woche';

  @override
  String get trainingAddSession => 'Einheit hinzufügen';

  @override
  String get trainingGenerator => 'Plan-Generator';

  @override
  String get trainingNewSession => 'Neue Einheit';

  @override
  String get trainingEditSession => 'Einheit bearbeiten';

  @override
  String get trainingDayEmpty => 'Ruhetag – keine Einheit geplant';

  @override
  String trainingWeekLoad(String points) {
    return 'Wochenbelastung: $points Punkte';
  }

  @override
  String trainingLoadPoints(String points) {
    return '$points P.';
  }

  @override
  String trainingSessionMeta(int level, int minutes) {
    return 'Stufe $level · $minutes min';
  }

  @override
  String trainingLevel(int level) {
    return 'Stufe $level';
  }

  @override
  String get trainingLevel_0 => 'Ruhetag';

  @override
  String get trainingLevel_1 => 'Aktivpause';

  @override
  String get trainingLevel_2 => 'Leicht';

  @override
  String get trainingLevel_3 => 'Mittel';

  @override
  String get trainingLevel_4 => 'Kraft/Ausdauer';

  @override
  String get trainingLevel_5 => 'Hoch';

  @override
  String get trainingStatus_planned => 'Geplant';

  @override
  String get trainingStatus_done => 'Erledigt';

  @override
  String get trainingStatus_cancelled => 'Ausgefallen';

  @override
  String get trainingFieldTitle => 'Titel';

  @override
  String get trainingFieldDate => 'Datum';

  @override
  String get trainingFieldForm => 'Trainingsform';

  @override
  String get trainingFieldFormNone => 'Keine Angabe';

  @override
  String get trainingFieldLevel => 'Intensität (Belastungsstufe)';

  @override
  String get trainingFieldDuration => 'Dauer';

  @override
  String get trainingFieldWarmup => 'Aufwärmen';

  @override
  String get trainingFieldWork => 'Arbeitsphase / Übungen';

  @override
  String get trainingFieldCooldown => 'Abwärmen';

  @override
  String get trainingFieldLinesHint => 'Eine Zeile pro Punkt';

  @override
  String get trainingFieldStatus => 'Status';

  @override
  String get trainingFieldRating => 'Wie lief es?';

  @override
  String trainingFieldRatingValue(int rating) {
    return '$rating von 5';
  }

  @override
  String get trainingFieldNotes => 'Notiz';

  @override
  String get trainingPinned => 'Fixiert – bleibt beim Neu-Verteilen';

  @override
  String get trainingCopy => 'Kopieren';

  @override
  String get trainingCopyTo => 'Kopieren auf …';

  @override
  String trainingCopied(String date) {
    return 'Kopie am $date angelegt';
  }

  @override
  String get trainingDeleteTitle => 'Einheit löschen?';

  @override
  String get trainingDeleteText => 'Die Einheit wird unwiderruflich gelöscht.';

  @override
  String get trainingWhyHere => 'Warum an diesem Tag?';

  @override
  String trainingReasonMinutes(String shift, int minutes) {
    return '$shift$minutes min Stallzeit';
  }

  @override
  String trainingReasonAssumed(int minutes) {
    return 'Kein Dienstplan-Eintrag – $minutes min angenommen';
  }

  @override
  String trainingReasonSinceIntensive(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days Tagen',
      one: '1 Tag',
    );
    return 'letzte intensive Einheit vor $_temp0';
  }

  @override
  String get trainingReasonNoIntensive =>
      'keine intensive Einheit in den Tagen davor';

  @override
  String get trainingReasonIntensive =>
      'intensiv – deshalb auf einen Tag mit viel Zeit gelegt';

  @override
  String get trainingReasonActivePause => 'Aktivpause statt Ruhetag';

  @override
  String get trainingReasonAfterNight => 'Tag nach Nachtschicht – nur locker';

  @override
  String get trainingReasonRecovery =>
      'Tag nach einer Stufe-5-Einheit – bewusst leicht';

  @override
  String trainingReasonDowngraded(int from) {
    return 'Stufe $from war geplant, aber keine passende Einheit (Zeit/Formen) – daher leichter';
  }

  @override
  String get trainingReasonManual => 'Von Hand angelegt oder verschoben';

  @override
  String trainingPlanActive(String goal) {
    return 'Aktueller Plan: $goal';
  }

  @override
  String trainingPlanWeekOf(int week, int weeks, String end) {
    return 'Woche $week von $weeks · bis $end';
  }

  @override
  String get trainingPlanEnd => 'Plan beenden';

  @override
  String get trainingPlanEndTitle => 'Plan beenden?';

  @override
  String get trainingPlanEndText =>
      'Künftige offene Einheiten dieses Plans werden entfernt. Erledigte und fixierte Einheiten bleiben.';

  @override
  String get trainingShiftChanged =>
      'Dienstplan geändert – Plan ab heute neu verteilen?';

  @override
  String get trainingShiftChangedHint =>
      'Nur künftige, offene Einheiten werden neu verteilt. Erledigte und verschobene (fixierte) Einheiten bleiben.';

  @override
  String get trainingRedistribute => 'Neu verteilen';

  @override
  String get trainingRedistributed => 'Plan ab heute neu verteilt';

  @override
  String get trainingGoal_muskelaufbau => 'Muskelaufbau';

  @override
  String get trainingGoal_muskelerhalt => 'Muskelerhalt';

  @override
  String get trainingGoal_kondition => 'Kondition';

  @override
  String get trainingGoal_wiedereinstieg => 'Wiedereinstieg nach Pause';

  @override
  String get trainingGoalHint_muskelaufbau =>
      'Belastung steigt ca. 10 % pro Woche, jede 4. Woche Entlastung.';

  @override
  String get trainingGoalHint_muskelerhalt =>
      'Gleichbleibende Belastung, 3–4 Einheiten pro Woche.';

  @override
  String get trainingGoalHint_kondition =>
      'Mehr Gelände- und Intervalleinheiten, Intervalle werden länger.';

  @override
  String get trainingGoalHint_wiedereinstieg =>
      'Nur nach Freigabe durch den Tierarzt! Woche 1–2 nur Schritt, langsame Steigerung.';

  @override
  String get generatorTitle => 'Trainingsplan erstellen';

  @override
  String get generatorGoal => 'Ziel';

  @override
  String generatorFitness(int value) {
    return 'Aktueller Fitnessstand: $value von 5';
  }

  @override
  String get generatorFitnessLow => 'wenig trainiert';

  @override
  String get generatorFitnessHigh => 'sehr fit';

  @override
  String generatorDays(int days) {
    return 'Trainingstage pro Woche: $days';
  }

  @override
  String get generatorWeeks => 'Planlänge';

  @override
  String generatorWeeksValue(int weeks) {
    return '$weeks Wochen';
  }

  @override
  String get generatorStart => 'Startdatum';

  @override
  String get generatorForms => 'Verfügbare Trainingsformen';

  @override
  String get generatorFormsNone =>
      'Bitte mindestens eine Trainingsform wählen.';

  @override
  String get generatorExclusions => 'Ausschlüsse';

  @override
  String get generatorRestrictions => 'Einschränkungen (nur zur Info)';

  @override
  String get generatorRestrictionsHint =>
      'z. B. „Sehne links – nur gerade Linien“';

  @override
  String generatorShare(String horse, int percent) {
    return 'Anteil deiner Stallzeit für $horse: $percent %';
  }

  @override
  String get generatorShareHint =>
      'Bei mehreren Pferden teilt sich deine Stallzeit.';

  @override
  String generatorBuffer(int minutes) {
    return 'Puffer für Putzen/Satteln: $minutes min';
  }

  @override
  String generatorDefaultMinutes(int minutes) {
    return 'Tage ohne Dienstplan-Eintrag: $minutes min annehmen';
  }

  @override
  String get generatorPreview => 'Vorschau erstellen';

  @override
  String get generatorDisclaimerTitle => 'Bevor es losgeht';

  @override
  String get generatorDisclaimerOk => 'Verstanden';

  @override
  String get previewTitle => 'Vorschau';

  @override
  String get previewApply => 'Plan übernehmen';

  @override
  String get previewReplaceTitle => 'Aktuellen Plan ersetzen?';

  @override
  String get previewReplaceText =>
      'Der bisherige Plan wird beendet. Seine künftigen offenen Einheiten werden entfernt, erledigte und fixierte bleiben.';

  @override
  String get previewReplace => 'Ersetzen';

  @override
  String get previewSaved => 'Trainingsplan übernommen';

  @override
  String previewWeek(int week) {
    return 'Woche $week';
  }

  @override
  String get previewDeload => 'Entlastungswoche';

  @override
  String get previewLoadCurve => 'Belastungskurve';

  @override
  String previewLoadCurveLabel(String min, String max) {
    return 'Wochenbelastung von $min bis $max Punkten';
  }

  @override
  String get previewSwap => 'Andere Übung';

  @override
  String get previewNoAlternative => 'Keine andere passende Einheit';

  @override
  String get previewRemove => 'Entfernen';

  @override
  String get previewRest_rest => 'Ruhetag';

  @override
  String get previewRest_covered => 'Beisteller/Reitbeteiligung übernimmt';

  @override
  String get previewRest_afterNight => 'Ruhetag (nach Nachtschicht)';

  @override
  String get previewRest_noTime => 'Ruhetag (zu wenig Zeit)';

  @override
  String get previewRest_beforeStart => '–';

  @override
  String previewWarning(int week, int achieved, int requested) {
    return 'Woche $week: nur $achieved statt $requested Einheiten möglich';
  }

  @override
  String get previewWarningNight => 'wegen Nachtschichten';

  @override
  String get previewWarningTime => 'wegen zu wenig Stallzeit';

  @override
  String get previewWarningCovered => 'wegen Beisteller-Tagen';

  @override
  String previewWarningShorter(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days weiteren Tagen',
      one: '1 weiteren Tag',
    );
    return 'Tipp: Mit kürzeren Einheiten (ca. 15 min, z. B. Bodenarbeit) ginge an $_temp0 etwas.';
  }

  @override
  String get previewFormRepeat =>
      'Wenige Trainingsformen gewählt – manche Form kommt öfter als 2× pro Woche vor.';

  @override
  String get previewEmpty => 'In diesem Zeitraum ist keine Einheit möglich.';

  @override
  String get feedNoHorse => 'Lege zuerst im Tab „Pferd“ ein Pferd an.';

  @override
  String get feedCreatePlan => 'Futterplan anlegen';

  @override
  String get feedDefaultPlanName => 'Futterplan';

  @override
  String get feedDefaultMealMorning => 'Morgens';

  @override
  String get feedDefaultMealEvening => 'Abends';

  @override
  String feedPlanValidSince(String name, String date) {
    return '$name · gültig seit $date';
  }

  @override
  String feedNoPlanOnDay(String date) {
    return 'Für diesen Tag gilt noch kein Futterplan (erste Version ab $date).';
  }

  @override
  String get feedTrainingDay => 'Trainingstag';

  @override
  String get feedRestDay => 'Ruhetag';

  @override
  String get feedDayTotal => 'Tagessumme';

  @override
  String get feedDaily => 'Täglich (Zusätze)';

  @override
  String get feedAsDirected => 'laut Packungsangabe';

  @override
  String get feedTemporary => 'Zusatz';

  @override
  String get feedVariantOnlyTraining => 'nur an Trainingstagen';

  @override
  String get feedVariantOnlyRest => 'nur an Ruhetagen';

  @override
  String get feedVariant_always => 'Immer';

  @override
  String get feedVariant_training => 'Trainingstag';

  @override
  String get feedVariant_rest => 'Ruhetag';

  @override
  String get feedMealEmpty => 'Keine Futtermittel';

  @override
  String feedLowStock(String item) {
    return 'Vorrat wird knapp: $item';
  }

  @override
  String feedStockDays(String item, int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days Tage',
      one: '1 Tag',
      zero: 'weniger als 1 Tag',
    );
    return 'Vorrat $item: reicht noch ca. $_temp0';
  }

  @override
  String get feedEditPlan => 'Plan bearbeiten';

  @override
  String get feedItems => 'Futtermittel';

  @override
  String get feedVersions => 'Versionen';

  @override
  String get feedSupplements => 'Zeitlich begrenzte Zusätze';

  @override
  String get feedPreviousDay => 'Vorheriger Tag';

  @override
  String get feedNextDay => 'Nächster Tag';

  @override
  String get feedToday => 'Heute';

  @override
  String get feedItemNew => 'Neues Futtermittel';

  @override
  String get feedItemEdit => 'Futtermittel bearbeiten';

  @override
  String get feedItemName => 'Name';

  @override
  String get feedItemCategory => 'Kategorie';

  @override
  String get feedItemUnit => 'Einheit';

  @override
  String get feedItemNotes => 'Notiz';

  @override
  String get feedItemStock => 'Vorrat (optional)';

  @override
  String get feedItemThreshold => '„Vorrat wird knapp“ ab (optional)';

  @override
  String get feedItemsEmpty => 'Noch keine Futtermittel';

  @override
  String get feedItemRemoved => 'Futtermittel gelöscht';

  @override
  String get feedItemArchived =>
      'Wird noch verwendet und wurde daher nur ausgeblendet.';

  @override
  String feedItemRemoveTitle(String name) {
    return '$name entfernen?';
  }

  @override
  String get feedItemRemoveText =>
      'Wird das Futtermittel noch in Plänen verwendet, wird es nur ausgeblendet.';

  @override
  String get feedItemStockUpdate => 'Vorrat aktualisieren';

  @override
  String get feedCategory_raufutter => 'Raufutter';

  @override
  String get feedCategory_kraftfutter => 'Kraftfutter';

  @override
  String get feedCategory_mineralfutter => 'Mineralfutter';

  @override
  String get feedCategory_ergaenzung => 'Ergänzung';

  @override
  String get feedCategory_oel => 'Öl';

  @override
  String get feedCategory_leckerli => 'Leckerli';

  @override
  String get feedCategory_medikament => 'Medikament';

  @override
  String get feedUnit_kg => 'kg';

  @override
  String get feedUnit_g => 'g';

  @override
  String get feedUnit_ml => 'ml';

  @override
  String get feedUnit_messbecher => 'Messbecher';

  @override
  String get feedUnit_stueck => 'Stück';

  @override
  String get feedUnit_liter => 'Liter';

  @override
  String get feedPlanEditTitle => 'Futterplan bearbeiten';

  @override
  String get feedPlanName => 'Name der Version';

  @override
  String get feedPlanNameHint => 'z. B. Winter-Ration';

  @override
  String get feedPlanValidFrom => 'Gültig ab';

  @override
  String get feedPlanNotes => 'Notiz';

  @override
  String get feedMeals => 'Mahlzeiten';

  @override
  String get feedMealAdd => 'Mahlzeit hinzufügen';

  @override
  String get feedMealName => 'Mahlzeit';

  @override
  String get feedMealTime => 'Uhrzeit';

  @override
  String get feedMealRemove => 'Mahlzeit entfernen';

  @override
  String get feedEntryAdd => 'Futtermittel hinzufügen';

  @override
  String get feedEntryItem => 'Futtermittel';

  @override
  String get feedEntryAmount => 'Menge';

  @override
  String get feedEntryRemove => 'Position entfernen';

  @override
  String get feedNeedItems => 'Lege zuerst Futtermittel an.';

  @override
  String get feedVersionNew => 'Neue Version';

  @override
  String get feedVersionNewTitle => 'Neue Version ab wann?';

  @override
  String get feedVersionNewHint =>
      'Die aktuelle Version wird kopiert; du kannst sie danach anpassen. Die bisherige Version bleibt in der Historie.';

  @override
  String get feedVersionCurrent => 'aktuell';

  @override
  String feedVersionFuture(String date) {
    return 'ab $date';
  }

  @override
  String get feedVersionDeleteTitle => 'Version löschen?';

  @override
  String get feedVersionDeleteText =>
      'Diese Version des Futterplans wird unwiderruflich gelöscht.';

  @override
  String get feedSupplementNew => 'Zusatz hinzufügen';

  @override
  String get feedSupplementEdit => 'Zusatz bearbeiten';

  @override
  String get feedSupplementAmountAsDirected => 'Menge laut Packungsangabe';

  @override
  String get feedSupplementMeal => 'Zu welcher Mahlzeit?';

  @override
  String get feedSupplementMealDaily => 'einmal täglich';

  @override
  String get feedSupplementStart => 'Beginn';

  @override
  String get feedSupplementEnd => 'Ende';

  @override
  String get feedSupplementDuration => 'Dauer';

  @override
  String feedSupplementWeeks(int weeks) {
    return '$weeks Wochen';
  }

  @override
  String get feedSupplementNote => 'Notiz (z. B. Kur, Grund)';

  @override
  String get feedSupplementsEmpty => 'Keine Zusätze';

  @override
  String get feedSupplementActive => 'Aktiv';

  @override
  String get feedSupplementUpcoming => 'Geplant';

  @override
  String get feedSupplementPast => 'Abgelaufen';

  @override
  String feedSupplementRange(String from, String to) {
    return '$from – $to';
  }

  @override
  String get feedSupplementFromBlood => 'aus Blutbild-Auswertung';

  @override
  String get feedSupplementDeleteTitle => 'Zusatz löschen?';

  @override
  String get feedDisclaimer =>
      'Nur Dokumentation – keine Rationsberechnung. Mengen bitte mit Tierarzt oder Futterberatung abstimmen.';

  @override
  String get feedItemStockLabel => 'Vorrat';

  @override
  String get healthTitle => 'Gesundheit';

  @override
  String get healthNoTest => 'Noch kein Blutbild eingetragen';

  @override
  String healthAllInRange(String date) {
    return 'Blutbild vom $date: alles im Referenzbereich';
  }

  @override
  String healthSummary(String date, String summary) {
    return 'Blutbild vom $date: $summary';
  }

  @override
  String get healthAddTest => 'Blutbild eintragen';

  @override
  String get healthTests => 'Blutbilder';

  @override
  String get healthTestsEmptyHint =>
      'Trag nur die Werte ein, die auf dem Befund zu hoch oder zu niedrig sind – alle anderen gelten als im Referenzbereich.';

  @override
  String get bloodNew => 'Neues Blutbild';

  @override
  String get bloodEdit => 'Blutbild bearbeiten';

  @override
  String get bloodDate => 'Datum der Blutentnahme';

  @override
  String get bloodLab => 'Labor';

  @override
  String get bloodLabDefault => 'Laboklin';

  @override
  String get bloodNotes => 'Notiz';

  @override
  String get bloodSearch => 'Wert suchen (z. B. GGT, Selen, Hämoglobin)';

  @override
  String get bloodSearchClear => 'Suche leeren';

  @override
  String get bloodOnlyEntered => 'Nur eingetragene';

  @override
  String bloodEnteredCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Werte eingetragen',
      one: '1 Wert eingetragen',
      zero: 'Noch kein Wert eingetragen',
    );
    return '$_temp0';
  }

  @override
  String bloodRange(String range) {
    return 'Referenz $range';
  }

  @override
  String bloodRangeBetween(String low, String high) {
    return '$low–$high';
  }

  @override
  String bloodRangeBelow(String high) {
    return '< $high';
  }

  @override
  String bloodRangeAbove(String low) {
    return '> $low';
  }

  @override
  String get bloodNoMatch => 'Kein Wert gefunden';

  @override
  String get bloodValue => 'Wert';

  @override
  String get bloodOwnRange => 'Referenzbereich vom eigenen Befund (optional)';

  @override
  String get bloodOwnLow => 'untere Grenze';

  @override
  String get bloodOwnHigh => 'obere Grenze';

  @override
  String get bloodRemoveValue => 'Wert entfernen';

  @override
  String get bloodStatusHigh => 'zu hoch';

  @override
  String get bloodStatusLow => 'zu niedrig';

  @override
  String get bloodStatusStrongHigh => 'deutlich zu hoch';

  @override
  String get bloodStatusStrongLow => 'deutlich zu niedrig';

  @override
  String get bloodStatusOk => 'im Bereich';

  @override
  String get bloodDeleteTitle => 'Blutbild löschen?';

  @override
  String get bloodDeleteText =>
      'Das Blutbild und alle eingetragenen Werte werden gelöscht. Bereits übernommene Zusätze und Termine bleiben.';

  @override
  String get bloodEvaluation => 'Auswertung';

  @override
  String get bloodDeviations => 'Abweichende Werte';

  @override
  String get bloodNoDeviations =>
      'Alle Werte im Referenzbereich – nicht eingetragene Werte gelten als normal.';

  @override
  String get bloodVetFirst => 'Zuerst tierärztlich abklären';

  @override
  String get bloodSuggestions => 'Mögliche Bausteine';

  @override
  String get bloodSuggestionsHint =>
      'Auswahl übernehmen: Ergänzungen kommen als zeitlich begrenzte Zusätze in den Futterplan (Menge laut Packungsangabe), Termine in den Pflege-Kalender, Fütterungshinweise in die Notiz des Futterplans.';

  @override
  String get bloodKind_supplement => 'Futter-Zusatz';

  @override
  String get bloodKind_ration => 'Fütterung';

  @override
  String get bloodKind_management => 'Haltung';

  @override
  String get bloodKind_care => 'Termin';

  @override
  String bloodWeeks(int weeks) {
    return 'für $weeks Wochen';
  }

  @override
  String bloodControlIn(int weeks) {
    String _temp0 = intl.Intl.pluralLogic(
      weeks,
      locale: localeName,
      other: '$weeks Wochen',
      one: '1 Woche',
    );
    return 'in $_temp0';
  }

  @override
  String bloodInDays(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days Tagen',
      one: '1 Tag',
    );
    return 'in $_temp0';
  }

  @override
  String get bloodApply => 'In Futterplan übernehmen';

  @override
  String bloodApplied(int supplements, int events, int notes) {
    return '$supplements Zusätze, $events Termine, $notes Hinweise übernommen';
  }

  @override
  String get bloodApplyNothing => 'Bitte mindestens einen Baustein auswählen.';

  @override
  String bloodPlanNoteLine(String date, String title) {
    return 'Hinweis aus Blutbild vom $date: $title';
  }

  @override
  String get bloodSource => 'Quelle der Referenzwerte';
}
