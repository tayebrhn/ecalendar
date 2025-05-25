import 'package:abushakir/abushakir.dart';
import 'package:eccalendar/screens/month_view.dart';
import 'package:eccalendar/utils/eth_utils.dart';
import 'package:eccalendar/screens/weekly_view.dart';
import 'package:eccalendar/utils/themedata_extension.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'calander_grid.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
      home: EthMonthlyView(),
    );
  }
}
