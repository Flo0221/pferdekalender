import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('de')];

  /// No description provided for @appTitle.
  ///
  /// In de, this message translates to:
  /// **'Pferdekalender'**
  String get appTitle;

  /// No description provided for @tabPflege.
  ///
  /// In de, this message translates to:
  /// **'Pflege'**
  String get tabPflege;

  /// No description provided for @tabTraining.
  ///
  /// In de, this message translates to:
  /// **'Training'**
  String get tabTraining;

  /// No description provided for @tabFutter.
  ///
  /// In de, this message translates to:
  /// **'Futter'**
  String get tabFutter;

  /// No description provided for @tabDienst.
  ///
  /// In de, this message translates to:
  /// **'Dienst'**
  String get tabDienst;

  /// No description provided for @tabPferd.
  ///
  /// In de, this message translates to:
  /// **'Pferd'**
  String get tabPferd;

  /// No description provided for @titlePflege.
  ///
  /// In de, this message translates to:
  /// **'Pflege-Kalender'**
  String get titlePflege;

  /// No description provided for @titleTraining.
  ///
  /// In de, this message translates to:
  /// **'Training'**
  String get titleTraining;

  /// No description provided for @titleFutter.
  ///
  /// In de, this message translates to:
  /// **'Futterplan'**
  String get titleFutter;

  /// No description provided for @titleDienst.
  ///
  /// In de, this message translates to:
  /// **'Mein Dienstplan'**
  String get titleDienst;

  /// No description provided for @titlePferd.
  ///
  /// In de, this message translates to:
  /// **'Pferd'**
  String get titlePferd;

  /// No description provided for @titleSettings.
  ///
  /// In de, this message translates to:
  /// **'Einstellungen'**
  String get titleSettings;

  /// No description provided for @actionSettings.
  ///
  /// In de, this message translates to:
  /// **'Einstellungen öffnen'**
  String get actionSettings;

  /// No description provided for @emptyPflegeTitle.
  ///
  /// In de, this message translates to:
  /// **'Noch keine Pflegetermine'**
  String get emptyPflegeTitle;

  /// No description provided for @emptyPflegeMessage.
  ///
  /// In de, this message translates to:
  /// **'Lege Hufbearbeitung, Wurmkur, Impfung oder Tierarzttermine an. Mit Wiederholung plant die App den nächsten Termin automatisch.'**
  String get emptyPflegeMessage;

  /// No description provided for @emptyTrainingTitle.
  ///
  /// In de, this message translates to:
  /// **'Noch kein Training geplant'**
  String get emptyTrainingTitle;

  /// No description provided for @emptyTrainingMessage.
  ///
  /// In de, this message translates to:
  /// **'Hier erscheinen bald Trainingseinheiten und der Plan-Generator.'**
  String get emptyTrainingMessage;

  /// No description provided for @emptyFutterTitle.
  ///
  /// In de, this message translates to:
  /// **'Noch kein Futterplan'**
  String get emptyFutterTitle;

  /// No description provided for @emptyFutterMessage.
  ///
  /// In de, this message translates to:
  /// **'Hier erscheinen bald Futtermittel, Mahlzeiten und Rationen.'**
  String get emptyFutterMessage;

  /// No description provided for @emptyDienstTitle.
  ///
  /// In de, this message translates to:
  /// **'Noch keine Schichten'**
  String get emptyDienstTitle;

  /// No description provided for @emptyDienstMessage.
  ///
  /// In de, this message translates to:
  /// **'Lege deine Schichten an – Standard-Schichten mit einem Tipp oder eigene wie „Bereitschaft“ oder „Homeoffice“ – jeweils mit der Stallzeit, die dir an solchen Tagen für dein Pferd bleibt. Daraus plant später der Trainings-Generator.'**
  String get emptyDienstMessage;

  /// No description provided for @emptyPferdTitle.
  ///
  /// In de, this message translates to:
  /// **'Noch kein Pferd angelegt'**
  String get emptyPferdTitle;

  /// No description provided for @emptyPferdMessage.
  ///
  /// In de, this message translates to:
  /// **'Lege dein Pferd mit Profil, Fotos, Gewicht und Kontakten an. Alle Bereiche der App beziehen sich dann auf das ausgewählte Pferd.'**
  String get emptyPferdMessage;

  /// No description provided for @settingsAppearance.
  ///
  /// In de, this message translates to:
  /// **'Darstellung'**
  String get settingsAppearance;

  /// No description provided for @settingsThemeSystem.
  ///
  /// In de, this message translates to:
  /// **'Wie System'**
  String get settingsThemeSystem;

  /// No description provided for @settingsThemeLight.
  ///
  /// In de, this message translates to:
  /// **'Hell'**
  String get settingsThemeLight;

  /// No description provided for @settingsThemeDark.
  ///
  /// In de, this message translates to:
  /// **'Dunkel'**
  String get settingsThemeDark;

  /// No description provided for @settingsNoticeTitle.
  ///
  /// In de, this message translates to:
  /// **'Hinweis'**
  String get settingsNoticeTitle;

  /// No description provided for @disclaimer.
  ///
  /// In de, this message translates to:
  /// **'Intervalle und Trainingsvorschläge ersetzen keine Absprache mit Tierarzt, Hufschmied oder Trainer.'**
  String get disclaimer;

  /// No description provided for @settingsPrivacyTitle.
  ///
  /// In de, this message translates to:
  /// **'Datenschutz'**
  String get settingsPrivacyTitle;

  /// No description provided for @settingsPrivacyText.
  ///
  /// In de, this message translates to:
  /// **'Alle Daten bleiben auf diesem Gerät. Die App hat keinen Internetzugriff und nimmt nicht an der automatischen Android-Sicherung teil. Sichere deine Daten über den Export (folgt in einer späteren Version).'**
  String get settingsPrivacyText;

  /// No description provided for @settingsAbout.
  ///
  /// In de, this message translates to:
  /// **'Über die App'**
  String get settingsAbout;

  /// No description provided for @actionSave.
  ///
  /// In de, this message translates to:
  /// **'Speichern'**
  String get actionSave;

  /// No description provided for @actionCancel.
  ///
  /// In de, this message translates to:
  /// **'Abbrechen'**
  String get actionCancel;

  /// No description provided for @actionDelete.
  ///
  /// In de, this message translates to:
  /// **'Löschen'**
  String get actionDelete;

  /// No description provided for @actionEdit.
  ///
  /// In de, this message translates to:
  /// **'Bearbeiten'**
  String get actionEdit;

  /// No description provided for @actionAdd.
  ///
  /// In de, this message translates to:
  /// **'Hinzufügen'**
  String get actionAdd;

  /// No description provided for @actionClose.
  ///
  /// In de, this message translates to:
  /// **'Schließen'**
  String get actionClose;

  /// No description provided for @actionRemove.
  ///
  /// In de, this message translates to:
  /// **'Entfernen'**
  String get actionRemove;

  /// No description provided for @fieldRequired.
  ///
  /// In de, this message translates to:
  /// **'Bitte ausfüllen'**
  String get fieldRequired;

  /// No description provided for @fieldInvalidNumber.
  ///
  /// In de, this message translates to:
  /// **'Bitte eine gültige Zahl eingeben'**
  String get fieldInvalidNumber;

  /// No description provided for @notSet.
  ///
  /// In de, this message translates to:
  /// **'Nicht angegeben'**
  String get notSet;

  /// No description provided for @emptyPferdAction.
  ///
  /// In de, this message translates to:
  /// **'Erstes Pferd anlegen'**
  String get emptyPferdAction;

  /// No description provided for @horseSwitcherTooltip.
  ///
  /// In de, this message translates to:
  /// **'Pferd wechseln'**
  String get horseSwitcherTooltip;

  /// No description provided for @horseSwitcherManage.
  ///
  /// In de, this message translates to:
  /// **'Pferde verwalten'**
  String get horseSwitcherManage;

  /// No description provided for @horseListTitle.
  ///
  /// In de, this message translates to:
  /// **'Meine Pferde'**
  String get horseListTitle;

  /// No description provided for @horseListActive.
  ///
  /// In de, this message translates to:
  /// **'Aktiv'**
  String get horseListActive;

  /// No description provided for @horseListArchived.
  ///
  /// In de, this message translates to:
  /// **'Archiviert'**
  String get horseListArchived;

  /// No description provided for @horseListEmptyArchived.
  ///
  /// In de, this message translates to:
  /// **'Keine archivierten Pferde'**
  String get horseListEmptyArchived;

  /// No description provided for @horseAdd.
  ///
  /// In de, this message translates to:
  /// **'Pferd anlegen'**
  String get horseAdd;

  /// No description provided for @horseNew.
  ///
  /// In de, this message translates to:
  /// **'Neues Pferd'**
  String get horseNew;

  /// No description provided for @horseEditTitle.
  ///
  /// In de, this message translates to:
  /// **'Pferd bearbeiten'**
  String get horseEditTitle;

  /// No description provided for @horseArchive.
  ///
  /// In de, this message translates to:
  /// **'Archivieren'**
  String get horseArchive;

  /// No description provided for @horseUnarchive.
  ///
  /// In de, this message translates to:
  /// **'Wiederherstellen'**
  String get horseUnarchive;

  /// No description provided for @horseArchiveConfirmTitle.
  ///
  /// In de, this message translates to:
  /// **'{name} archivieren?'**
  String horseArchiveConfirmTitle(String name);

  /// No description provided for @horseArchiveConfirmText.
  ///
  /// In de, this message translates to:
  /// **'Das Pferd wird ausgeblendet. Alle Daten bleiben erhalten und du kannst es jederzeit wiederherstellen.'**
  String get horseArchiveConfirmText;

  /// No description provided for @horseDeleteForever.
  ///
  /// In de, this message translates to:
  /// **'Endgültig löschen'**
  String get horseDeleteForever;

  /// No description provided for @horseDeleteConfirmTitle.
  ///
  /// In de, this message translates to:
  /// **'{name} endgültig löschen?'**
  String horseDeleteConfirmTitle(String name);

  /// No description provided for @horseDeleteConfirmText.
  ///
  /// In de, this message translates to:
  /// **'Alle Daten dieses Pferdes (Fotos, Gewichte, Kontakt-Zuordnungen und später auch Termine, Trainings- und Futterpläne) werden unwiderruflich gelöscht. Das kann nicht rückgängig gemacht werden.'**
  String get horseDeleteConfirmText;

  /// No description provided for @horseDeleteConfirmContinue.
  ///
  /// In de, this message translates to:
  /// **'Weiter'**
  String get horseDeleteConfirmContinue;

  /// No description provided for @horseDeleteTypeName.
  ///
  /// In de, this message translates to:
  /// **'Zur Bestätigung den Namen „{name}“ eingeben'**
  String horseDeleteTypeName(String name);

  /// No description provided for @horseDeleted.
  ///
  /// In de, this message translates to:
  /// **'{name} wurde gelöscht'**
  String horseDeleted(String name);

  /// No description provided for @horseArchived.
  ///
  /// In de, this message translates to:
  /// **'{name} wurde archiviert'**
  String horseArchived(String name);

  /// No description provided for @horseSectionGeneral.
  ///
  /// In de, this message translates to:
  /// **'Allgemein'**
  String get horseSectionGeneral;

  /// No description provided for @horseSectionIdentification.
  ///
  /// In de, this message translates to:
  /// **'Identifikation'**
  String get horseSectionIdentification;

  /// No description provided for @horseSectionPedigree.
  ///
  /// In de, this message translates to:
  /// **'Abstammung'**
  String get horseSectionPedigree;

  /// No description provided for @horseSectionKeeping.
  ///
  /// In de, this message translates to:
  /// **'Haltung & Besitz'**
  String get horseSectionKeeping;

  /// No description provided for @horseSectionHealth.
  ///
  /// In de, this message translates to:
  /// **'Gesundheit'**
  String get horseSectionHealth;

  /// No description provided for @horseSectionNotes.
  ///
  /// In de, this message translates to:
  /// **'Notizen'**
  String get horseSectionNotes;

  /// No description provided for @horseSectionContacts.
  ///
  /// In de, this message translates to:
  /// **'Kontakte'**
  String get horseSectionContacts;

  /// No description provided for @horseSectionWeight.
  ///
  /// In de, this message translates to:
  /// **'Gewicht'**
  String get horseSectionWeight;

  /// No description provided for @horseSectionPhotos.
  ///
  /// In de, this message translates to:
  /// **'Fotos'**
  String get horseSectionPhotos;

  /// No description provided for @horseFieldName.
  ///
  /// In de, this message translates to:
  /// **'Name'**
  String get horseFieldName;

  /// No description provided for @horseFieldCallName.
  ///
  /// In de, this message translates to:
  /// **'Rufname'**
  String get horseFieldCallName;

  /// No description provided for @horseFieldBirthDate.
  ///
  /// In de, this message translates to:
  /// **'Geburtstag'**
  String get horseFieldBirthDate;

  /// No description provided for @horseFieldSex.
  ///
  /// In de, this message translates to:
  /// **'Geschlecht'**
  String get horseFieldSex;

  /// No description provided for @horseFieldBreed.
  ///
  /// In de, this message translates to:
  /// **'Rasse'**
  String get horseFieldBreed;

  /// No description provided for @horseFieldColor.
  ///
  /// In de, this message translates to:
  /// **'Farbe / Abzeichen'**
  String get horseFieldColor;

  /// No description provided for @horseFieldHeight.
  ///
  /// In de, this message translates to:
  /// **'Stockmaß (cm)'**
  String get horseFieldHeight;

  /// No description provided for @horseFieldUeln.
  ///
  /// In de, this message translates to:
  /// **'UELN / Lebensnummer'**
  String get horseFieldUeln;

  /// No description provided for @horseFieldChip.
  ///
  /// In de, this message translates to:
  /// **'Chipnummer'**
  String get horseFieldChip;

  /// No description provided for @horseFieldPassport.
  ///
  /// In de, this message translates to:
  /// **'Equidenpass-Nummer'**
  String get horseFieldPassport;

  /// No description provided for @horseFieldSire.
  ///
  /// In de, this message translates to:
  /// **'Vater'**
  String get horseFieldSire;

  /// No description provided for @horseFieldDam.
  ///
  /// In de, this message translates to:
  /// **'Mutter'**
  String get horseFieldDam;

  /// No description provided for @horseFieldStable.
  ///
  /// In de, this message translates to:
  /// **'Stall / Standort'**
  String get horseFieldStable;

  /// No description provided for @horseFieldKeeping.
  ///
  /// In de, this message translates to:
  /// **'Haltungsform'**
  String get horseFieldKeeping;

  /// No description provided for @horseFieldKeepingHint.
  ///
  /// In de, this message translates to:
  /// **'z. B. Offenstall, Box mit Paddock, Weide'**
  String get horseFieldKeepingHint;

  /// No description provided for @horseFieldOwner.
  ///
  /// In de, this message translates to:
  /// **'Besitzer'**
  String get horseFieldOwner;

  /// No description provided for @horseFieldInsurance.
  ///
  /// In de, this message translates to:
  /// **'Versicherung'**
  String get horseFieldInsurance;

  /// No description provided for @horseFieldIntolerances.
  ///
  /// In de, this message translates to:
  /// **'Unverträglichkeiten'**
  String get horseFieldIntolerances;

  /// No description provided for @horseFieldMedicalHistory.
  ///
  /// In de, this message translates to:
  /// **'Vorerkrankungen'**
  String get horseFieldMedicalHistory;

  /// No description provided for @horseFieldNotes.
  ///
  /// In de, this message translates to:
  /// **'Notizen'**
  String get horseFieldNotes;

  /// No description provided for @horseSexStute.
  ///
  /// In de, this message translates to:
  /// **'Stute'**
  String get horseSexStute;

  /// No description provided for @horseSexWallach.
  ///
  /// In de, this message translates to:
  /// **'Wallach'**
  String get horseSexWallach;

  /// No description provided for @horseSexHengst.
  ///
  /// In de, this message translates to:
  /// **'Hengst'**
  String get horseSexHengst;

  /// No description provided for @horseHeightValue.
  ///
  /// In de, this message translates to:
  /// **'{cm} cm'**
  String horseHeightValue(int cm);

  /// No description provided for @ageYears.
  ///
  /// In de, this message translates to:
  /// **'{years, plural, =1{1 Jahr} other{{years} Jahre}}'**
  String ageYears(int years);

  /// No description provided for @ageMonths.
  ///
  /// In de, this message translates to:
  /// **'{months, plural, =0{unter 1 Monat} =1{1 Monat} other{{months} Monate}}'**
  String ageMonths(int months);

  /// No description provided for @ageBirthday.
  ///
  /// In de, this message translates to:
  /// **'{age} (geb. {date})'**
  String ageBirthday(String age, String date);

  /// No description provided for @dateClear.
  ///
  /// In de, this message translates to:
  /// **'Datum entfernen'**
  String get dateClear;

  /// No description provided for @datePick.
  ///
  /// In de, this message translates to:
  /// **'Datum wählen'**
  String get datePick;

  /// No description provided for @profileNoData.
  ///
  /// In de, this message translates to:
  /// **'Noch keine weiteren Angaben. Tippe auf den Stift, um das Profil zu ergänzen.'**
  String get profileNoData;

  /// No description provided for @photoAdd.
  ///
  /// In de, this message translates to:
  /// **'Foto hinzufügen'**
  String get photoAdd;

  /// No description provided for @photoFromGallery.
  ///
  /// In de, this message translates to:
  /// **'Aus Galerie wählen'**
  String get photoFromGallery;

  /// No description provided for @photoFromCamera.
  ///
  /// In de, this message translates to:
  /// **'Mit Kamera aufnehmen'**
  String get photoFromCamera;

  /// No description provided for @photoSetProfile.
  ///
  /// In de, this message translates to:
  /// **'Als Profilbild'**
  String get photoSetProfile;

  /// No description provided for @photoIsProfile.
  ///
  /// In de, this message translates to:
  /// **'Profilbild'**
  String get photoIsProfile;

  /// No description provided for @photoDeleteConfirm.
  ///
  /// In de, this message translates to:
  /// **'Foto löschen?'**
  String get photoDeleteConfirm;

  /// No description provided for @photoDeleteConfirmText.
  ///
  /// In de, this message translates to:
  /// **'Das Foto wird aus der App gelöscht. Das Original in deiner Galerie bleibt erhalten.'**
  String get photoDeleteConfirmText;

  /// No description provided for @photoError.
  ///
  /// In de, this message translates to:
  /// **'Foto konnte nicht übernommen werden.'**
  String get photoError;

  /// No description provided for @photoOf.
  ///
  /// In de, this message translates to:
  /// **'Foto von {name}'**
  String photoOf(String name);

  /// No description provided for @photosEmpty.
  ///
  /// In de, this message translates to:
  /// **'Noch keine Fotos'**
  String get photosEmpty;

  /// No description provided for @weightAdd.
  ///
  /// In de, this message translates to:
  /// **'Gewicht eintragen'**
  String get weightAdd;

  /// No description provided for @weightKg.
  ///
  /// In de, this message translates to:
  /// **'Gewicht (kg)'**
  String get weightKg;

  /// No description provided for @weightValue.
  ///
  /// In de, this message translates to:
  /// **'{kg} kg'**
  String weightValue(String kg);

  /// No description provided for @weightDate.
  ///
  /// In de, this message translates to:
  /// **'Datum'**
  String get weightDate;

  /// No description provided for @weightNote.
  ///
  /// In de, this message translates to:
  /// **'Notiz (optional)'**
  String get weightNote;

  /// No description provided for @weightEmpty.
  ///
  /// In de, this message translates to:
  /// **'Noch kein Gewicht eingetragen'**
  String get weightEmpty;

  /// No description provided for @weightLatest.
  ///
  /// In de, this message translates to:
  /// **'Zuletzt {kg} kg am {date}'**
  String weightLatest(String kg, String date);

  /// No description provided for @weightChartLabel.
  ///
  /// In de, this message translates to:
  /// **'Gewichtsverlauf von {from} bis {to}, zwischen {min} und {max} kg'**
  String weightChartLabel(String from, String to, String min, String max);

  /// No description provided for @weightShowAll.
  ///
  /// In de, this message translates to:
  /// **'Alle {count} Einträge anzeigen'**
  String weightShowAll(int count);

  /// No description provided for @weightDeleteConfirm.
  ///
  /// In de, this message translates to:
  /// **'Gewichtseintrag löschen?'**
  String get weightDeleteConfirm;

  /// No description provided for @contactAdd.
  ///
  /// In de, this message translates to:
  /// **'Kontakt hinzufügen'**
  String get contactAdd;

  /// No description provided for @contactNew.
  ///
  /// In de, this message translates to:
  /// **'Neuer Kontakt'**
  String get contactNew;

  /// No description provided for @contactEdit.
  ///
  /// In de, this message translates to:
  /// **'Kontakt bearbeiten'**
  String get contactEdit;

  /// No description provided for @contactExisting.
  ///
  /// In de, this message translates to:
  /// **'Vorhandenen Kontakt zuordnen'**
  String get contactExisting;

  /// No description provided for @contactName.
  ///
  /// In de, this message translates to:
  /// **'Name'**
  String get contactName;

  /// No description provided for @contactRole.
  ///
  /// In de, this message translates to:
  /// **'Rolle'**
  String get contactRole;

  /// No description provided for @contactPhone.
  ///
  /// In de, this message translates to:
  /// **'Telefon'**
  String get contactPhone;

  /// No description provided for @contactEmail.
  ///
  /// In de, this message translates to:
  /// **'E-Mail'**
  String get contactEmail;

  /// No description provided for @contactNotes.
  ///
  /// In de, this message translates to:
  /// **'Notiz'**
  String get contactNotes;

  /// No description provided for @contactSharedHint.
  ///
  /// In de, this message translates to:
  /// **'Änderungen gelten für alle Pferde mit diesem Kontakt.'**
  String get contactSharedHint;

  /// No description provided for @contactCall.
  ///
  /// In de, this message translates to:
  /// **'{name} anrufen'**
  String contactCall(String name);

  /// No description provided for @contactUnlink.
  ///
  /// In de, this message translates to:
  /// **'Von diesem Pferd entfernen'**
  String get contactUnlink;

  /// No description provided for @contactsEmpty.
  ///
  /// In de, this message translates to:
  /// **'Noch keine Kontakte'**
  String get contactsEmpty;

  /// No description provided for @contactCallFailed.
  ///
  /// In de, this message translates to:
  /// **'Telefon-App konnte nicht geöffnet werden.'**
  String get contactCallFailed;

  /// No description provided for @contactRole_tierarzt.
  ///
  /// In de, this message translates to:
  /// **'Tierarzt'**
  String get contactRole_tierarzt;

  /// No description provided for @contactRole_hufschmied.
  ///
  /// In de, this message translates to:
  /// **'Hufschmied / Hufpfleger'**
  String get contactRole_hufschmied;

  /// No description provided for @contactRole_zahnarzt.
  ///
  /// In de, this message translates to:
  /// **'Pferdezahnarzt'**
  String get contactRole_zahnarzt;

  /// No description provided for @contactRole_physio.
  ///
  /// In de, this message translates to:
  /// **'Osteopath / Physio'**
  String get contactRole_physio;

  /// No description provided for @contactRole_sattler.
  ///
  /// In de, this message translates to:
  /// **'Sattler'**
  String get contactRole_sattler;

  /// No description provided for @contactRole_trainer.
  ///
  /// In de, this message translates to:
  /// **'Trainer'**
  String get contactRole_trainer;

  /// No description provided for @contactRole_stall.
  ///
  /// In de, this message translates to:
  /// **'Stall'**
  String get contactRole_stall;

  /// No description provided for @contactRole_besitzer.
  ///
  /// In de, this message translates to:
  /// **'Besitzer'**
  String get contactRole_besitzer;

  /// No description provided for @contactRole_notfall.
  ///
  /// In de, this message translates to:
  /// **'Notfallkontakt'**
  String get contactRole_notfall;

  /// No description provided for @contactRole_sonstige.
  ///
  /// In de, this message translates to:
  /// **'Sonstige'**
  String get contactRole_sonstige;

  /// No description provided for @emptyPflegeNoHorse.
  ///
  /// In de, this message translates to:
  /// **'Lege zuerst im Tab „Pferd“ ein Pferd an.'**
  String get emptyPflegeNoHorse;

  /// No description provided for @careViewCalendar.
  ///
  /// In de, this message translates to:
  /// **'Kalender'**
  String get careViewCalendar;

  /// No description provided for @careViewUpcoming.
  ///
  /// In de, this message translates to:
  /// **'Anstehend'**
  String get careViewUpcoming;

  /// No description provided for @careViewHistory.
  ///
  /// In de, this message translates to:
  /// **'Historie'**
  String get careViewHistory;

  /// No description provided for @careAdd.
  ///
  /// In de, this message translates to:
  /// **'Eintrag hinzufügen'**
  String get careAdd;

  /// No description provided for @careNew.
  ///
  /// In de, this message translates to:
  /// **'Neuer Eintrag'**
  String get careNew;

  /// No description provided for @careEdit.
  ///
  /// In de, this message translates to:
  /// **'Eintrag bearbeiten'**
  String get careEdit;

  /// No description provided for @careDayEmpty.
  ///
  /// In de, this message translates to:
  /// **'Keine Einträge an diesem Tag'**
  String get careDayEmpty;

  /// No description provided for @careUpcomingEmpty.
  ///
  /// In de, this message translates to:
  /// **'Keine offenen Termine'**
  String get careUpcomingEmpty;

  /// No description provided for @careHistoryEmpty.
  ///
  /// In de, this message translates to:
  /// **'Noch keine erledigten Einträge'**
  String get careHistoryEmpty;

  /// No description provided for @careFilterAll.
  ///
  /// In de, this message translates to:
  /// **'Alle Arten'**
  String get careFilterAll;

  /// No description provided for @careOverdue.
  ///
  /// In de, this message translates to:
  /// **'Überfällig'**
  String get careOverdue;

  /// No description provided for @careOverdueSince.
  ///
  /// In de, this message translates to:
  /// **'überfällig seit {days, plural, =1{1 Tag} other{{days} Tagen}}'**
  String careOverdueSince(int days);

  /// No description provided for @careToday.
  ///
  /// In de, this message translates to:
  /// **'heute'**
  String get careToday;

  /// No description provided for @careTomorrow.
  ///
  /// In de, this message translates to:
  /// **'morgen'**
  String get careTomorrow;

  /// No description provided for @careInDays.
  ///
  /// In de, this message translates to:
  /// **'in {days} Tagen'**
  String careInDays(int days);

  /// No description provided for @careFormatMonth.
  ///
  /// In de, this message translates to:
  /// **'Monat'**
  String get careFormatMonth;

  /// No description provided for @careFormat2Weeks.
  ///
  /// In de, this message translates to:
  /// **'2 Wochen'**
  String get careFormat2Weeks;

  /// No description provided for @careFormatWeek.
  ///
  /// In de, this message translates to:
  /// **'Woche'**
  String get careFormatWeek;

  /// No description provided for @careDone.
  ///
  /// In de, this message translates to:
  /// **'Erledigt'**
  String get careDone;

  /// No description provided for @carePlanned.
  ///
  /// In de, this message translates to:
  /// **'Geplant'**
  String get carePlanned;

  /// No description provided for @careMarkDone.
  ///
  /// In de, this message translates to:
  /// **'Als erledigt markieren'**
  String get careMarkDone;

  /// No description provided for @careMarkOpen.
  ///
  /// In de, this message translates to:
  /// **'Wieder öffnen'**
  String get careMarkOpen;

  /// No description provided for @careDoneDateTitle.
  ///
  /// In de, this message translates to:
  /// **'Wann wurde es erledigt?'**
  String get careDoneDateTitle;

  /// No description provided for @careRecalcTitle.
  ///
  /// In de, this message translates to:
  /// **'Folgetermin neu berechnen?'**
  String get careRecalcTitle;

  /// No description provided for @careRecalcText.
  ///
  /// In de, this message translates to:
  /// **'Der Folgetermin steht auf dem {old}. Ab dem tatsächlichen Datum gerechnet wäre er am {neu}.'**
  String careRecalcText(String old, String neu);

  /// No description provided for @careRecalcYes.
  ///
  /// In de, this message translates to:
  /// **'Neu berechnen'**
  String get careRecalcYes;

  /// No description provided for @careRecalcNo.
  ///
  /// In de, this message translates to:
  /// **'Beibehalten'**
  String get careRecalcNo;

  /// No description provided for @careFollowUpCreated.
  ///
  /// In de, this message translates to:
  /// **'Folgetermin am {date} angelegt'**
  String careFollowUpCreated(String date);

  /// No description provided for @careDeleteTitle.
  ///
  /// In de, this message translates to:
  /// **'Eintrag löschen?'**
  String get careDeleteTitle;

  /// No description provided for @careDeleteText.
  ///
  /// In de, this message translates to:
  /// **'Der Eintrag wird unwiderruflich gelöscht.'**
  String get careDeleteText;

  /// No description provided for @careDeleteWithFollowUp.
  ///
  /// In de, this message translates to:
  /// **'Auch den offenen Folgetermin am {date} löschen'**
  String careDeleteWithFollowUp(String date);

  /// No description provided for @careFieldType.
  ///
  /// In de, this message translates to:
  /// **'Art'**
  String get careFieldType;

  /// No description provided for @careFieldDate.
  ///
  /// In de, this message translates to:
  /// **'Datum'**
  String get careFieldDate;

  /// No description provided for @careFieldTime.
  ///
  /// In de, this message translates to:
  /// **'Uhrzeit (optional)'**
  String get careFieldTime;

  /// No description provided for @careFieldTimeClear.
  ///
  /// In de, this message translates to:
  /// **'Uhrzeit entfernen'**
  String get careFieldTimeClear;

  /// No description provided for @careFieldTitle.
  ///
  /// In de, this message translates to:
  /// **'Titel'**
  String get careFieldTitle;

  /// No description provided for @careFieldPerson.
  ///
  /// In de, this message translates to:
  /// **'Person'**
  String get careFieldPerson;

  /// No description provided for @careFieldHufschmied.
  ///
  /// In de, this message translates to:
  /// **'Hufschmied / Hufpfleger'**
  String get careFieldHufschmied;

  /// No description provided for @careFieldTierarzt.
  ///
  /// In de, this message translates to:
  /// **'Tierarzt'**
  String get careFieldTierarzt;

  /// No description provided for @careFieldCost.
  ///
  /// In de, this message translates to:
  /// **'Kosten in € (optional)'**
  String get careFieldCost;

  /// No description provided for @careFieldNotes.
  ///
  /// In de, this message translates to:
  /// **'Notiz'**
  String get careFieldNotes;

  /// No description provided for @careFieldHufArt.
  ///
  /// In de, this message translates to:
  /// **'Bearbeitung'**
  String get careFieldHufArt;

  /// No description provided for @careFieldPraeparat.
  ///
  /// In de, this message translates to:
  /// **'Präparat'**
  String get careFieldPraeparat;

  /// No description provided for @careFieldWirkstoff.
  ///
  /// In de, this message translates to:
  /// **'Wirkstoff'**
  String get careFieldWirkstoff;

  /// No description provided for @careFieldDosierung.
  ///
  /// In de, this message translates to:
  /// **'Dosierung / Menge'**
  String get careFieldDosierung;

  /// No description provided for @careFieldLabor.
  ///
  /// In de, this message translates to:
  /// **'Labor'**
  String get careFieldLabor;

  /// No description provided for @careFieldEpg.
  ///
  /// In de, this message translates to:
  /// **'Ergebnis EpG (Eier pro Gramm)'**
  String get careFieldEpg;

  /// No description provided for @careFieldErgebnis.
  ///
  /// In de, this message translates to:
  /// **'Ergebnis (Freitext)'**
  String get careFieldErgebnis;

  /// No description provided for @careFieldImpfung.
  ///
  /// In de, this message translates to:
  /// **'Impfung'**
  String get careFieldImpfung;

  /// No description provided for @careFieldImpfungName.
  ///
  /// In de, this message translates to:
  /// **'Name der Impfung'**
  String get careFieldImpfungName;

  /// No description provided for @careFieldImpfstoff.
  ///
  /// In de, this message translates to:
  /// **'Impfstoff / Charge'**
  String get careFieldImpfstoff;

  /// No description provided for @careFieldGrundimmunisierung.
  ///
  /// In de, this message translates to:
  /// **'Grundimmunisierung'**
  String get careFieldGrundimmunisierung;

  /// No description provided for @careFieldDone.
  ///
  /// In de, this message translates to:
  /// **'Bereits erledigt'**
  String get careFieldDone;

  /// No description provided for @careSectionRepeat.
  ///
  /// In de, this message translates to:
  /// **'Nächster Termin'**
  String get careSectionRepeat;

  /// No description provided for @careRepeatNone.
  ///
  /// In de, this message translates to:
  /// **'Keine Wiederholung'**
  String get careRepeatNone;

  /// No description provided for @careRepeatAfter.
  ///
  /// In de, this message translates to:
  /// **'Wiederholen nach'**
  String get careRepeatAfter;

  /// No description provided for @careRepeatValue.
  ///
  /// In de, this message translates to:
  /// **'Anzahl'**
  String get careRepeatValue;

  /// No description provided for @careRepeatSuggestion.
  ///
  /// In de, this message translates to:
  /// **'Vorschlag: {interval}'**
  String careRepeatSuggestion(String interval);

  /// No description provided for @careRepeatNextOn.
  ///
  /// In de, this message translates to:
  /// **'Folgetermin am {date}'**
  String careRepeatNextOn(String date);

  /// No description provided for @careSectionReminders.
  ///
  /// In de, this message translates to:
  /// **'Erinnerung'**
  String get careSectionReminders;

  /// No description provided for @careReminderNone.
  ///
  /// In de, this message translates to:
  /// **'Keine Erinnerung'**
  String get careReminderNone;

  /// No description provided for @careReminderOnDay.
  ///
  /// In de, this message translates to:
  /// **'Am Tag'**
  String get careReminderOnDay;

  /// No description provided for @careReminderDaysBefore.
  ///
  /// In de, this message translates to:
  /// **'{days, plural, =1{1 Tag vorher} other{{days} Tage vorher}}'**
  String careReminderDaysBefore(int days);

  /// No description provided for @careReminderPermissionDenied.
  ///
  /// In de, this message translates to:
  /// **'Benachrichtigungen sind für die App ausgeschaltet. Erinnerungen werden gespeichert, aber erst angezeigt, wenn du sie in den Android-Einstellungen erlaubst.'**
  String get careReminderPermissionDenied;

  /// No description provided for @unitDays.
  ///
  /// In de, this message translates to:
  /// **'{n, plural, =1{Tag} other{Tage}}'**
  String unitDays(int n);

  /// No description provided for @unitWeeks.
  ///
  /// In de, this message translates to:
  /// **'{n, plural, =1{Woche} other{Wochen}}'**
  String unitWeeks(int n);

  /// No description provided for @unitMonths.
  ///
  /// In de, this message translates to:
  /// **'{n, plural, =1{Monat} other{Monate}}'**
  String unitMonths(int n);

  /// No description provided for @unitYears.
  ///
  /// In de, this message translates to:
  /// **'{n, plural, =1{Jahr} other{Jahre}}'**
  String unitYears(int n);

  /// No description provided for @intervalText.
  ///
  /// In de, this message translates to:
  /// **'{n} {unit}'**
  String intervalText(int n, String unit);

  /// No description provided for @careHintHuf.
  ///
  /// In de, this message translates to:
  /// **'Übliche Abstände: Beschlag 6–8 Wochen, Barhuf 4–8 Wochen.'**
  String get careHintHuf;

  /// No description provided for @careHintWurmkur.
  ///
  /// In de, this message translates to:
  /// **'Kein fester Standard. Vorschlag: Kotprobe alle 3 Monate in der Weidesaison, mindestens 1 Entwurmung pro Jahr – Intervall frei wählbar.'**
  String get careHintWurmkur;

  /// No description provided for @careHintInfluenza.
  ///
  /// In de, this message translates to:
  /// **'Influenza: 6 Monate (FN-Turnierpflicht), alternativ 12 Monate.'**
  String get careHintInfluenza;

  /// No description provided for @careHintTetanus.
  ///
  /// In de, this message translates to:
  /// **'Tetanus: je nach Impfstoff 2–3 Jahre.'**
  String get careHintTetanus;

  /// No description provided for @careDisclaimerShort.
  ///
  /// In de, this message translates to:
  /// **'Nur ein Vorschlag – ersetzt keine Absprache mit Tierarzt, Hufschmied oder Trainer.'**
  String get careDisclaimerShort;

  /// No description provided for @careVariant_barhuf.
  ///
  /// In de, this message translates to:
  /// **'Barhuf'**
  String get careVariant_barhuf;

  /// No description provided for @careVariant_beschlag.
  ///
  /// In de, this message translates to:
  /// **'Beschlag'**
  String get careVariant_beschlag;

  /// No description provided for @careVariant_kunststoff.
  ///
  /// In de, this message translates to:
  /// **'Kunststoff'**
  String get careVariant_kunststoff;

  /// No description provided for @careVariant_orthopaedisch.
  ///
  /// In de, this message translates to:
  /// **'Orthopädisch'**
  String get careVariant_orthopaedisch;

  /// No description provided for @careVariant_hufschuhe.
  ///
  /// In de, this message translates to:
  /// **'Hufschuhe'**
  String get careVariant_hufschuhe;

  /// No description provided for @careVariant_tetanus.
  ///
  /// In de, this message translates to:
  /// **'Tetanus'**
  String get careVariant_tetanus;

  /// No description provided for @careVariant_influenza.
  ///
  /// In de, this message translates to:
  /// **'Influenza'**
  String get careVariant_influenza;

  /// No description provided for @careVariant_herpes.
  ///
  /// In de, this message translates to:
  /// **'Herpes (EHV)'**
  String get careVariant_herpes;

  /// No description provided for @careVariant_tollwut.
  ///
  /// In de, this message translates to:
  /// **'Tollwut'**
  String get careVariant_tollwut;

  /// No description provided for @careVariant_westnil.
  ///
  /// In de, this message translates to:
  /// **'West-Nil-Virus'**
  String get careVariant_westnil;

  /// No description provided for @careVariant_druse.
  ///
  /// In de, this message translates to:
  /// **'Druse'**
  String get careVariant_druse;

  /// No description provided for @careVariant_sonstige.
  ///
  /// In de, this message translates to:
  /// **'Sonstige'**
  String get careVariant_sonstige;

  /// No description provided for @careEpgValue.
  ///
  /// In de, this message translates to:
  /// **'{epg} EpG'**
  String careEpgValue(int epg);

  /// No description provided for @careCostValue.
  ///
  /// In de, this message translates to:
  /// **'{amount} €'**
  String careCostValue(String amount);

  /// No description provided for @careHistoryActiveIngredients.
  ///
  /// In de, this message translates to:
  /// **'Wirkstoffe zuletzt: {list}'**
  String careHistoryActiveIngredients(String list);

  /// No description provided for @notificationChannelName.
  ///
  /// In de, this message translates to:
  /// **'Erinnerungen'**
  String get notificationChannelName;

  /// No description provided for @notificationChannelDescription.
  ///
  /// In de, this message translates to:
  /// **'Erinnerungen an Pflegetermine und Geburtstage'**
  String get notificationChannelDescription;

  /// No description provided for @notificationCareBody.
  ///
  /// In de, this message translates to:
  /// **'{type} für {horse} – {when}'**
  String notificationCareBody(String type, String horse, String when);

  /// No description provided for @notificationBirthdayTitle.
  ///
  /// In de, this message translates to:
  /// **'Geburtstag 🎉'**
  String get notificationBirthdayTitle;

  /// No description provided for @notificationBirthdayBody.
  ///
  /// In de, this message translates to:
  /// **'{horse} wird {when} {years, plural, =1{1 Jahr} other{{years} Jahre}} alt.'**
  String notificationBirthdayBody(String horse, String when, int years);

  /// No description provided for @notificationTestTitle.
  ///
  /// In de, this message translates to:
  /// **'Pferdekalender'**
  String get notificationTestTitle;

  /// No description provided for @notificationTestBody.
  ///
  /// In de, this message translates to:
  /// **'So sehen Erinnerungen aus.'**
  String get notificationTestBody;

  /// No description provided for @settingsReminders.
  ///
  /// In de, this message translates to:
  /// **'Erinnerungen'**
  String get settingsReminders;

  /// No description provided for @settingsReminderTime.
  ///
  /// In de, this message translates to:
  /// **'Uhrzeit der Erinnerungen'**
  String get settingsReminderTime;

  /// No description provided for @settingsReminderDefaults.
  ///
  /// In de, this message translates to:
  /// **'Vorbelegung für neue Termine'**
  String get settingsReminderDefaults;

  /// No description provided for @settingsReminderExact.
  ///
  /// In de, this message translates to:
  /// **'Pünktliche Erinnerungen'**
  String get settingsReminderExact;

  /// No description provided for @settingsReminderExactHint.
  ///
  /// In de, this message translates to:
  /// **'Ohne diese Option kann Android Erinnerungen um einige Minuten verschieben, um Akku zu sparen.'**
  String get settingsReminderExactHint;

  /// No description provided for @settingsReminderExactDenied.
  ///
  /// In de, this message translates to:
  /// **'Bitte in den Android-Einstellungen „Wecker & Erinnerungen“ für den Pferdekalender erlauben.'**
  String get settingsReminderExactDenied;

  /// No description provided for @settingsReminderPermission.
  ///
  /// In de, this message translates to:
  /// **'Benachrichtigungen erlaubt'**
  String get settingsReminderPermission;

  /// No description provided for @settingsReminderPermissionOff.
  ///
  /// In de, this message translates to:
  /// **'Benachrichtigungen sind ausgeschaltet – tippen zum Erlauben'**
  String get settingsReminderPermissionOff;

  /// No description provided for @settingsReminderTest.
  ///
  /// In de, this message translates to:
  /// **'Test-Benachrichtigung senden'**
  String get settingsReminderTest;

  /// No description provided for @settingsCareTypes.
  ///
  /// In de, this message translates to:
  /// **'Eintragsarten'**
  String get settingsCareTypes;

  /// No description provided for @settingsCareTypesHint.
  ///
  /// In de, this message translates to:
  /// **'Namen, Farben und eigene Arten im Pflege-Kalender'**
  String get settingsCareTypesHint;

  /// No description provided for @settingsIntervals.
  ///
  /// In de, this message translates to:
  /// **'Standard-Intervalle'**
  String get settingsIntervals;

  /// No description provided for @settingsIntervalsHint.
  ///
  /// In de, this message translates to:
  /// **'Vorschläge für „Wiederholen nach“'**
  String get settingsIntervalsHint;

  /// No description provided for @careTypeNew.
  ///
  /// In de, this message translates to:
  /// **'Neue Art'**
  String get careTypeNew;

  /// No description provided for @careTypeEdit.
  ///
  /// In de, this message translates to:
  /// **'Art bearbeiten'**
  String get careTypeEdit;

  /// No description provided for @careTypeName.
  ///
  /// In de, this message translates to:
  /// **'Name'**
  String get careTypeName;

  /// No description provided for @careTypeColor.
  ///
  /// In de, this message translates to:
  /// **'Farbe'**
  String get careTypeColor;

  /// No description provided for @careTypeIcon.
  ///
  /// In de, this message translates to:
  /// **'Symbol'**
  String get careTypeIcon;

  /// No description provided for @careTypeArchive.
  ///
  /// In de, this message translates to:
  /// **'Ausblenden'**
  String get careTypeArchive;

  /// No description provided for @careTypeUnarchive.
  ///
  /// In de, this message translates to:
  /// **'Wieder einblenden'**
  String get careTypeUnarchive;

  /// No description provided for @careTypeArchivedLabel.
  ///
  /// In de, this message translates to:
  /// **'ausgeblendet'**
  String get careTypeArchivedLabel;

  /// No description provided for @careTypeBuiltinHint.
  ///
  /// In de, this message translates to:
  /// **'Eingebaute Art – Formular und Symbol sind fest.'**
  String get careTypeBuiltinHint;

  /// No description provided for @intervalNone.
  ///
  /// In de, this message translates to:
  /// **'Kein Vorschlag'**
  String get intervalNone;

  /// No description provided for @intervalGeneral.
  ///
  /// In de, this message translates to:
  /// **'Allgemein'**
  String get intervalGeneral;

  /// No description provided for @horseFieldBirthdayReminder.
  ///
  /// In de, this message translates to:
  /// **'Geburtstagserinnerung'**
  String get horseFieldBirthdayReminder;

  /// No description provided for @calendarPrevious.
  ///
  /// In de, this message translates to:
  /// **'Zurück'**
  String get calendarPrevious;

  /// No description provided for @calendarNext.
  ///
  /// In de, this message translates to:
  /// **'Weiter'**
  String get calendarNext;

  /// No description provided for @calendarEntries.
  ///
  /// In de, this message translates to:
  /// **'{count, plural, =1{1 Eintrag} other{{count} Einträge}}'**
  String calendarEntries(int count);

  /// No description provided for @shiftCreateDefaults.
  ///
  /// In de, this message translates to:
  /// **'Standard-Schichten anlegen'**
  String get shiftCreateDefaults;

  /// No description provided for @shiftCreateDefaultsHint.
  ///
  /// In de, this message translates to:
  /// **'Früh, Spät, Nacht, Frei, Urlaub – alles anpassbar'**
  String get shiftCreateDefaultsHint;

  /// No description provided for @shiftTemplates.
  ///
  /// In de, this message translates to:
  /// **'Meine Schichten'**
  String get shiftTemplates;

  /// No description provided for @shiftTemplateNew.
  ///
  /// In de, this message translates to:
  /// **'Eigene Schicht anlegen'**
  String get shiftTemplateNew;

  /// No description provided for @shiftTemplateEdit.
  ///
  /// In de, this message translates to:
  /// **'Schicht bearbeiten'**
  String get shiftTemplateEdit;

  /// No description provided for @shiftTemplateName.
  ///
  /// In de, this message translates to:
  /// **'Name'**
  String get shiftTemplateName;

  /// No description provided for @shiftTemplateShort.
  ///
  /// In de, this message translates to:
  /// **'Kürzel'**
  String get shiftTemplateShort;

  /// No description provided for @shiftTemplateShortHint.
  ///
  /// In de, this message translates to:
  /// **'1–3 Zeichen, z. B. F'**
  String get shiftTemplateShortHint;

  /// No description provided for @shiftTemplateStart.
  ///
  /// In de, this message translates to:
  /// **'Beginn'**
  String get shiftTemplateStart;

  /// No description provided for @shiftTemplateEnd.
  ///
  /// In de, this message translates to:
  /// **'Ende'**
  String get shiftTemplateEnd;

  /// No description provided for @shiftTemplateNoTime.
  ///
  /// In de, this message translates to:
  /// **'Ohne Uhrzeit'**
  String get shiftTemplateNoTime;

  /// No description provided for @shiftTemplateStable.
  ///
  /// In de, this message translates to:
  /// **'Stallzeit an diesem Tag'**
  String get shiftTemplateStable;

  /// No description provided for @shiftTemplateStableHint.
  ///
  /// In de, this message translates to:
  /// **'Wie viel Zeit bleibt dir an solchen Tagen für dein Pferd (inkl. Putzen)?'**
  String get shiftTemplateStableHint;

  /// No description provided for @shiftTemplatePreferred.
  ///
  /// In de, this message translates to:
  /// **'Bevorzugte Stallzeit'**
  String get shiftTemplatePreferred;

  /// No description provided for @shiftTemplatePreferredNone.
  ///
  /// In de, this message translates to:
  /// **'Egal'**
  String get shiftTemplatePreferredNone;

  /// No description provided for @shiftTemplateNight.
  ///
  /// In de, this message translates to:
  /// **'Nachtschicht'**
  String get shiftTemplateNight;

  /// No description provided for @shiftTemplateNightHint.
  ///
  /// In de, this message translates to:
  /// **'Der Tag danach wird im Trainingsplan geschont.'**
  String get shiftTemplateNightHint;

  /// No description provided for @shiftTemplateRemoved.
  ///
  /// In de, this message translates to:
  /// **'Schicht gelöscht'**
  String get shiftTemplateRemoved;

  /// No description provided for @shiftTemplateArchived.
  ///
  /// In de, this message translates to:
  /// **'Die Schicht wird noch verwendet und wurde daher nur ausgeblendet.'**
  String get shiftTemplateArchived;

  /// No description provided for @shiftTemplateRemoveTitle.
  ///
  /// In de, this message translates to:
  /// **'{name} entfernen?'**
  String shiftTemplateRemoveTitle(String name);

  /// No description provided for @shiftTemplateRemoveText.
  ///
  /// In de, this message translates to:
  /// **'Wird die Schicht noch im Dienstplan verwendet, wird sie nur ausgeblendet; die Tage behalten ihre Schicht.'**
  String get shiftTemplateRemoveText;

  /// No description provided for @dayTime_morgens.
  ///
  /// In de, this message translates to:
  /// **'Morgens'**
  String get dayTime_morgens;

  /// No description provided for @dayTime_nachmittags.
  ///
  /// In de, this message translates to:
  /// **'Nachmittags'**
  String get dayTime_nachmittags;

  /// No description provided for @dayTime_abends.
  ///
  /// In de, this message translates to:
  /// **'Abends'**
  String get dayTime_abends;

  /// No description provided for @minutesValue.
  ///
  /// In de, this message translates to:
  /// **'{value} min'**
  String minutesValue(int value);

  /// No description provided for @shiftQuickMode.
  ///
  /// In de, this message translates to:
  /// **'Schnell eintragen'**
  String get shiftQuickMode;

  /// No description provided for @shiftQuickModeEnd.
  ///
  /// In de, this message translates to:
  /// **'Fertig'**
  String get shiftQuickModeEnd;

  /// No description provided for @shiftQuickHint.
  ///
  /// In de, this message translates to:
  /// **'Schicht wählen, dann Tage antippen.'**
  String get shiftQuickHint;

  /// No description provided for @shiftQuickClear.
  ///
  /// In de, this message translates to:
  /// **'Leeren'**
  String get shiftQuickClear;

  /// No description provided for @shiftNoShift.
  ///
  /// In de, this message translates to:
  /// **'Keine Schicht'**
  String get shiftNoShift;

  /// No description provided for @shiftDayEdit.
  ///
  /// In de, this message translates to:
  /// **'Tag bearbeiten'**
  String get shiftDayEdit;

  /// No description provided for @shiftStableToday.
  ///
  /// In de, this message translates to:
  /// **'Stallzeit'**
  String get shiftStableToday;

  /// No description provided for @shiftOverride.
  ///
  /// In de, this message translates to:
  /// **'Eigene Stallzeit für diesen Tag'**
  String get shiftOverride;

  /// No description provided for @shiftOverrideHint.
  ///
  /// In de, this message translates to:
  /// **'z. B. heute nur 20 min'**
  String get shiftOverrideHint;

  /// No description provided for @shiftOtherPerson.
  ///
  /// In de, this message translates to:
  /// **'Beisteller/Reitbeteiligung übernimmt'**
  String get shiftOtherPerson;

  /// No description provided for @shiftOtherPersonHint.
  ///
  /// In de, this message translates to:
  /// **'An diesem Tag bewegt jemand anderes das Pferd.'**
  String get shiftOtherPersonHint;

  /// No description provided for @shiftNote.
  ///
  /// In de, this message translates to:
  /// **'Notiz'**
  String get shiftNote;

  /// No description provided for @shiftFromPattern.
  ///
  /// In de, this message translates to:
  /// **'aus Rhythmus „{name}“'**
  String shiftFromPattern(String name);

  /// No description provided for @shiftDayEmpty.
  ///
  /// In de, this message translates to:
  /// **'Noch nichts eingetragen'**
  String get shiftDayEmpty;

  /// No description provided for @shiftWeekTotal.
  ///
  /// In de, this message translates to:
  /// **'Diese Woche: {duration} Stallzeit'**
  String shiftWeekTotal(String duration);

  /// No description provided for @shiftTimeRange.
  ///
  /// In de, this message translates to:
  /// **'{start}–{end}'**
  String shiftTimeRange(String start, String end);

  /// No description provided for @shiftPatterns.
  ///
  /// In de, this message translates to:
  /// **'Rhythmen'**
  String get shiftPatterns;

  /// No description provided for @shiftPatternNew.
  ///
  /// In de, this message translates to:
  /// **'Neuer Rhythmus'**
  String get shiftPatternNew;

  /// No description provided for @shiftPatternName.
  ///
  /// In de, this message translates to:
  /// **'Name'**
  String get shiftPatternName;

  /// No description provided for @shiftPatternNameHint.
  ///
  /// In de, this message translates to:
  /// **'z. B. Wechselschicht'**
  String get shiftPatternNameHint;

  /// No description provided for @shiftPatternSteps.
  ///
  /// In de, this message translates to:
  /// **'Ablauf'**
  String get shiftPatternSteps;

  /// No description provided for @shiftPatternStepsHint.
  ///
  /// In de, this message translates to:
  /// **'Tippe die Schichten in der Reihenfolge an. Der Ablauf wiederholt sich.'**
  String get shiftPatternStepsHint;

  /// No description provided for @shiftPatternCycle.
  ///
  /// In de, this message translates to:
  /// **'Zyklus: {days, plural, =1{1 Tag} other{{days} Tage}}'**
  String shiftPatternCycle(int days);

  /// No description provided for @shiftPatternUndo.
  ///
  /// In de, this message translates to:
  /// **'Letzten Schritt entfernen'**
  String get shiftPatternUndo;

  /// No description provided for @shiftPatternStart.
  ///
  /// In de, this message translates to:
  /// **'Startdatum'**
  String get shiftPatternStart;

  /// No description provided for @shiftPatternWeeks.
  ///
  /// In de, this message translates to:
  /// **'Dauer: {weeks, plural, =1{1 Woche} other{{weeks} Wochen}}'**
  String shiftPatternWeeks(int weeks);

  /// No description provided for @shiftPatternOverwrite.
  ///
  /// In de, this message translates to:
  /// **'Manuell geänderte Tage überschreiben'**
  String get shiftPatternOverwrite;

  /// No description provided for @shiftPatternOverwriteHint.
  ///
  /// In de, this message translates to:
  /// **'Sonst bleiben einzeln geänderte Tage erhalten.'**
  String get shiftPatternOverwriteHint;

  /// No description provided for @shiftPatternPreview.
  ///
  /// In de, this message translates to:
  /// **'Vorschau'**
  String get shiftPatternPreview;

  /// No description provided for @shiftPatternApply.
  ///
  /// In de, this message translates to:
  /// **'Ausrollen'**
  String get shiftPatternApply;

  /// No description provided for @shiftPatternApplied.
  ///
  /// In de, this message translates to:
  /// **'{count, plural, =1{1 Tag eingetragen} other{{count} Tage eingetragen}}'**
  String shiftPatternApplied(int count);

  /// No description provided for @shiftPatternSkipped.
  ///
  /// In de, this message translates to:
  /// **'{count, plural, =1{1 manuell geänderter Tag blieb erhalten} other{{count} manuell geänderte Tage blieben erhalten}}'**
  String shiftPatternSkipped(int count);

  /// No description provided for @shiftPatternEmpty.
  ///
  /// In de, this message translates to:
  /// **'Noch keine Rhythmen'**
  String get shiftPatternEmpty;

  /// No description provided for @shiftPatternRange.
  ///
  /// In de, this message translates to:
  /// **'{from} – {to}'**
  String shiftPatternRange(String from, String to);

  /// No description provided for @shiftPatternReapply.
  ///
  /// In de, this message translates to:
  /// **'Erneut ausrollen'**
  String get shiftPatternReapply;

  /// No description provided for @shiftPatternDelete.
  ///
  /// In de, this message translates to:
  /// **'Rhythmus löschen'**
  String get shiftPatternDelete;

  /// No description provided for @shiftPatternDeleteText.
  ///
  /// In de, this message translates to:
  /// **'Sollen auch die vom Rhythmus eingetragenen Tage ab heute entfernt werden? Manuell geänderte Tage bleiben immer erhalten.'**
  String get shiftPatternDeleteText;

  /// No description provided for @shiftPatternDeleteKeepDays.
  ///
  /// In de, this message translates to:
  /// **'Nur Rhythmus löschen'**
  String get shiftPatternDeleteKeepDays;

  /// No description provided for @shiftPatternDeleteWithDays.
  ///
  /// In de, this message translates to:
  /// **'Mit Tagen ab heute'**
  String get shiftPatternDeleteWithDays;

  /// No description provided for @shiftNeedTemplates.
  ///
  /// In de, this message translates to:
  /// **'Lege zuerst mindestens eine Schicht an.'**
  String get shiftNeedTemplates;

  /// No description provided for @shiftPatternDefaultName.
  ///
  /// In de, this message translates to:
  /// **'Rhythmus'**
  String get shiftPatternDefaultName;

  /// No description provided for @shiftCustomAdd.
  ///
  /// In de, this message translates to:
  /// **'Eigene Schicht'**
  String get shiftCustomAdd;

  /// No description provided for @shiftTemplatesHint.
  ///
  /// In de, this message translates to:
  /// **'Lege beliebig viele eigene Schichten an, z. B. „Bereitschaft“, „Homeoffice“ oder „Kurzdienst“ – mit eigener Stallzeit. Sie stehen danach überall zur Auswahl.'**
  String get shiftTemplatesHint;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['de'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
