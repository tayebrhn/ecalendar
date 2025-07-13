// import 'package:flutter/material.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';

// class MaterialLocalizationsOm extends GlobalMaterialLocalizations {
//   const MaterialLocalizationsOm({super.locale = const Locale('om')});

//   static const List<String> _omWeekdays = <String>[
//     'Dilbata',    // Sunday
//     'Wiixata',    // Monday
//     'Kamisa Duraa', // Tuesday
//     'Roobii',     // Wednesday
//     'Kamiisa',    // Thursday
//     'Jimaata',    // Friday
//     'Sanbata Duraa', // Saturday
//   ];

//   static const List<String> _omShortWeekdays = <String>[
//     'Dil', 'Wii', 'Kam', 'Roo', 'Kam', 'Jim', 'San'
//   ];

//   static const List<String> _omMonths = <String>[
//     'Fulbaana',
//     'Onkololeessa',
//     'Sadaasa',
//     'Muddee',
//     'Amajjii',
//     'Guraandhala',
//     'Bitootessa',
//     'Elba',
//     'Caamsa',
//     'Waxabajjii',
//     'Adooleessa',
//     'Hagayya'
//   ];

//   static const List<String> _omShortMonths = <String>[
//     'Ful', 'Onk', 'Sad', 'Mud', 'Ama', 'Gur', 'Bit', 'Elb', 'Caa', 'Wax', 'Ado', 'Hag'
//   ];

//   static const Map<String, String> _omSymbols = <String, String>{
//     'cancelButtonLabel': 'Haquu',
//     'closeButtonLabel': 'Cufi',
//     'continueButtonLabel': 'Itti fufi',
//     'okButtonLabel': 'Tole',
//     'todayLabel': 'Har\'a',
//     'selectAllButtonLabel': 'Hundaa fili',
//     'viewLicensesButtonLabel': 'Hayyama ilaali',
//   };

//   @override
//   String get cancelButtonLabel => _omSymbols['cancelButtonLabel']!;
//   @override
//   String get closeButtonLabel => _omSymbols['closeButtonLabel']!;
//   @override
//   String get continueButtonLabel => _omSymbols['continueButtonLabel']!;
//   @override
//   String get okButtonLabel => _omSymbols['okButtonLabel']!;
//   @override
//   String get todayLabel => _omSymbols['todayLabel']!;
//   @override
//   String get selectAllButtonLabel => _omSymbols['selectAllButtonLabel']!;
//   @override
//   String get viewLicensesButtonLabel => _omSymbols['viewLicensesButtonLabel']!;

//   @override
//   List<String> get narrowWeekdays => _omShortWeekdays;
//   @override
//   List<String> get weekdays => _omWeekdays;
//   @override
//   List<String> get shortWeekdays => _omShortWeekdays;

//   @override
//   List<String> get months => _omMonths;
//   @override
//   List<String> get shortMonths => _omShortMonths;

//   @override
//   int get firstDayOfWeekIndex => 1; // Monday

//   static Future<MaterialLocalizations> load(Locale locale) {
//     return SynchronousFuture<MaterialLocalizations>(
//       const MaterialLocalizationsOm(),
//     );
//   }

//   static const LocalizationsDelegate<MaterialLocalizations> delegate =
//       _MaterialLocalizationsOmDelegate();
// }

// class _MaterialLocalizationsOmDelegate
//     extends LocalizationsDelegate<MaterialLocalizations> {
//   const _MaterialLocalizationsOmDelegate();

//   @override
//   bool isSupported(Locale locale) => locale.languageCode == 'om';

//   @override
//   Future<MaterialLocalizations> load(Locale locale) =>
//       MaterialLocalizationsOm.load(locale);

//   @override
//   bool shouldReload(LocalizationsDelegate<MaterialLocalizations> old) => false;
// }
