import 'package:abushakir/abushakir.dart';
import 'package:eccalendar/screens/month_screen.dart';
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
        ChangeNotifierProvider<PageProvider>(
          create: (context) => PageProvider(),
        ),
        ChangeNotifierProvider<CalEventProvider>(
          create: (context) => CalEventProvider(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  _MainLayoutState createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  final double sidebarWidth = 250;
  final Duration duration = Duration(milliseconds: 300);
  late final PageProvider pageProvider;
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    pageProvider = Provider.of<PageProvider>(context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
    // pageProvider.dispose();
  }

  Widget buildMenuItem(BuildContext context, String title, PageType page) {
    bool isActive = pageProvider.currentPage == page;
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          color: isActive ? Colors.white : Colors.white70,
          fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      tileColor: isActive ? Colors.black26 : Colors.transparent,
      onTap: () => pageProvider.switchPage(page),
    );
  }

  Widget getPageContent(PageType type) {
    switch (type) {
      case PageType.year:
        return Center(child: Text("Year Page", style: TextStyle(fontSize: 24)));
      case PageType.month:
        return EthMonthlyView();
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
    // _currentDate =
    // Provider.of<DateChangeNotifier>(context, listen: false).changeDate;
    return Consumer<PageProvider>(
      builder: (context, provider, _) {
        return Scaffold(
          body: Stack(
            children: [
              // Sidebar
              AnimatedPositioned(
                duration: duration,
                left: provider.isSidebarOpen ? 0 : -sidebarWidth,
                top: 0,
                bottom: 0,
                child: Container(
                  width: sidebarWidth,
                  color: Colors.blueGrey[800],
                  child: Column(
                    children: [
                      SizedBox(height: 100),
                      buildMenuItem(context, "Month", PageType.month),
                      buildMenuItem(context, "Convert", PageType.convert),
                      buildMenuItem(context, "Settings", PageType.settings),
                      Spacer(),
                      ListTile(
                        leading: Icon(Icons.close, color: Colors.white),
                        title: Text(
                          "Close",
                          style: TextStyle(color: Colors.white),
                        ),
                        onTap: () => provider.closeSideBar(),
                      ),
                    ],
                  ),
                ),
              ),
              // Main content
              AnimatedPositioned(
                duration: duration,
                left: provider.isSidebarOpen ? sidebarWidth : 0,
                right: provider.isSidebarOpen ? -sidebarWidth : 0,
                top: 0,
                bottom: 0,
                child: AnimatedSwitcher(
                  duration: Duration(milliseconds: 300),
                  child: getPageContent(provider.currentPage),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
