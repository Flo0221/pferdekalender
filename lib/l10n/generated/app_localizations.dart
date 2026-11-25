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
  /// **'Hier legst du bald deine Pferde mit Profil und Fotos an.'**
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
