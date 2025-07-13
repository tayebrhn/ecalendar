// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String ethiopianMonth(String monthIndex) {
    String _temp0 = intl.Intl.selectLogic(monthIndex, {
      '1': 'Meskerem',
      '2': 'Tikimt',
      '3': 'Hidar',
      '4': 'Tahsas',
      '5': 'Tir',
      '6': 'Yekatit',
      '7': 'Megabit',
      '8': 'Miyazya',
      '9': 'Ginbot',
      '10': 'Sene',
      '11': 'Hamle',
      '12': 'Nehase',
      '13': 'Pagumen',
      'other': 'Invalid month',
    });
    return '$_temp0';
  }

  @override
  String ethiopianWeekday(String weekdayIndex) {
    String _temp0 = intl.Intl.selectLogic(weekdayIndex, {
      '1': 'Mon',
      '2': 'Tue',
      '3': 'Wed',
      '4': 'Thur',
      '5': 'Fri',
      '6': 'Sat',
      '7': 'Sun',
      'other': 'Invalid day',
    });
    return '$_temp0';
  }

  @override
  String get month => 'Month';

  @override
  String get dateConvert => 'Convert Date';

  @override
  String get toGregorian => 'To Gregorian Calendar';

  @override
  String get settings => 'Settings';

  @override
  String get selectLanguage => 'Select Language';

  @override
  String get systemTheme => 'Use System Theme';

  @override
  String get themeDescription => 'Change based on system theme';

  @override
  String get darkMode => 'Dark Mode';

  @override
  String get darkModeDescription => 'Enable dark theme';

  @override
  String get about => 'About';

  @override
  String get appDescription =>
      'Ken Mekuteria (የቀን መቁጠሪያ) is an Ethiopian calendar app that displays a full month view alongside the Gregorian calendar.';

  @override
  String get gitRepo => 'Github Repository';

  @override
  String get developer => 'Developer';

  @override
  String get viewOpenSourceL => 'View Open-source Licenses';

  @override
  String get cantOpenLink => 'Could not open link';

  @override
  String get ethiopianCalendar => 'Ethiopian Calendar';

  @override
  String get gregorianCalendar => 'Gregorian Calendar';

  @override
  String get today => 'Today';

  @override
  String get selectDate => 'Select Date';

  @override
  String get year => 'Year';

  @override
  String get day => 'Day';

  @override
  String get currentDate => 'Current Date';

  @override
  String get convertedDate => 'Converted Date';

  @override
  String get era => 'Era';

  @override
  String get weekday => 'Weekday';

  @override
  String get monthName => 'Month Name';

  @override
  String get yearInEthiopian => 'Year in Ethiopian';

  @override
  String get yearInGregorian => 'Year in Gregorian';

  @override
  String get newYear => 'New Year';

  @override
  String get epiphany => 'Epiphany (Timkat)';

  @override
  String get findingTrueCross => 'Finding of the True Cross (Meskel)';

  @override
  String get christmas => 'Christmas (Genna)';
}
