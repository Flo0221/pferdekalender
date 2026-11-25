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
  /// **'Trage Einheiten von Hand ein oder lass dir mit dem Plan-Generator einen Trainingsplan passend zu deinem Dienstplan erstellen.'**
  String get emptyTrainingMessage;

  /// No description provided for @emptyFutterTitle.
  ///
  /// In de, this message translates to:
  /// **'Noch kein Futterplan'**
  String get emptyFutterTitle;

  /// No description provided for @emptyFutterMessage.
  ///
  /// In de, this message translates to:
  /// **'Lege einen Futterplan mit Mahlzeiten an. Änderungen speicherst du als neue Version – die alte bleibt in der Historie.'**
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

  /// No description provided for @trainingNoHorse.
  ///
  /// In de, this message translates to:
  /// **'Lege zuerst im Tab „Pferd“ ein Pferd an.'**
  String get trainingNoHorse;

  /// No description provided for @trainingViewCalendar.
  ///
  /// In de, this message translates to:
  /// **'Kalender'**
  String get trainingViewCalendar;

  /// No description provided for @trainingViewWeek.
  ///
  /// In de, this message translates to:
  /// **'Woche'**
  String get trainingViewWeek;

  /// No description provided for @trainingAddSession.
  ///
  /// In de, this message translates to:
  /// **'Einheit hinzufügen'**
  String get trainingAddSession;

  /// No description provided for @trainingGenerator.
  ///
  /// In de, this message translates to:
  /// **'Plan-Generator'**
  String get trainingGenerator;

  /// No description provided for @trainingNewSession.
  ///
  /// In de, this message translates to:
  /// **'Neue Einheit'**
  String get trainingNewSession;

  /// No description provided for @trainingEditSession.
  ///
  /// In de, this message translates to:
  /// **'Einheit bearbeiten'**
  String get trainingEditSession;

  /// No description provided for @trainingDayEmpty.
  ///
  /// In de, this message translates to:
  /// **'Ruhetag – keine Einheit geplant'**
  String get trainingDayEmpty;

  /// No description provided for @trainingWeekLoad.
  ///
  /// In de, this message translates to:
  /// **'Wochenbelastung: {points} Punkte'**
  String trainingWeekLoad(String points);

  /// No description provided for @trainingLoadPoints.
  ///
  /// In de, this message translates to:
  /// **'{points} P.'**
  String trainingLoadPoints(String points);

  /// No description provided for @trainingSessionMeta.
  ///
  /// In de, this message translates to:
  /// **'Stufe {level} · {minutes} min'**
  String trainingSessionMeta(int level, int minutes);

  /// No description provided for @trainingLevel.
  ///
  /// In de, this message translates to:
  /// **'Stufe {level}'**
  String trainingLevel(int level);

  /// No description provided for @trainingLevel_0.
  ///
  /// In de, this message translates to:
  /// **'Ruhetag'**
  String get trainingLevel_0;

  /// No description provided for @trainingLevel_1.
  ///
  /// In de, this message translates to:
  /// **'Aktivpause'**
  String get trainingLevel_1;

  /// No description provided for @trainingLevel_2.
  ///
  /// In de, this message translates to:
  /// **'Leicht'**
  String get trainingLevel_2;

  /// No description provided for @trainingLevel_3.
  ///
  /// In de, this message translates to:
  /// **'Mittel'**
  String get trainingLevel_3;

  /// No description provided for @trainingLevel_4.
  ///
  /// In de, this message translates to:
  /// **'Kraft/Ausdauer'**
  String get trainingLevel_4;

  /// No description provided for @trainingLevel_5.
  ///
  /// In de, this message translates to:
  /// **'Hoch'**
  String get trainingLevel_5;

  /// No description provided for @trainingStatus_planned.
  ///
  /// In de, this message translates to:
  /// **'Geplant'**
  String get trainingStatus_planned;

  /// No description provided for @trainingStatus_done.
  ///
  /// In de, this message translates to:
  /// **'Erledigt'**
  String get trainingStatus_done;

  /// No description provided for @trainingStatus_cancelled.
  ///
  /// In de, this message translates to:
  /// **'Ausgefallen'**
  String get trainingStatus_cancelled;

  /// No description provided for @trainingFieldTitle.
  ///
  /// In de, this message translates to:
  /// **'Titel'**
  String get trainingFieldTitle;

  /// No description provided for @trainingFieldDate.
  ///
  /// In de, this message translates to:
  /// **'Datum'**
  String get trainingFieldDate;

  /// No description provided for @trainingFieldForm.
  ///
  /// In de, this message translates to:
  /// **'Trainingsform'**
  String get trainingFieldForm;

  /// No description provided for @trainingFieldFormNone.
  ///
  /// In de, this message translates to:
  /// **'Keine Angabe'**
  String get trainingFieldFormNone;

  /// No description provided for @trainingFieldLevel.
  ///
  /// In de, this message translates to:
  /// **'Intensität (Belastungsstufe)'**
  String get trainingFieldLevel;

  /// No description provided for @trainingFieldDuration.
  ///
  /// In de, this message translates to:
  /// **'Dauer'**
  String get trainingFieldDuration;

  /// No description provided for @trainingFieldWarmup.
  ///
  /// In de, this message translates to:
  /// **'Aufwärmen'**
  String get trainingFieldWarmup;

  /// No description provided for @trainingFieldWork.
  ///
  /// In de, this message translates to:
  /// **'Arbeitsphase / Übungen'**
  String get trainingFieldWork;

  /// No description provided for @trainingFieldCooldown.
  ///
  /// In de, this message translates to:
  /// **'Abwärmen'**
  String get trainingFieldCooldown;

  /// No description provided for @trainingFieldLinesHint.
  ///
  /// In de, this message translates to:
  /// **'Eine Zeile pro Punkt'**
  String get trainingFieldLinesHint;

  /// No description provided for @trainingFieldStatus.
  ///
  /// In de, this message translates to:
  /// **'Status'**
  String get trainingFieldStatus;

  /// No description provided for @trainingFieldRating.
  ///
  /// In de, this message translates to:
  /// **'Wie lief es?'**
  String get trainingFieldRating;

  /// No description provided for @trainingFieldRatingValue.
  ///
  /// In de, this message translates to:
  /// **'{rating} von 5'**
  String trainingFieldRatingValue(int rating);

  /// No description provided for @trainingFieldNotes.
  ///
  /// In de, this message translates to:
  /// **'Notiz'**
  String get trainingFieldNotes;

  /// No description provided for @trainingPinned.
  ///
  /// In de, this message translates to:
  /// **'Fixiert – bleibt beim Neu-Verteilen'**
  String get trainingPinned;

  /// No description provided for @trainingCopy.
  ///
  /// In de, this message translates to:
  /// **'Kopieren'**
  String get trainingCopy;

  /// No description provided for @trainingCopyTo.
  ///
  /// In de, this message translates to:
  /// **'Kopieren auf …'**
  String get trainingCopyTo;

  /// No description provided for @trainingCopied.
  ///
  /// In de, this message translates to:
  /// **'Kopie am {date} angelegt'**
  String trainingCopied(String date);

  /// No description provided for @trainingDeleteTitle.
  ///
  /// In de, this message translates to:
  /// **'Einheit löschen?'**
  String get trainingDeleteTitle;

  /// No description provided for @trainingDeleteText.
  ///
  /// In de, this message translates to:
  /// **'Die Einheit wird unwiderruflich gelöscht.'**
  String get trainingDeleteText;

  /// No description provided for @trainingWhyHere.
  ///
  /// In de, this message translates to:
  /// **'Warum an diesem Tag?'**
  String get trainingWhyHere;

  /// No description provided for @trainingReasonMinutes.
  ///
  /// In de, this message translates to:
  /// **'{shift}{minutes} min Stallzeit'**
  String trainingReasonMinutes(String shift, int minutes);

  /// No description provided for @trainingReasonAssumed.
  ///
  /// In de, this message translates to:
  /// **'Kein Dienstplan-Eintrag – {minutes} min angenommen'**
  String trainingReasonAssumed(int minutes);

  /// No description provided for @trainingReasonSinceIntensive.
  ///
  /// In de, this message translates to:
  /// **'letzte intensive Einheit vor {days, plural, =1{1 Tag} other{{days} Tagen}}'**
  String trainingReasonSinceIntensive(int days);

  /// No description provided for @trainingReasonNoIntensive.
  ///
  /// In de, this message translates to:
  /// **'keine intensive Einheit in den Tagen davor'**
  String get trainingReasonNoIntensive;

  /// No description provided for @trainingReasonIntensive.
  ///
  /// In de, this message translates to:
  /// **'intensiv – deshalb auf einen Tag mit viel Zeit gelegt'**
  String get trainingReasonIntensive;

  /// No description provided for @trainingReasonActivePause.
  ///
  /// In de, this message translates to:
  /// **'Aktivpause statt Ruhetag'**
  String get trainingReasonActivePause;

  /// No description provided for @trainingReasonAfterNight.
  ///
  /// In de, this message translates to:
  /// **'Tag nach Nachtschicht – nur locker'**
  String get trainingReasonAfterNight;

  /// No description provided for @trainingReasonRecovery.
  ///
  /// In de, this message translates to:
  /// **'Tag nach einer Stufe-5-Einheit – bewusst leicht'**
  String get trainingReasonRecovery;

  /// No description provided for @trainingReasonDowngraded.
  ///
  /// In de, this message translates to:
  /// **'Stufe {from} war geplant, aber keine passende Einheit (Zeit/Formen) – daher leichter'**
  String trainingReasonDowngraded(int from);

  /// No description provided for @trainingReasonManual.
  ///
  /// In de, this message translates to:
  /// **'Von Hand angelegt oder verschoben'**
  String get trainingReasonManual;

  /// No description provided for @trainingPlanActive.
  ///
  /// In de, this message translates to:
  /// **'Aktueller Plan: {goal}'**
  String trainingPlanActive(String goal);

  /// No description provided for @trainingPlanWeekOf.
  ///
  /// In de, this message translates to:
  /// **'Woche {week} von {weeks} · bis {end}'**
  String trainingPlanWeekOf(int week, int weeks, String end);

  /// No description provided for @trainingPlanEnd.
  ///
  /// In de, this message translates to:
  /// **'Plan beenden'**
  String get trainingPlanEnd;

  /// No description provided for @trainingPlanEndTitle.
  ///
  /// In de, this message translates to:
  /// **'Plan beenden?'**
  String get trainingPlanEndTitle;

  /// No description provided for @trainingPlanEndText.
  ///
  /// In de, this message translates to:
  /// **'Künftige offene Einheiten dieses Plans werden entfernt. Erledigte und fixierte Einheiten bleiben.'**
  String get trainingPlanEndText;

  /// No description provided for @trainingShiftChanged.
  ///
  /// In de, this message translates to:
  /// **'Dienstplan geändert – Plan ab heute neu verteilen?'**
  String get trainingShiftChanged;

  /// No description provided for @trainingShiftChangedHint.
  ///
  /// In de, this message translates to:
  /// **'Nur künftige, offene Einheiten werden neu verteilt. Erledigte und verschobene (fixierte) Einheiten bleiben.'**
  String get trainingShiftChangedHint;

  /// No description provided for @trainingRedistribute.
  ///
  /// In de, this message translates to:
  /// **'Neu verteilen'**
  String get trainingRedistribute;

  /// No description provided for @trainingRedistributed.
  ///
  /// In de, this message translates to:
  /// **'Plan ab heute neu verteilt'**
  String get trainingRedistributed;

  /// No description provided for @trainingGoal_muskelaufbau.
  ///
  /// In de, this message translates to:
  /// **'Muskelaufbau'**
  String get trainingGoal_muskelaufbau;

  /// No description provided for @trainingGoal_muskelerhalt.
  ///
  /// In de, this message translates to:
  /// **'Muskelerhalt'**
  String get trainingGoal_muskelerhalt;

  /// No description provided for @trainingGoal_kondition.
  ///
  /// In de, this message translates to:
  /// **'Kondition'**
  String get trainingGoal_kondition;

  /// No description provided for @trainingGoal_wiedereinstieg.
  ///
  /// In de, this message translates to:
  /// **'Wiedereinstieg nach Pause'**
  String get trainingGoal_wiedereinstieg;

  /// No description provided for @trainingGoalHint_muskelaufbau.
  ///
  /// In de, this message translates to:
  /// **'Belastung steigt ca. 10 % pro Woche, jede 4. Woche Entlastung.'**
  String get trainingGoalHint_muskelaufbau;

  /// No description provided for @trainingGoalHint_muskelerhalt.
  ///
  /// In de, this message translates to:
  /// **'Gleichbleibende Belastung, 3–4 Einheiten pro Woche.'**
  String get trainingGoalHint_muskelerhalt;

  /// No description provided for @trainingGoalHint_kondition.
  ///
  /// In de, this message translates to:
  /// **'Mehr Gelände- und Intervalleinheiten, Intervalle werden länger.'**
  String get trainingGoalHint_kondition;

  /// No description provided for @trainingGoalHint_wiedereinstieg.
  ///
  /// In de, this message translates to:
  /// **'Nur nach Freigabe durch den Tierarzt! Woche 1–2 nur Schritt, langsame Steigerung.'**
  String get trainingGoalHint_wiedereinstieg;

  /// No description provided for @generatorTitle.
  ///
  /// In de, this message translates to:
  /// **'Trainingsplan erstellen'**
  String get generatorTitle;

  /// No description provided for @generatorGoal.
  ///
  /// In de, this message translates to:
  /// **'Ziel'**
  String get generatorGoal;

  /// No description provided for @generatorFitness.
  ///
  /// In de, this message translates to:
  /// **'Aktueller Fitnessstand: {value} von 5'**
  String generatorFitness(int value);

  /// No description provided for @generatorFitnessLow.
  ///
  /// In de, this message translates to:
  /// **'wenig trainiert'**
  String get generatorFitnessLow;

  /// No description provided for @generatorFitnessHigh.
  ///
  /// In de, this message translates to:
  /// **'sehr fit'**
  String get generatorFitnessHigh;

  /// No description provided for @generatorDays.
  ///
  /// In de, this message translates to:
  /// **'Trainingstage pro Woche: {days}'**
  String generatorDays(int days);

  /// No description provided for @generatorWeeks.
  ///
  /// In de, this message translates to:
  /// **'Planlänge'**
  String get generatorWeeks;

  /// No description provided for @generatorWeeksValue.
  ///
  /// In de, this message translates to:
  /// **'{weeks} Wochen'**
  String generatorWeeksValue(int weeks);

  /// No description provided for @generatorStart.
  ///
  /// In de, this message translates to:
  /// **'Startdatum'**
  String get generatorStart;

  /// No description provided for @generatorForms.
  ///
  /// In de, this message translates to:
  /// **'Verfügbare Trainingsformen'**
  String get generatorForms;

  /// No description provided for @generatorFormsNone.
  ///
  /// In de, this message translates to:
  /// **'Bitte mindestens eine Trainingsform wählen.'**
  String get generatorFormsNone;

  /// No description provided for @generatorExclusions.
  ///
  /// In de, this message translates to:
  /// **'Ausschlüsse'**
  String get generatorExclusions;

  /// No description provided for @generatorRestrictions.
  ///
  /// In de, this message translates to:
  /// **'Einschränkungen (nur zur Info)'**
  String get generatorRestrictions;

  /// No description provided for @generatorRestrictionsHint.
  ///
  /// In de, this message translates to:
  /// **'z. B. „Sehne links – nur gerade Linien“'**
  String get generatorRestrictionsHint;

  /// No description provided for @generatorShare.
  ///
  /// In de, this message translates to:
  /// **'Anteil deiner Stallzeit für {horse}: {percent} %'**
  String generatorShare(String horse, int percent);

  /// No description provided for @generatorShareHint.
  ///
  /// In de, this message translates to:
  /// **'Bei mehreren Pferden teilt sich deine Stallzeit.'**
  String get generatorShareHint;

  /// No description provided for @generatorBuffer.
  ///
  /// In de, this message translates to:
  /// **'Puffer für Putzen/Satteln: {minutes} min'**
  String generatorBuffer(int minutes);

  /// No description provided for @generatorDefaultMinutes.
  ///
  /// In de, this message translates to:
  /// **'Tage ohne Dienstplan-Eintrag: {minutes} min annehmen'**
  String generatorDefaultMinutes(int minutes);

  /// No description provided for @generatorPreview.
  ///
  /// In de, this message translates to:
  /// **'Vorschau erstellen'**
  String get generatorPreview;

  /// No description provided for @generatorDisclaimerTitle.
  ///
  /// In de, this message translates to:
  /// **'Bevor es losgeht'**
  String get generatorDisclaimerTitle;

  /// No description provided for @generatorDisclaimerOk.
  ///
  /// In de, this message translates to:
  /// **'Verstanden'**
  String get generatorDisclaimerOk;

  /// No description provided for @previewTitle.
  ///
  /// In de, this message translates to:
  /// **'Vorschau'**
  String get previewTitle;

  /// No description provided for @previewApply.
  ///
  /// In de, this message translates to:
  /// **'Plan übernehmen'**
  String get previewApply;

  /// No description provided for @previewReplaceTitle.
  ///
  /// In de, this message translates to:
  /// **'Aktuellen Plan ersetzen?'**
  String get previewReplaceTitle;

  /// No description provided for @previewReplaceText.
  ///
  /// In de, this message translates to:
  /// **'Der bisherige Plan wird beendet. Seine künftigen offenen Einheiten werden entfernt, erledigte und fixierte bleiben.'**
  String get previewReplaceText;

  /// No description provided for @previewReplace.
  ///
  /// In de, this message translates to:
  /// **'Ersetzen'**
  String get previewReplace;

  /// No description provided for @previewSaved.
  ///
  /// In de, this message translates to:
  /// **'Trainingsplan übernommen'**
  String get previewSaved;

  /// No description provided for @previewWeek.
  ///
  /// In de, this message translates to:
  /// **'Woche {week}'**
  String previewWeek(int week);

  /// No description provided for @previewDeload.
  ///
  /// In de, this message translates to:
  /// **'Entlastungswoche'**
  String get previewDeload;

  /// No description provided for @previewLoadCurve.
  ///
  /// In de, this message translates to:
  /// **'Belastungskurve'**
  String get previewLoadCurve;

  /// No description provided for @previewLoadCurveLabel.
  ///
  /// In de, this message translates to:
  /// **'Wochenbelastung von {min} bis {max} Punkten'**
  String previewLoadCurveLabel(String min, String max);

  /// No description provided for @previewSwap.
  ///
  /// In de, this message translates to:
  /// **'Andere Übung'**
  String get previewSwap;

  /// No description provided for @previewNoAlternative.
  ///
  /// In de, this message translates to:
  /// **'Keine andere passende Einheit'**
  String get previewNoAlternative;

  /// No description provided for @previewRemove.
  ///
  /// In de, this message translates to:
  /// **'Entfernen'**
  String get previewRemove;

  /// No description provided for @previewRest_rest.
  ///
  /// In de, this message translates to:
  /// **'Ruhetag'**
  String get previewRest_rest;

  /// No description provided for @previewRest_covered.
  ///
  /// In de, this message translates to:
  /// **'Beisteller/Reitbeteiligung übernimmt'**
  String get previewRest_covered;

  /// No description provided for @previewRest_afterNight.
  ///
  /// In de, this message translates to:
  /// **'Ruhetag (nach Nachtschicht)'**
  String get previewRest_afterNight;

  /// No description provided for @previewRest_noTime.
  ///
  /// In de, this message translates to:
  /// **'Ruhetag (zu wenig Zeit)'**
  String get previewRest_noTime;

  /// No description provided for @previewRest_beforeStart.
  ///
  /// In de, this message translates to:
  /// **'–'**
  String get previewRest_beforeStart;

  /// No description provided for @previewWarning.
  ///
  /// In de, this message translates to:
  /// **'Woche {week}: nur {achieved} statt {requested} Einheiten möglich'**
  String previewWarning(int week, int achieved, int requested);

  /// No description provided for @previewWarningNight.
  ///
  /// In de, this message translates to:
  /// **'wegen Nachtschichten'**
  String get previewWarningNight;

  /// No description provided for @previewWarningTime.
  ///
  /// In de, this message translates to:
  /// **'wegen zu wenig Stallzeit'**
  String get previewWarningTime;

  /// No description provided for @previewWarningCovered.
  ///
  /// In de, this message translates to:
  /// **'wegen Beisteller-Tagen'**
  String get previewWarningCovered;

  /// No description provided for @previewWarningShorter.
  ///
  /// In de, this message translates to:
  /// **'Tipp: Mit kürzeren Einheiten (ca. 15 min, z. B. Bodenarbeit) ginge an {days, plural, =1{1 weiteren Tag} other{{days} weiteren Tagen}} etwas.'**
  String previewWarningShorter(int days);

  /// No description provided for @previewFormRepeat.
  ///
  /// In de, this message translates to:
  /// **'Wenige Trainingsformen gewählt – manche Form kommt öfter als 2× pro Woche vor.'**
  String get previewFormRepeat;

  /// No description provided for @previewEmpty.
  ///
  /// In de, this message translates to:
  /// **'In diesem Zeitraum ist keine Einheit möglich.'**
  String get previewEmpty;

  /// No description provided for @feedNoHorse.
  ///
  /// In de, this message translates to:
  /// **'Lege zuerst im Tab „Pferd“ ein Pferd an.'**
  String get feedNoHorse;

  /// No description provided for @feedCreatePlan.
  ///
  /// In de, this message translates to:
  /// **'Futterplan anlegen'**
  String get feedCreatePlan;

  /// No description provided for @feedDefaultPlanName.
  ///
  /// In de, this message translates to:
  /// **'Futterplan'**
  String get feedDefaultPlanName;

  /// No description provided for @feedDefaultMealMorning.
  ///
  /// In de, this message translates to:
  /// **'Morgens'**
  String get feedDefaultMealMorning;

  /// No description provided for @feedDefaultMealEvening.
  ///
  /// In de, this message translates to:
  /// **'Abends'**
  String get feedDefaultMealEvening;

  /// No description provided for @feedPlanValidSince.
  ///
  /// In de, this message translates to:
  /// **'{name} · gültig seit {date}'**
  String feedPlanValidSince(String name, String date);

  /// No description provided for @feedNoPlanOnDay.
  ///
  /// In de, this message translates to:
  /// **'Für diesen Tag gilt noch kein Futterplan (erste Version ab {date}).'**
  String feedNoPlanOnDay(String date);

  /// No description provided for @feedTrainingDay.
  ///
  /// In de, this message translates to:
  /// **'Trainingstag'**
  String get feedTrainingDay;

  /// No description provided for @feedRestDay.
  ///
  /// In de, this message translates to:
  /// **'Ruhetag'**
  String get feedRestDay;

  /// No description provided for @feedDayTotal.
  ///
  /// In de, this message translates to:
  /// **'Tagessumme'**
  String get feedDayTotal;

  /// No description provided for @feedDaily.
  ///
  /// In de, this message translates to:
  /// **'Täglich (Zusätze)'**
  String get feedDaily;

  /// No description provided for @feedAsDirected.
  ///
  /// In de, this message translates to:
  /// **'laut Packungsangabe'**
  String get feedAsDirected;

  /// No description provided for @feedTemporary.
  ///
  /// In de, this message translates to:
  /// **'Zusatz'**
  String get feedTemporary;

  /// No description provided for @feedVariantOnlyTraining.
  ///
  /// In de, this message translates to:
  /// **'nur an Trainingstagen'**
  String get feedVariantOnlyTraining;

  /// No description provided for @feedVariantOnlyRest.
  ///
  /// In de, this message translates to:
  /// **'nur an Ruhetagen'**
  String get feedVariantOnlyRest;

  /// No description provided for @feedVariant_always.
  ///
  /// In de, this message translates to:
  /// **'Immer'**
  String get feedVariant_always;

  /// No description provided for @feedVariant_training.
  ///
  /// In de, this message translates to:
  /// **'Trainingstag'**
  String get feedVariant_training;

  /// No description provided for @feedVariant_rest.
  ///
  /// In de, this message translates to:
  /// **'Ruhetag'**
  String get feedVariant_rest;

  /// No description provided for @feedMealEmpty.
  ///
  /// In de, this message translates to:
  /// **'Keine Futtermittel'**
  String get feedMealEmpty;

  /// No description provided for @feedLowStock.
  ///
  /// In de, this message translates to:
  /// **'Vorrat wird knapp: {item}'**
  String feedLowStock(String item);

  /// No description provided for @feedStockDays.
  ///
  /// In de, this message translates to:
  /// **'Vorrat {item}: reicht noch ca. {days, plural, =0{weniger als 1 Tag} =1{1 Tag} other{{days} Tage}}'**
  String feedStockDays(String item, int days);

  /// No description provided for @feedEditPlan.
  ///
  /// In de, this message translates to:
  /// **'Plan bearbeiten'**
  String get feedEditPlan;

  /// No description provided for @feedItems.
  ///
  /// In de, this message translates to:
  /// **'Futtermittel'**
  String get feedItems;

  /// No description provided for @feedVersions.
  ///
  /// In de, this message translates to:
  /// **'Versionen'**
  String get feedVersions;

  /// No description provided for @feedSupplements.
  ///
  /// In de, this message translates to:
  /// **'Zeitlich begrenzte Zusätze'**
  String get feedSupplements;

  /// No description provided for @feedPreviousDay.
  ///
  /// In de, this message translates to:
  /// **'Vorheriger Tag'**
  String get feedPreviousDay;

  /// No description provided for @feedNextDay.
  ///
  /// In de, this message translates to:
  /// **'Nächster Tag'**
  String get feedNextDay;

  /// No description provided for @feedToday.
  ///
  /// In de, this message translates to:
  /// **'Heute'**
  String get feedToday;

  /// No description provided for @feedItemNew.
  ///
  /// In de, this message translates to:
  /// **'Neues Futtermittel'**
  String get feedItemNew;

  /// No description provided for @feedItemEdit.
  ///
  /// In de, this message translates to:
  /// **'Futtermittel bearbeiten'**
  String get feedItemEdit;

  /// No description provided for @feedItemName.
  ///
  /// In de, this message translates to:
  /// **'Name'**
  String get feedItemName;

  /// No description provided for @feedItemCategory.
  ///
  /// In de, this message translates to:
  /// **'Kategorie'**
  String get feedItemCategory;

  /// No description provided for @feedItemUnit.
  ///
  /// In de, this message translates to:
  /// **'Einheit'**
  String get feedItemUnit;

  /// No description provided for @feedItemNotes.
  ///
  /// In de, this message translates to:
  /// **'Notiz'**
  String get feedItemNotes;

  /// No description provided for @feedItemStock.
  ///
  /// In de, this message translates to:
  /// **'Vorrat (optional)'**
  String get feedItemStock;

  /// No description provided for @feedItemThreshold.
  ///
  /// In de, this message translates to:
  /// **'„Vorrat wird knapp“ ab (optional)'**
  String get feedItemThreshold;

  /// No description provided for @feedItemsEmpty.
  ///
  /// In de, this message translates to:
  /// **'Noch keine Futtermittel'**
  String get feedItemsEmpty;

  /// No description provided for @feedItemRemoved.
  ///
  /// In de, this message translates to:
  /// **'Futtermittel gelöscht'**
  String get feedItemRemoved;

  /// No description provided for @feedItemArchived.
  ///
  /// In de, this message translates to:
  /// **'Wird noch verwendet und wurde daher nur ausgeblendet.'**
  String get feedItemArchived;

  /// No description provided for @feedItemRemoveTitle.
  ///
  /// In de, this message translates to:
  /// **'{name} entfernen?'**
  String feedItemRemoveTitle(String name);

  /// No description provided for @feedItemRemoveText.
  ///
  /// In de, this message translates to:
  /// **'Wird das Futtermittel noch in Plänen verwendet, wird es nur ausgeblendet.'**
  String get feedItemRemoveText;

  /// No description provided for @feedItemStockUpdate.
  ///
  /// In de, this message translates to:
  /// **'Vorrat aktualisieren'**
  String get feedItemStockUpdate;

  /// No description provided for @feedCategory_raufutter.
  ///
  /// In de, this message translates to:
  /// **'Raufutter'**
  String get feedCategory_raufutter;

  /// No description provided for @feedCategory_kraftfutter.
  ///
  /// In de, this message translates to:
  /// **'Kraftfutter'**
  String get feedCategory_kraftfutter;

  /// No description provided for @feedCategory_mineralfutter.
  ///
  /// In de, this message translates to:
  /// **'Mineralfutter'**
  String get feedCategory_mineralfutter;

  /// No description provided for @feedCategory_ergaenzung.
  ///
  /// In de, this message translates to:
  /// **'Ergänzung'**
  String get feedCategory_ergaenzung;

  /// No description provided for @feedCategory_oel.
  ///
  /// In de, this message translates to:
  /// **'Öl'**
  String get feedCategory_oel;

  /// No description provided for @feedCategory_leckerli.
  ///
  /// In de, this message translates to:
  /// **'Leckerli'**
  String get feedCategory_leckerli;

  /// No description provided for @feedCategory_medikament.
  ///
  /// In de, this message translates to:
  /// **'Medikament'**
  String get feedCategory_medikament;

  /// No description provided for @feedUnit_kg.
  ///
  /// In de, this message translates to:
  /// **'kg'**
  String get feedUnit_kg;

  /// No description provided for @feedUnit_g.
  ///
  /// In de, this message translates to:
  /// **'g'**
  String get feedUnit_g;

  /// No description provided for @feedUnit_ml.
  ///
  /// In de, this message translates to:
  /// **'ml'**
  String get feedUnit_ml;

  /// No description provided for @feedUnit_messbecher.
  ///
  /// In de, this message translates to:
  /// **'Messbecher'**
  String get feedUnit_messbecher;

  /// No description provided for @feedUnit_stueck.
  ///
  /// In de, this message translates to:
  /// **'Stück'**
  String get feedUnit_stueck;

  /// No description provided for @feedUnit_liter.
  ///
  /// In de, this message translates to:
  /// **'Liter'**
  String get feedUnit_liter;

  /// No description provided for @feedPlanEditTitle.
  ///
  /// In de, this message translates to:
  /// **'Futterplan bearbeiten'**
  String get feedPlanEditTitle;

  /// No description provided for @feedPlanName.
  ///
  /// In de, this message translates to:
  /// **'Name der Version'**
  String get feedPlanName;

  /// No description provided for @feedPlanNameHint.
  ///
  /// In de, this message translates to:
  /// **'z. B. Winter-Ration'**
  String get feedPlanNameHint;

  /// No description provided for @feedPlanValidFrom.
  ///
  /// In de, this message translates to:
  /// **'Gültig ab'**
  String get feedPlanValidFrom;

  /// No description provided for @feedPlanNotes.
  ///
  /// In de, this message translates to:
  /// **'Notiz'**
  String get feedPlanNotes;

  /// No description provided for @feedMeals.
  ///
  /// In de, this message translates to:
  /// **'Mahlzeiten'**
  String get feedMeals;

  /// No description provided for @feedMealAdd.
  ///
  /// In de, this message translates to:
  /// **'Mahlzeit hinzufügen'**
  String get feedMealAdd;

  /// No description provided for @feedMealName.
  ///
  /// In de, this message translates to:
  /// **'Mahlzeit'**
  String get feedMealName;

  /// No description provided for @feedMealTime.
  ///
  /// In de, this message translates to:
  /// **'Uhrzeit'**
  String get feedMealTime;

  /// No description provided for @feedMealRemove.
  ///
  /// In de, this message translates to:
  /// **'Mahlzeit entfernen'**
  String get feedMealRemove;

  /// No description provided for @feedEntryAdd.
  ///
  /// In de, this message translates to:
  /// **'Futtermittel hinzufügen'**
  String get feedEntryAdd;

  /// No description provided for @feedEntryItem.
  ///
  /// In de, this message translates to:
  /// **'Futtermittel'**
  String get feedEntryItem;

  /// No description provided for @feedEntryAmount.
  ///
  /// In de, this message translates to:
  /// **'Menge'**
  String get feedEntryAmount;

  /// No description provided for @feedEntryRemove.
  ///
  /// In de, this message translates to:
  /// **'Position entfernen'**
  String get feedEntryRemove;

  /// No description provided for @feedNeedItems.
  ///
  /// In de, this message translates to:
  /// **'Lege zuerst Futtermittel an.'**
  String get feedNeedItems;

  /// No description provided for @feedVersionNew.
  ///
  /// In de, this message translates to:
  /// **'Neue Version'**
  String get feedVersionNew;

  /// No description provided for @feedVersionNewTitle.
  ///
  /// In de, this message translates to:
  /// **'Neue Version ab wann?'**
  String get feedVersionNewTitle;

  /// No description provided for @feedVersionNewHint.
  ///
  /// In de, this message translates to:
  /// **'Die aktuelle Version wird kopiert; du kannst sie danach anpassen. Die bisherige Version bleibt in der Historie.'**
  String get feedVersionNewHint;

  /// No description provided for @feedVersionCurrent.
  ///
  /// In de, this message translates to:
  /// **'aktuell'**
  String get feedVersionCurrent;

  /// No description provided for @feedVersionFuture.
  ///
  /// In de, this message translates to:
  /// **'ab {date}'**
  String feedVersionFuture(String date);

  /// No description provided for @feedVersionDeleteTitle.
  ///
  /// In de, this message translates to:
  /// **'Version löschen?'**
  String get feedVersionDeleteTitle;

  /// No description provided for @feedVersionDeleteText.
  ///
  /// In de, this message translates to:
  /// **'Diese Version des Futterplans wird unwiderruflich gelöscht.'**
  String get feedVersionDeleteText;

  /// No description provided for @feedSupplementNew.
  ///
  /// In de, this message translates to:
  /// **'Zusatz hinzufügen'**
  String get feedSupplementNew;

  /// No description provided for @feedSupplementEdit.
  ///
  /// In de, this message translates to:
  /// **'Zusatz bearbeiten'**
  String get feedSupplementEdit;

  /// No description provided for @feedSupplementAmountAsDirected.
  ///
  /// In de, this message translates to:
  /// **'Menge laut Packungsangabe'**
  String get feedSupplementAmountAsDirected;

  /// No description provided for @feedSupplementMeal.
  ///
  /// In de, this message translates to:
  /// **'Zu welcher Mahlzeit?'**
  String get feedSupplementMeal;

  /// No description provided for @feedSupplementMealDaily.
  ///
  /// In de, this message translates to:
  /// **'einmal täglich'**
  String get feedSupplementMealDaily;

  /// No description provided for @feedSupplementStart.
  ///
  /// In de, this message translates to:
  /// **'Beginn'**
  String get feedSupplementStart;

  /// No description provided for @feedSupplementEnd.
  ///
  /// In de, this message translates to:
  /// **'Ende'**
  String get feedSupplementEnd;

  /// No description provided for @feedSupplementDuration.
  ///
  /// In de, this message translates to:
  /// **'Dauer'**
  String get feedSupplementDuration;

  /// No description provided for @feedSupplementWeeks.
  ///
  /// In de, this message translates to:
  /// **'{weeks} Wochen'**
  String feedSupplementWeeks(int weeks);

  /// No description provided for @feedSupplementNote.
  ///
  /// In de, this message translates to:
  /// **'Notiz (z. B. Kur, Grund)'**
  String get feedSupplementNote;

  /// No description provided for @feedSupplementsEmpty.
  ///
  /// In de, this message translates to:
  /// **'Keine Zusätze'**
  String get feedSupplementsEmpty;

  /// No description provided for @feedSupplementActive.
  ///
  /// In de, this message translates to:
  /// **'Aktiv'**
  String get feedSupplementActive;

  /// No description provided for @feedSupplementUpcoming.
  ///
  /// In de, this message translates to:
  /// **'Geplant'**
  String get feedSupplementUpcoming;

  /// No description provided for @feedSupplementPast.
  ///
  /// In de, this message translates to:
  /// **'Abgelaufen'**
  String get feedSupplementPast;

  /// No description provided for @feedSupplementRange.
  ///
  /// In de, this message translates to:
  /// **'{from} – {to}'**
  String feedSupplementRange(String from, String to);

  /// No description provided for @feedSupplementFromBlood.
  ///
  /// In de, this message translates to:
  /// **'aus Blutbild-Auswertung'**
  String get feedSupplementFromBlood;

  /// No description provided for @feedSupplementDeleteTitle.
  ///
  /// In de, this message translates to:
  /// **'Zusatz löschen?'**
  String get feedSupplementDeleteTitle;

  /// No description provided for @feedDisclaimer.
  ///
  /// In de, this message translates to:
  /// **'Nur Dokumentation – keine Rationsberechnung. Mengen bitte mit Tierarzt oder Futterberatung abstimmen.'**
  String get feedDisclaimer;

  /// No description provided for @feedItemStockLabel.
  ///
  /// In de, this message translates to:
  /// **'Vorrat'**
  String get feedItemStockLabel;

  /// No description provided for @healthTitle.
  ///
  /// In de, this message translates to:
  /// **'Gesundheit'**
  String get healthTitle;

  /// No description provided for @healthNoTest.
  ///
  /// In de, this message translates to:
  /// **'Noch kein Blutbild eingetragen'**
  String get healthNoTest;

  /// No description provided for @healthAllInRange.
  ///
  /// In de, this message translates to:
  /// **'Blutbild vom {date}: alles im Referenzbereich'**
  String healthAllInRange(String date);

  /// No description provided for @healthSummary.
  ///
  /// In de, this message translates to:
  /// **'Blutbild vom {date}: {summary}'**
  String healthSummary(String date, String summary);

  /// No description provided for @healthAddTest.
  ///
  /// In de, this message translates to:
  /// **'Blutbild eintragen'**
  String get healthAddTest;

  /// No description provided for @healthTests.
  ///
  /// In de, this message translates to:
  /// **'Blutbilder'**
  String get healthTests;

  /// No description provided for @healthTestsEmptyHint.
  ///
  /// In de, this message translates to:
  /// **'Trag nur die Werte ein, die auf dem Befund zu hoch oder zu niedrig sind – alle anderen gelten als im Referenzbereich.'**
  String get healthTestsEmptyHint;

  /// No description provided for @bloodNew.
  ///
  /// In de, this message translates to:
  /// **'Neues Blutbild'**
  String get bloodNew;

  /// No description provided for @bloodEdit.
  ///
  /// In de, this message translates to:
  /// **'Blutbild bearbeiten'**
  String get bloodEdit;

  /// No description provided for @bloodDate.
  ///
  /// In de, this message translates to:
  /// **'Datum der Blutentnahme'**
  String get bloodDate;

  /// No description provided for @bloodLab.
  ///
  /// In de, this message translates to:
  /// **'Labor'**
  String get bloodLab;

  /// No description provided for @bloodLabDefault.
  ///
  /// In de, this message translates to:
  /// **'Laboklin'**
  String get bloodLabDefault;

  /// No description provided for @bloodNotes.
  ///
  /// In de, this message translates to:
  /// **'Notiz'**
  String get bloodNotes;

  /// No description provided for @bloodSearch.
  ///
  /// In de, this message translates to:
  /// **'Wert suchen (z. B. GGT, Selen, Hämoglobin)'**
  String get bloodSearch;

  /// No description provided for @bloodSearchClear.
  ///
  /// In de, this message translates to:
  /// **'Suche leeren'**
  String get bloodSearchClear;

  /// No description provided for @bloodOnlyEntered.
  ///
  /// In de, this message translates to:
  /// **'Nur eingetragene'**
  String get bloodOnlyEntered;

  /// No description provided for @bloodEnteredCount.
  ///
  /// In de, this message translates to:
  /// **'{count, plural, =0{Noch kein Wert eingetragen} =1{1 Wert eingetragen} other{{count} Werte eingetragen}}'**
  String bloodEnteredCount(int count);

  /// No description provided for @bloodRange.
  ///
  /// In de, this message translates to:
  /// **'Referenz {range}'**
  String bloodRange(String range);

  /// No description provided for @bloodRangeBetween.
  ///
  /// In de, this message translates to:
  /// **'{low}–{high}'**
  String bloodRangeBetween(String low, String high);

  /// No description provided for @bloodRangeBelow.
  ///
  /// In de, this message translates to:
  /// **'< {high}'**
  String bloodRangeBelow(String high);

  /// No description provided for @bloodRangeAbove.
  ///
  /// In de, this message translates to:
  /// **'> {low}'**
  String bloodRangeAbove(String low);

  /// No description provided for @bloodNoMatch.
  ///
  /// In de, this message translates to:
  /// **'Kein Wert gefunden'**
  String get bloodNoMatch;

  /// No description provided for @bloodValue.
  ///
  /// In de, this message translates to:
  /// **'Wert'**
  String get bloodValue;

  /// No description provided for @bloodOwnRange.
  ///
  /// In de, this message translates to:
  /// **'Referenzbereich vom eigenen Befund (optional)'**
  String get bloodOwnRange;

  /// No description provided for @bloodOwnLow.
  ///
  /// In de, this message translates to:
  /// **'untere Grenze'**
  String get bloodOwnLow;

  /// No description provided for @bloodOwnHigh.
  ///
  /// In de, this message translates to:
  /// **'obere Grenze'**
  String get bloodOwnHigh;

  /// No description provided for @bloodRemoveValue.
  ///
  /// In de, this message translates to:
  /// **'Wert entfernen'**
  String get bloodRemoveValue;

  /// No description provided for @bloodStatusHigh.
  ///
  /// In de, this message translates to:
  /// **'zu hoch'**
  String get bloodStatusHigh;

  /// No description provided for @bloodStatusLow.
  ///
  /// In de, this message translates to:
  /// **'zu niedrig'**
  String get bloodStatusLow;

  /// No description provided for @bloodStatusStrongHigh.
  ///
  /// In de, this message translates to:
  /// **'deutlich zu hoch'**
  String get bloodStatusStrongHigh;

  /// No description provided for @bloodStatusStrongLow.
  ///
  /// In de, this message translates to:
  /// **'deutlich zu niedrig'**
  String get bloodStatusStrongLow;

  /// No description provided for @bloodStatusOk.
  ///
  /// In de, this message translates to:
  /// **'im Bereich'**
  String get bloodStatusOk;

  /// No description provided for @bloodDeleteTitle.
  ///
  /// In de, this message translates to:
  /// **'Blutbild löschen?'**
  String get bloodDeleteTitle;

  /// No description provided for @bloodDeleteText.
  ///
  /// In de, this message translates to:
  /// **'Das Blutbild und alle eingetragenen Werte werden gelöscht. Bereits übernommene Zusätze und Termine bleiben.'**
  String get bloodDeleteText;

  /// No description provided for @bloodEvaluation.
  ///
  /// In de, this message translates to:
  /// **'Auswertung'**
  String get bloodEvaluation;

  /// No description provided for @bloodDeviations.
  ///
  /// In de, this message translates to:
  /// **'Abweichende Werte'**
  String get bloodDeviations;

  /// No description provided for @bloodNoDeviations.
  ///
  /// In de, this message translates to:
  /// **'Alle Werte im Referenzbereich – nicht eingetragene Werte gelten als normal.'**
  String get bloodNoDeviations;

  /// No description provided for @bloodVetFirst.
  ///
  /// In de, this message translates to:
  /// **'Zuerst tierärztlich abklären'**
  String get bloodVetFirst;

  /// No description provided for @bloodSuggestions.
  ///
  /// In de, this message translates to:
  /// **'Mögliche Bausteine'**
  String get bloodSuggestions;

  /// No description provided for @bloodSuggestionsHint.
  ///
  /// In de, this message translates to:
  /// **'Auswahl übernehmen: Ergänzungen kommen als zeitlich begrenzte Zusätze in den Futterplan (Menge laut Packungsangabe), Termine in den Pflege-Kalender, Fütterungshinweise in die Notiz des Futterplans.'**
  String get bloodSuggestionsHint;

  /// No description provided for @bloodKind_supplement.
  ///
  /// In de, this message translates to:
  /// **'Futter-Zusatz'**
  String get bloodKind_supplement;

  /// No description provided for @bloodKind_ration.
  ///
  /// In de, this message translates to:
  /// **'Fütterung'**
  String get bloodKind_ration;

  /// No description provided for @bloodKind_management.
  ///
  /// In de, this message translates to:
  /// **'Haltung'**
  String get bloodKind_management;

  /// No description provided for @bloodKind_care.
  ///
  /// In de, this message translates to:
  /// **'Termin'**
  String get bloodKind_care;

  /// No description provided for @bloodWeeks.
  ///
  /// In de, this message translates to:
  /// **'für {weeks} Wochen'**
  String bloodWeeks(int weeks);

  /// No description provided for @bloodControlIn.
  ///
  /// In de, this message translates to:
  /// **'in {weeks, plural, =1{1 Woche} other{{weeks} Wochen}}'**
  String bloodControlIn(int weeks);

  /// No description provided for @bloodInDays.
  ///
  /// In de, this message translates to:
  /// **'in {days, plural, =1{1 Tag} other{{days} Tagen}}'**
  String bloodInDays(int days);

  /// No description provided for @bloodApply.
  ///
  /// In de, this message translates to:
  /// **'In Futterplan übernehmen'**
  String get bloodApply;

  /// No description provided for @bloodApplied.
  ///
  /// In de, this message translates to:
  /// **'{supplements} Zusätze, {events} Termine, {notes} Hinweise übernommen'**
  String bloodApplied(int supplements, int events, int notes);

  /// No description provided for @bloodApplyNothing.
  ///
  /// In de, this message translates to:
  /// **'Bitte mindestens einen Baustein auswählen.'**
  String get bloodApplyNothing;

  /// No description provided for @bloodPlanNoteLine.
  ///
  /// In de, this message translates to:
  /// **'Hinweis aus Blutbild vom {date}: {title}'**
  String bloodPlanNoteLine(String date, String title);

  /// No description provided for @bloodSource.
  ///
  /// In de, this message translates to:
  /// **'Quelle der Referenzwerte'**
  String get bloodSource;
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
