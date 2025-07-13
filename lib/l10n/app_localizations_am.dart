// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Amharic (`am`).
class AppLocalizationsAm extends AppLocalizations {
  AppLocalizationsAm([String locale = 'am']) : super(locale);

  @override
  String ethiopianMonth(String monthIndex) {
    String _temp0 = intl.Intl.selectLogic(monthIndex, {
      '1': 'መስከረም',
      '2': 'ጥቅምት',
      '3': 'ኅዳር',
      '4': 'ታኅሣሥ',
      '5': 'ጥር',
      '6': 'የካቲት',
      '7': 'መጋቢት',
      '8': 'ሚያዝያ',
      '9': 'ግንቦት',
      '10': 'ሰኔ',
      '11': 'ሐምሌ',
      '12': 'ነሐሴ',
      '13': 'ጳጉሜ',
      'other': 'የማይታወቀ ወር',
    });
    return '$_temp0';
  }

  @override
  String ethiopianWeekday(String weekdayIndex) {
    String _temp0 = intl.Intl.selectLogic(weekdayIndex, {
      '1': 'ሰኞ',
      '2': 'ማክሰኞ',
      '3': 'ረቡዕ',
      '4': 'ሐሙስ',
      '5': 'ዓርብ',
      '6': 'ቅዳሜ',
      '7': 'እሁድ',
      'other': 'የማይታወቀ ቀን',
    });
    return '$_temp0';
  }

  @override
  String get month => 'ወር';

  @override
  String get dateConvert => 'ቀን ለውጥ';

  @override
  String get toGregorian => 'ወደ ግሪጎሪያን ቀን አቆጣጠር';

  @override
  String get settings => 'ቅንብሮች';

  @override
  String get selectLanguage => 'ቋንቋ ምረጥ';

  @override
  String get systemTheme => 'የስርዓቱን ገጽታ ተጠቀም';

  @override
  String get themeDescription => 'በስርዓቱ ገጽታ መሰረት ለውጥ';

  @override
  String get darkMode => 'ጨለማ ሁነታ';

  @override
  String get darkModeDescription => 'ጨለማ ገጽታን አንቃ';

  @override
  String get about => 'ስለ';

  @override
  String get appDescription =>
      'ቀን መቁጠሪያ የኢትዮጵያ ቀን አቆጣጠር መተግበሪያ ሲሆን ሙሉ ወር እይታን ከግሪጎሪያን ቀን አቆጣጠር ጋር አብሮ ያሳያል።';

  @override
  String get gitRepo => 'ጊት ሀብ ማከማቻ';

  @override
  String get developer => 'ገንቢ';

  @override
  String get viewOpenSourceL => 'ክፍት ምንጭ ፈቃዶችን እይ';

  @override
  String get cantOpenLink => 'ሊንኩን ማስፈር አልተቻለም';

  @override
  String get ethiopianCalendar => 'የኢትዮጵያ ቀን አቆጣጠር';

  @override
  String get gregorianCalendar => 'ግሪጎሪያን ቀን አቆጣጠር';

  @override
  String get today => 'ዛሬ';

  @override
  String get selectDate => 'ቀን ምረጥ';

  @override
  String get year => 'ዓመት';

  @override
  String get day => 'ቀን';

  @override
  String get currentDate => 'የአሁኑ ቀን';

  @override
  String get convertedDate => 'የተለወጠ ቀን';

  @override
  String get era => 'ዘመን';

  @override
  String get weekday => 'የሳምንቱ ቀን';

  @override
  String get monthName => 'የወሩ ስም';

  @override
  String get yearInEthiopian => 'በኢትዮጵያ ዓመት';

  @override
  String get yearInGregorian => 'በግሪጎሪያን ዓመት';

  @override
  String get newYear => 'አዲስ ዓመት (እንቁጣጣሽ)';

  @override
  String get epiphany => 'ጥምቀት';

  @override
  String get findingTrueCross => 'መስቀል';

  @override
  String get christmas => 'ገና';
}
