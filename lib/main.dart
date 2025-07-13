import 'package:flutter/foundation.dart';

import '/screens/about_screen.dart';
import '/screens/convert_screen.dart';
import '/screens/month_screen.dart';
import '/screens/settings_screen.dart';
import '/state/state_manager.dart';
import '/utils/eth_utils.dart';
import '/utils/themedata_extension.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/app_localizations.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<DateChangeNotifier>(
          create: (context) => DateChangeNotifier(),
        ),
        ChangeNotifierProvider<CalEventProvider>(
          create: (context) => CalEventProvider(),
        ),
        ChangeNotifierProvider<ThemeProvider>(
          create: (context) => ThemeProvider(),
        ),
        ChangeNotifierProvider<LanguageProvider>(
          create: (context) => LanguageProvider(),
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
    return Consumer<LanguageProvider>(
      builder: (context, langProvider, child) {
        if (langProvider.isLoading) {
          return MaterialApp(
            home: Scaffold(body: Center(child: CircularProgressIndicator())),
          );
        }

        return MaterialApp(
          theme: ThemeData(
            colorScheme: CalendarColorScheme.lightColorScheme,
            useMaterial3: true,
            extensions: const <ThemeExtension<dynamic>>[
              CalendarThemeData.light,
            ],
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          darkTheme: ThemeData(
            colorScheme: CalendarColorScheme.darkColorScheme,
            useMaterial3: true,
            extensions: const <ThemeExtension<dynamic>>[CalendarThemeData.dark],
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          locale: langProvider.locale,
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          themeMode:
              Provider.of<ThemeProvider>(context, listen: true).currentTheme,
          supportedLocales: [Locale("en"), Locale("am")],
          home: MainScreen(),
        );
      },
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

  @override
  void initState() {
    super.initState();
  }

  final List<Widget> _screens = [
    MonthlyScreen(),
    ConvertScreen(),
    SettingsScreen(),
    AboutScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.pop(context); // Close the drawer
  }

  @override
  Widget build(BuildContext context) {
    final pageCtrlr =
        Provider.of<DateChangeNotifier>(context, listen: true).pageController;
    final dateChange =
        Provider.of<DateChangeNotifier>(context, listen: true).changeDate;
    final date = Provider.of<DateChangeNotifier>(context, listen: true).today;
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              mYYYY(context, dateChange),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(toGreg(dateChange), style: TextStyle(fontSize: 14)),
          ],
        ),
        backgroundColor: Colors.blue[700],
        foregroundColor: Colors.white,
        elevation: 2,
        actions: [
          InkWell(
            onTap: () {
              pageCtrlr.animateToPage(
                initialPage,
                duration: Duration(milliseconds: 50),
                curve: Curves.bounceIn,
              );
            },
            borderRadius: BorderRadius.circular(30),
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  const Icon(Icons.calendar_today_rounded, size: 30),
                  Positioned(
                    top: 3,
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      constraints: BoxConstraints(minWidth: 20, minHeight: 20),
                      child: Text(
                        '${date.day}',
                        style: TextStyle(fontSize: 14),
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
                    getDayName(context, date),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    yYYYMD(context, date),
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            _buildDrawerItem(
              icon: Icons.calendar_view_month,
              title: AppLocalizations.of(context)!.month,
              index: 0,
            ),
            _buildDrawerItem(
              icon: Icons.compare_arrows_sharp,
              title: AppLocalizations.of(context)!.dateConvert,
              index: 1,
            ),
            _buildDrawerItem(
              icon: Icons.settings,
              title: AppLocalizations.of(context)!.settings,
              index: 2,
            ),
            Divider(),
            _buildDrawerItem(
              icon: Icons.info,
              title: AppLocalizations.of(context)!.about,
              index: 3,
            ),
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
    final theme = Theme.of(context).extension<CalendarThemeData>();
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
            color: isSelected ? Colors.blue[700] : theme?.headerTextColor,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
        onTap: () => _onItemTapped(index),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
