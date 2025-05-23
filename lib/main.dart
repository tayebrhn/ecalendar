import 'package:abushakir/abushakir.dart';
import 'package:eccalendar/month_view.dart';
import 'package:eccalendar/utils/eth_utils.dart';
import 'package:eccalendar/weekly_view.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const EthMonthlyView(),
    );
  }
}

class EthMonthlyView extends StatefulWidget {
  const EthMonthlyView({super.key});
  @override
  _EthMonthlyViewState createState() => _EthMonthlyViewState();
}

class _EthMonthlyViewState extends State<EthMonthlyView> {
  EtDatetime _currentDate = EtDatetime.now();

  late final PageController _controller;
  late List<EtDatetime> weekDays;

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: EthUtils.initialPage);
    weekDays = EthUtils.getWeekDates(_currentDate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Month View")),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          //
          // _buildHeader(),
          // Weekday headers,
          Text(
            '${_currentDate.monthGeez} ${_currentDate.year}',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          _buildWeekdays(),
          Expanded(
            child: PageView.builder(
              controller: _controller,
              scrollDirection: Axis.horizontal,
              dragStartBehavior: DragStartBehavior.down,
              pageSnapping: true,
              scrollBehavior: ScrollBehavior(),
              onPageChanged: (value) {
                setState(() {
                  _currentDate = EtDatetime(
                    year:
                        EtDatetime.now().year +
                        (value - EthUtils.initialPage) ~/ 12,
                    month:
                        EtDatetime.now().month +
                        (value - EthUtils.initialPage) % 12,
                    day: 1,
                  );
                });
              },
              itemBuilder: (context, index) {
                // final monthOffset = index - EthUtils.initialPage;
                // final targetMonth = EtDatetime(
                //   year: _currentDate.year,
                //   month: _currentDate.month + monthOffset,
                // );
                return MonthlyCalendarView(
                  month: _currentDate,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeekdays() {
    return const Row(
      children: [
        Expanded(child: Center(child: Text('Mon'))),
        Expanded(child: Center(child: Text('Tue'))),
        Expanded(child: Center(child: Text('Wed'))),
        Expanded(child: Center(child: Text('Thu'))),
        Expanded(child: Center(child: Text('Fri'))),
        Expanded(child: Center(child: Text('Sat'))),
        Expanded(child: Center(child: Text('Sun'))),
      ],
    );
  }
}
