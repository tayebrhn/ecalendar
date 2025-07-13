import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_am.dart';
import 'app_localizations_en.dart';
import 'app_localizations_om.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
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

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
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
  static const List<Locale> supportedLocales = <Locale>[
    Locale('am'),
    Locale('en'),
    Locale('om'),
  ];

  /// No description provided for @ethiopianMonth.
  ///
  /// In en, this message translates to:
  /// **'{monthIndex, select, 1 {Meskerem} 2 {Tikimt} 3 {Hidar} 4 {Tahsas} 5 {Tir} 6 {Yekatit} 7 {Megabit} 8 {Miyazya} 9 {Ginbot} 10 {Sene} 11 {Hamle} 12 {Nehase} 13 {Pagumen} other {Invalid month}}'**
  String ethiopianMonth(String monthIndex);

  /// No description provided for @ethiopianWeekday.
  ///
  /// In en, this message translates to:
  /// **'{weekdayIndex, select, 1 {Mon} 2 {Tue} 3 {Wed} 4 {Thur} 5 {Fri} 6 {Sat} 7 {Sun} other {Invalid day}}'**
  String ethiopianWeekday(String weekdayIndex);

  /// No description provided for @month.
  ///
  /// In en, this message translates to:
  /// **'Month'**
  String get month;

  /// No description provided for @dateConvert.
  ///
  /// In en, this message translates to:
  /// **'Convert Date'**
  String get dateConvert;

  /// No description provided for @toGregorian.
  ///
  /// In en, this message translates to:
  /// **'To Gregorian Calendar'**
  String get toGregorian;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @selectLanguage.
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get selectLanguage;

  /// No description provided for @systemTheme.
  ///
  /// In en, this message translates to:
  /// **'Use System Theme'**
  String get systemTheme;

  /// No description provided for @themeDescription.
  ///
  /// In en, this message translates to:
  /// **'Change based on system theme'**
  String get themeDescription;

  /// No description provided for @darkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get darkMode;

  /// No description provided for @darkModeDescription.
  ///
  /// In en, this message translates to:
  /// **'Enable dark theme'**
  String get darkModeDescription;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// No description provided for @appDescription.
  ///
  /// In en, this message translates to:
  /// **'Ken Mekuteria (የቀን መቁጠሪያ) is an Ethiopian calendar app that displays a full month view alongside the Gregorian calendar.'**
  String get appDescription;

  /// No description provided for @gitRepo.
  ///
  /// In en, this message translates to:
  /// **'Github Repository'**
  String get gitRepo;

  /// No description provided for @developer.
  ///
  /// In en, this message translates to:
  /// **'Developer'**
  String get developer;

  /// No description provided for @viewOpenSourceL.
  ///
  /// In en, this message translates to:
  /// **'View Open-source Licenses'**
  String get viewOpenSourceL;

  /// No description provided for @cantOpenLink.
  ///
  /// In en, this message translates to:
  /// **'Could not open link'**
  String get cantOpenLink;

  /// No description provided for @ethiopianCalendar.
  ///
  /// In en, this message translates to:
  /// **'Ethiopian Calendar'**
  String get ethiopianCalendar;

  /// No description provided for @gregorianCalendar.
  ///
  /// In en, this message translates to:
  /// **'Gregorian Calendar'**
  String get gregorianCalendar;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @selectDate.
  ///
  /// In en, this message translates to:
  /// **'Select Date'**
  String get selectDate;

  /// No description provided for @year.
  ///
  /// In en, this message translates to:
  /// **'Year'**
  String get year;

  /// No description provided for @day.
  ///
  /// In en, this message translates to:
  /// **'Day'**
  String get day;

  /// No description provided for @currentDate.
  ///
  /// In en, this message translates to:
  /// **'Current Date'**
  String get currentDate;

  /// No description provided for @convertedDate.
  ///
  /// In en, this message translates to:
  /// **'Converted Date'**
  String get convertedDate;

  /// No description provided for @era.
  ///
  /// In en, this message translates to:
  /// **'Era'**
  String get era;

  /// No description provided for @weekday.
  ///
  /// In en, this message translates to:
  /// **'Weekday'**
  String get weekday;

  /// No description provided for @monthName.
  ///
  /// In en, this message translates to:
  /// **'Month Name'**
  String get monthName;

  /// No description provided for @yearInEthiopian.
  ///
  /// In en, this message translates to:
  /// **'Year in Ethiopian'**
  String get yearInEthiopian;

  /// No description provided for @yearInGregorian.
  ///
  /// In en, this message translates to:
  /// **'Year in Gregorian'**
  String get yearInGregorian;

  /// No description provided for @newYear.
  ///
  /// In en, this message translates to:
  /// **'New Year'**
  String get newYear;

  /// No description provided for @epiphany.
  ///
  /// In en, this message translates to:
  /// **'Epiphany (Timkat)'**
  String get epiphany;

  /// No description provided for @findingTrueCross.
  ///
  /// In en, this message translates to:
  /// **'Finding of the True Cross (Meskel)'**
  String get findingTrueCross;

  /// No description provided for @christmas.
  ///
  /// In en, this message translates to:
  /// **'Christmas (Genna)'**
  String get christmas;
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
      <String>['am', 'en', 'om'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'am':
      return AppLocalizationsAm();
    case 'en':
      return AppLocalizationsEn();
    case 'om':
      return AppLocalizationsOm();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
