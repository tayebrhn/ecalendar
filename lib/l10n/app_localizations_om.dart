// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Oromo (`om`).
class AppLocalizationsOm extends AppLocalizations {
  AppLocalizationsOm([String locale = 'om']) : super(locale);

  @override
  String ethiopianMonth(String monthIndex) {
    String _temp0 = intl.Intl.selectLogic(monthIndex, {
      '1': 'Fulbaana',
      '2': 'Onkololeessa',
      '3': 'Sadaasa',
      '4': 'Muddee',
      '5': 'Amajjii',
      '6': 'Guraandhala',
      '7': 'Bitootessa',
      '8': 'Elba',
      '9': 'Caamsa',
      '10': 'Waxabajjii',
      '11': 'Adooleessa',
      '12': 'Hagayya',
      '13': 'Pagume',
      'other': 'Ji\'a dogoggoraa',
    });
    return '$_temp0';
  }

  @override
  String ethiopianWeekday(String weekdayIndex) {
    String _temp0 = intl.Intl.selectLogic(weekdayIndex, {
      '1': 'Wiixata',
      '2': 'Kamisa Duraa',
      '3': 'Roobii',
      '4': 'Kamiisa',
      '5': 'Jimaata',
      '6': 'Sanbata Duraa',
      '7': 'Dilbata',
      'other': 'Guyyaa dogoggoraa',
    });
    return '$_temp0';
  }

  @override
  String get month => 'Ji\'a';

  @override
  String get dateConvert => 'Guyyaa Jijjiiri';

  @override
  String get toGregorian => 'Gara Kaalaandara Girigoriaaniitti';

  @override
  String get settings => 'Qindaa\'ina';

  @override
  String get selectLanguage => 'Afaan Filadhu';

  @override
  String get systemTheme => 'Haala Sirnaa Fayyadami';

  @override
  String get themeDescription => 'Akka haala sirnaatti jijjiiri';

  @override
  String get darkMode => 'Haala Dukkanaa';

  @override
  String get darkModeDescription => 'Haala dukkanaa dandeessisi';

  @override
  String get about => 'Waa\'ee';

  @override
  String get appDescription =>
      'Lakkoofsa Guyyaa appii kaalaandara Itoophiyaa kan ji\'a guutuu mul\'isa kaalaandara Girigoriaani waliin agarsiisudha.';

  @override
  String get gitRepo => 'Kuusdhaabbata Githaab';

  @override
  String get developer => 'Hojjetaa';

  @override
  String get viewOpenSourceL => 'Hayyamoota Madda Banaa Ilaali';

  @override
  String get cantOpenLink => 'Linkicha banuun hindanda\'amne';

  @override
  String get ethiopianCalendar => 'Kaalaandara Itoophiyaa';

  @override
  String get gregorianCalendar => 'Kaalaandara Girigoriaani';

  @override
  String get today => 'Har\'a';

  @override
  String get selectDate => 'Guyyaa Filadhu';

  @override
  String get year => 'Bara';

  @override
  String get day => 'Guyyaa';

  @override
  String get currentDate => 'Guyyaa Ammaa';

  @override
  String get convertedDate => 'Guyyaa Jijjiiraman';

  @override
  String get era => 'Yeroo';

  @override
  String get weekday => 'Guyyaa Torbaatii';

  @override
  String get monthName => 'Maqaa Ji\'aa';

  @override
  String get yearInEthiopian => 'Bara Itoophiyaatiin';

  @override
  String get yearInGregorian => 'Bara Girigoriaaniitiin';

  @override
  String get newYear => 'Bara Haaraa (Irreecha)';

  @override
  String get epiphany => 'Cuuphaatii';

  @override
  String get findingTrueCross => 'Masqala';

  @override
  String get christmas => 'Genna';
}
