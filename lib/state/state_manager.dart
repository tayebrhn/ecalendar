import 'package:abushakir/abushakir.dart';
import '../utils/eth_utils.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AppThemeMode { system, light, dark }

class DateChangeNotifier with ChangeNotifier {
  EtDatetime _selected = EtDatetime.now();
  EtDatetime _changeDate = EtDatetime.now();
  int _currentPage = initialPage;
  final PageController _pageController = PageController(
    initialPage: initialPage,
  );

  PageController get pageController => _pageController;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  get currentPage => _currentPage;
  void updatePageNum(int num) {
    _currentPage = num;
  }

  void ifPageSet() {
    _pageController.animateToPage(
      _currentPage,
      duration: Duration(milliseconds: 2),
      curve: Curves.bounceIn,
    );
    // if (_currentPage != initialPage) {}
  }

  set changeDate(EtDatetime date) {
    _changeDate = date;
    notifyListeners();
  }

  void changeDateUpdate() {
    _changeDate = today;
    notifyListeners();
  }

  EtDatetime get changeDate {
    return _changeDate;
  }

  EtDatetime get today {
    return EtDatetime.now();
  }

  EtDatetime get selectedDate {
    return _selected;
  }

  set selectedDate(EtDatetime date) {
    _selected = date;
    notifyListeners();
  }
}

class CalEventProvider with ChangeNotifier {
  BealEvent _bealEvent = BealEvent.empty();

  BealEvent get bealEvent => _bealEvent;

  set bealEvent(BealEvent event) {
    _bealEvent = event;
    notifyListeners();
  }
}

class ThemeProvider with ChangeNotifier {
  static const _themeKey = 'thememode';

  AppThemeMode _themeMode = AppThemeMode.system;

  bool _isInitialized = false;

  ThemeProvider() {
    _loadTheme();
  }

  bool get isInitialized => _isInitialized;

  AppThemeMode get themeMode => _themeMode;

  ThemeMode get currentTheme {
    switch (_themeMode) {
      case AppThemeMode.light:
        return ThemeMode.light;
      case AppThemeMode.dark:
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  void setTheme(AppThemeMode mode) {
    _themeMode = mode;
    _saveTheme(mode);
    notifyListeners();
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString(_themeKey);
    AppThemeMode.values.firstWhere(
      (element) => element.toString() == saved,
      orElse: () => AppThemeMode.system,
    );
    _isInitialized = true;
    notifyListeners();
  }

  Future<void> _saveTheme(AppThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themeKey, mode.toString());
  }
}

class LanguageProvider with ChangeNotifier {
  Locale _locale = const Locale("en");
  bool _isLoading = true;

  Locale get locale => _locale;
  bool get isLoading => _isLoading;

  static const Map<String, String> supportedLanguages = {
    'en': 'English',
    'am': 'አማርኛ',
    // 'om': 'Oromiffa',
  };

  LanguageProvider() {
    _loadSavedLanguages();
  }

  // PRIVATE METHOD - Load saved language from SharedPreferences
  Future<void> _loadSavedLanguages() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final languageCode = prefs.getString('language_code');

      if (languageCode != null &&
          supportedLanguages.containsKey(languageCode)) {
        _locale = Locale(languageCode);
      } else {
        // If no saved language or invalid language, keep default
        _locale = const Locale('en');
      }
    } catch (e) {
      // If error loading, use default
      _locale = const Locale('en');
      debugPrint('Error loading saved language: $e');
    } finally {
      _isLoading = false;
      notifyListeners(); // Tell all widgets listening to this provider to rebuild
    }
  }

  // PUBLIC METHOD - Change language and save to SharedPreferences
  Future<void> setLocale(Locale locale) async {
    if (_locale == locale) return; // Don't do anything if same language

    try {
      // Save to SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('language_code', locale.languageCode);

      // Update the current locale
      _locale = locale;

      // Notify all listening widgets to rebuild
      notifyListeners();
    } catch (e) {
      debugPrint('Error saving language: $e');
      // You might want to show a snackbar or error message here
    }
  }

  // HELPER METHOD - Change language by language code string
  Future<void> setLanguage(String languageCode) async {
    if (supportedLanguages.containsKey(languageCode)) {
      await setLocale(Locale(languageCode));
    }
  }

  // HELPER METHOD - Get display name for current language
  String get currentLanguageName {
    return supportedLanguages[_locale.languageCode] ?? 'English';
  }

  // HELPER METHOD - Check if a language is currently selected
  bool isLanguageSelected(String languageCode) {
    return _locale.languageCode == languageCode;
  }
}
