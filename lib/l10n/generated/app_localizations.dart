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
  /// **'Hier erscheinen bald Hufe, Wurmkuren, Impfungen und Tierarzttermine.'**
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
  /// **'Hier erscheinen bald deine Schichten und die Stallzeit pro Tag.'**
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
