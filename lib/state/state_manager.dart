import 'package:abushakir/abushakir.dart';
import 'package:eccalendar/utils/eth_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DateChangeNotifier with ChangeNotifier {
  EtDatetime _selected = EtDatetime.now();
  EtDatetime _changeDate = EtDatetime.now();
  int _currentPageIndex = EthUtils.initialPage;
  final PageController _pageController = PageController(
    initialPage: EthUtils.initialPage,
  );

  PageController get pageController => _pageController;
  int get currentPageIndex => _currentPageIndex;
   set currentPageIndex (int index){ _currentPageIndex=index;notifyListeners();}

  void jumpToPage(int page) {
    _pageController.jumpTo(page as double);
    _currentPageIndex = page;
    notifyListeners();
  }

  void animateToPage(int page) {
    _pageController.animateToPage(
      page,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
    _currentPageIndex = page;
    notifyListeners();
  }

  void updateCurrentPageindex(int index) {
    _currentPageIndex = index;
    notifyListeners();
  }

  void jumpToDay() {
    var newDate = EtDatetime.now();
    // _selectedtDate = newDate;
    // Jump to the correct page if needed
    final diff =
        (newDate.year - EtDatetime.now().year) * 13 +
        (newDate.month - EtDatetime.now().month);
        print("CURRENT INDEX$_currentPageIndex");

    _pageController.animateToPage(
      10000,
      duration: Duration(milliseconds: 100),
      curve: Curves.easeOut,
    );
    _currentPageIndex = 10000;
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  set changeDate(EtDatetime date) {
    _changeDate = date;
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
