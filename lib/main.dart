import 'package:abushakir/abushakir.dart';
import 'package:eccalendar/screens/about_screen.dart';
import 'package:eccalendar/screens/convert_screen.dart';
import 'package:eccalendar/screens/month_screen.dart';
import 'package:eccalendar/screens/settings_screen.dart';
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
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      darkTheme: ThemeData(
        colorScheme: CalendarColorScheme.darkColorScheme,
        useMaterial3: true,
        extensions: const <ThemeExtension<dynamic>>[CalendarThemeData.dark],
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),

      themeMode: ThemeMode.system,
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    MonthlyScreen(),
    ConvertScreen(),
    SettingsScreen(),
    AboutScreen(),
  ];

  final List<String> _titles = ['Month', 'Convert', 'Settings', 'About'];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.pop(context); // Close the drawer
  }

  @override
  Widget build(BuildContext context) {
    EtDatetime dateChangeProvider =
        Provider.of<DateChangeNotifier>(context, listen: true).changeDate;

    return Scaffold(
      appBar: AppBar(
        title: Consumer<DateChangeNotifier>(
          builder: (context, value, child) {
            return Text(
              _selectedIndex == 0
                  ? '${value.changeDate.monthGeez} ${value.changeDate.year}'
                  : _titles[_selectedIndex],
            );
          },
        ),
        backgroundColor: Colors.blue[700],
        foregroundColor: Colors.white,
        elevation: 2,
        actions: [
          InkWell(
            onTap: () {
              // Provider.of<DateChangeNotifier>(context, listen: false)
              //     .changeDate = EtDatetime.now();
              // dateChangeProvider.jumpToDay();
              // dateChangeProvider.selectedDate =
              // dateChangeProvider.changeDate = dateChangeProvider.today;

              // setState(() {
              // var newDate = EtDatetime.now();
              // _currentDate = newDate;
              // _selectedtDate = newDate;
              // // Jump to the correct page if needed
              // final diff =
              //     (dateChangeProvider.changeDate.year - dateChangeProvider.today.year) * 13 +
              //     (dateChangeProvider.changeDate.month - dateChangeProvider.today.month);
              // _pageController.jumpToPage(EthUtils.initialPage);
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
                      constraints: BoxConstraints(minWidth: 20, minHeight: 20),
                      child: Text(
                        '${EtDatetime.now().day}',
                        style: TextStyle(
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
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue[700]!, Colors.blue[500]!],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.calendar_month,
                      size: 40,
                      color: Colors.blue[700],
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'today',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'year month',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),

            _buildDrawerItem(
              icon: Icons.calendar_view_month,
              title: 'Month',
              index: 0,
            ),
            _buildDrawerItem(
              icon: Icons.compare_arrows_sharp,
              title: 'Date convert',
              index: 1,
            ),
            _buildDrawerItem(icon: Icons.settings, title: 'Settings', index: 2),
            Divider(),
            _buildDrawerItem(icon: Icons.info, title: 'About', index: 3),
            Divider(),
          ],
        ),
      ),
      body: _screens[_selectedIndex],
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required int index,
  }) {
    bool isSelected = _selectedIndex == index;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: isSelected ? Colors.blue[50] : null,
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: isSelected ? Colors.blue[700] : Colors.grey[600],
        ),
        title: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.blue[700] : Colors.black87,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
        onTap: () => _onItemTapped(index),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
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
        return MonthlyScreen();
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
