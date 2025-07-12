import 'package:abushakir/abushakir.dart';
import '../utils/eth_utils.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

enum AppThemeMode { system, light, dark }

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
