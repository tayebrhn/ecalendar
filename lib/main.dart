import 'package:abushakir/abushakir.dart';
import 'package:eccalendar/screens/month_view.dart';
import 'package:eccalendar/state/state_manager.dart';
import 'package:eccalendar/utils/themedata_extension.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<DateChangeNotifier>(
          create: (context) => DateChangeNotifier(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: CalendarColorScheme.lightColorScheme,
        useMaterial3: true,
        extensions: const <ThemeExtension<dynamic>>[CalendarThemeData.light],
      ),
      darkTheme: ThemeData(
        colorScheme: CalendarColorScheme.darkColorScheme,
        useMaterial3: true,
        extensions: const <ThemeExtension<dynamic>>[CalendarThemeData.dark],
      ),
      themeMode: ThemeMode.system,
      home: MainLayout(),
    );
  }
}

enum PageType { year, month, convert, settings }

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  _MainLayoutState createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  bool isSidebarOpen = false;
  PageType currentPage = PageType.month;
  final double sidebarWidth = 250;
  final Duration duration = Duration(milliseconds: 300);

  EtDatetime _currentDate = EtDatetime.now();

  @override
  void initState() {
    super.initState();
  }

  void switchPage(PageType page) {
    if (currentPage != page) {
      setState(() => isSidebarOpen = false);
      // await Future.delayed(duration);
      // if (!mounted) return;
      setState(() => currentPage = page);
    } else {
      setState(() => isSidebarOpen = false);
    }
  }

  Widget buildMenuItem(String title, PageType page) {
    bool isActive = currentPage == page;
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          color: isActive ? Colors.white : Colors.white70,
          fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      tileColor: isActive ? Colors.black26 : Colors.transparent,
      onTap: () => switchPage(page),
    );
  }

  Widget getPageContent() {
    switch (currentPage) {
      case PageType.year:
        return Center(child: Text("Year Page", style: TextStyle(fontSize: 24)));
      case PageType.month:
        return EthMonthlyView(
          month: _currentDate,
          // onPageChanged: (EtDatetime month) {
          //   setState(() {
          //     _currentDate = month;
          //   });
          // },
          // prevMonthCallback: _goToPreviousMonth,
          // nextMonthCallback: _goToNextMonth,
        );
      case PageType.convert:
        return Center(
          child: Text("Convert Page", style: TextStyle(fontSize: 24)),
        );
      case PageType.settings:
        return Center(
          child: Text("Settings Page", style: TextStyle(fontSize: 24)),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final calendarTheme = Theme.of(context).extension<CalendarThemeData>()!;
    final colorScheme = Theme.of(context).colorScheme;
    _currentDate =
        Provider.of<DateChangeNotifier>(context, listen: false).changeDate;
    return Scaffold(
      body: Stack(
        children: [
          // Sidebar
          AnimatedPositioned(
            duration: duration,
            left: isSidebarOpen ? 0 : -sidebarWidth,
            top: 0,
            bottom: 0,
            child: Container(
              width: sidebarWidth,
              color: Colors.blueGrey[800],
              child: Column(
                children: [
                  SizedBox(height: 100),
                  buildMenuItem("Year", PageType.year),
                  buildMenuItem("Month", PageType.month),
                  buildMenuItem("Convert", PageType.convert),
                  buildMenuItem("Settings", PageType.settings),
                  Spacer(),
                  ListTile(
                    leading: Icon(Icons.close, color: Colors.white),
                    title: Text("Close", style: TextStyle(color: Colors.white)),
                    onTap: () => setState(() => isSidebarOpen = false),
                  ),
                ],
              ),
            ),
          ),
          // Main content
          AnimatedPositioned(
            duration: duration,
            left: isSidebarOpen ? sidebarWidth : 0,
            right: isSidebarOpen ? -sidebarWidth : 0,
            top: 0,
            bottom: 0,
            child: Material(
              elevation: 8,
              child: Scaffold(
                backgroundColor: calendarTheme.headerBackgroundColor,
                appBar: AppBar(
                  backgroundColor: calendarTheme.headerBackgroundColor,
                  leading: IconButton(
                    icon: Icon(Icons.menu),
                    onPressed:
                        () => setState(
                          () =>
                              isSidebarOpen
                                  ? isSidebarOpen = false
                                  : isSidebarOpen = true,
                        ),
                  ),
                  title: Consumer<DateChangeNotifier>(
                    builder: (context, value, child) {
                      return Text(
                        '${value.changeDate.monthGeez} ${value.changeDate.year}',
                        style: TextStyle(
                          color: calendarTheme.headerTextColor,
                          fontSize: 24,
                          fontWeight: FontWeight.w400,
                        ),
                      );
                    },
                  ),
                  actions: [
                    InkWell(
                      onTap: () {
                        // Provider.of<DateChangeNotifier>(context, listen: false)
                        //     .changeDate = EtDatetime.now();
                        Provider.of<DateChangeNotifier>(
                          context,
                          listen: false,
                        ).jumpToDay();

                        // setState(() {
                        // var newDate = EtDatetime.now();
                        // _currentDate = newDate;
                        // _selectedtDate = newDate;
                        // // Jump to the correct page if needed
                        // final diff =
                        //     (newDate.year - EtDatetime.now().year) * 13 +
                        //     (newDate.month - EtDatetime.now().month);
                        // _pageController.jumpToPage(EthUtils.initialPage + diff);
                        //});
                      },
                      borderRadius: BorderRadius.circular(30),
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            const Icon(Icons.calendar_today_rounded, size: 30),
                            Positioned(
                              top: 0,
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                constraints: BoxConstraints(
                                  minWidth: 20,
                                  minHeight: 20,
                                ),
                                child: Text(
                                  '${EtDatetime.now().day}',
                                  style: TextStyle(
                                    color: calendarTheme.headerTextColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                body: AnimatedSwitcher(
                  duration: Duration(milliseconds: 300),
                  child: getPageContent(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
