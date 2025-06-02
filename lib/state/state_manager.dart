import 'package:abushakir/abushakir.dart';
import '../utils/eth_utils.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum PageType { year, month, convert, settings }

class DateChangeNotifier with ChangeNotifier {
  EtDatetime _selected = EtDatetime.now();
  EtDatetime _changeDate = EtDatetime.now();

  // int _currentPageIndex = EthUtils.initialPage;

  // PageController get pageController => _pageController;
  // int get currentPageIndex => _currentPageIndex;

  // set currentPageIndex(int index) {
  //   _currentPageIndex = index;
  //   notifyListeners();
  // }

  // void jumpToPage(int page) {
  //   _pageController.jumpTo(page as double);
  //   _currentPageIndex = page;
  //   notifyListeners();
  // }

  // void animateToPage(int page) {
  //   _pageController.animateToPage(
  //     page,
  //     duration: Duration(milliseconds: 300),
  //     curve: Curves.easeOut,
  //   );
  //   _currentPageIndex = page;
  //   notifyListeners();
  // }

  // void updateCurrentPageindex(int index) {
  //   _currentPageIndex = index;
  //   notifyListeners();
  // }

  // void jumpToDay() {
  //   var newDate = EtDatetime.now();
  //   // _selectedtDate = newDate;
  //   // Jump to the correct page if needed
  //   final diff =
  //       (newDate.year - EtDatetime.now().year) * 13 +
  //       (newDate.month - EtDatetime.now().month);
  //   print("CURRENT INDEX$_currentPageIndex");

  //   _pageController.animateToPage(
  //     10000,
  //     duration: Duration(milliseconds: 100),
  //     curve: Curves.easeOut,
  //   );
  //   _currentPageIndex = 10000;
  //   _changeDate = today;
  // }

  // @override
  // void dispose() {
  //   _pageController.dispose();
  //   super.dispose();
  // }

  set changeDate(EtDatetime date) {
    _changeDate = date;
    notifyListeners();
  }

  void changeDateUpdate() {
    _changeDate = today;
    notifyListeners();
  }
  // EtDatetime getSetDate(int index) {
  //   _changeDate = EtDatetime(
  //     year: today.year + (index - _currentPageIndex) ~/ 13,
  //     month: today.month + (index - _currentPageIndex) % 13,
  //     day: 1,
  //   );
  //   notifyListeners();
  //   return _changeDate;
  // }

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

class PageProvider with ChangeNotifier {
  PageType _currentPage = PageType.month;
  bool _isSidebarOpen = false;

  PageType get currentPage => _currentPage;
  bool get isSidebarOpen => _isSidebarOpen;

  void openSideBar() {
    _isSidebarOpen = true;
    notifyListeners();
  }

  void closeSideBar() {
    _isSidebarOpen = false;
    notifyListeners();
  }

  void switchPage(PageType page) async {
    if (_currentPage != page) {
      _isSidebarOpen = false;
      notifyListeners();
      await Future.delayed(Duration(milliseconds: 300));
      _currentPage = page;
      notifyListeners();
    } else {
      closeSideBar();
    }
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

void setTheme(AppThemeMode mode){
  _themeMode =mode;
  _saveTheme(mode);
  notifyListeners();
}
Future<void> _loadTheme() async {
  final prefs = await SharedPreferences.getInstance();
  final saved= prefs.getString(_themeKey);
  AppThemeMode.values.firstWhere((element) =>
     element.toString()==saved,orElse: ()=>AppThemeMode.system
  ,);
  _isInitialized=true;
  notifyListeners();
}


  
  Future<void> _saveTheme(AppThemeMode mode) async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themeKey, mode.toString());
  }

  
}
