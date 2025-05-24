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

  late final PageController _pageController = PageController(
    initialPage: EthUtils.initialPage,
  );

  late List<EtDatetime> weekDays;

  @override
  void initState() {
    super.initState();
    weekDays = EthUtils.getWeekDates(_currentDate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Month View"),
        actions: [
          IconButton(
            icon: Icon(Icons.calendar_today_rounded),
            onPressed:
                () {
                        setState(() {
                          var newDate =EtDatetime.now();
                          _currentDate = newDate;
                          // Jump to the correct page if needed
                          final diff = (newDate.year - EtDatetime.now().year) * 12 + 
                                      (newDate.month - EtDatetime.now().month);
                          _pageController.jumpToPage(EthUtils.initialPage + diff);
                        });
                },
          ),
        ],
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          //
          _buildHeader(),

          // Weekday headers,
          _buildWeekdays(),

          Expanded(
            child: _buildGrid(),
          ),
        ],
      ),
    );
  }
Widget _tableGrid(){
  return PageView.builder(
              controller: _pageController,
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
                final date = EtDatetime(
                  year:
                      EtDatetime.now().year +
                      (index - EthUtils.initialPage) ~/ 12,
                  month:
                      EtDatetime.now().month +
                      (index - EthUtils.initialPage) % 12,
                  day: 1,
                );
                return KeyedSubtree(
                    key: ValueKey<EtDatetime>(date),
                    child: MonthTableView(
                      selectedDate: _currentDate,
                      displayedDate: date,
                      onDateSelected: (newDate) {
                        setState(() {
                          _currentDate = newDate;
                          // Jump to the correct page if needed
                          final diff = (newDate.year - EtDatetime.now().year) * 12 + 
                                      (newDate.month - EtDatetime.now().month);
                          _pageController.jumpToPage(EthUtils.initialPage + diff);
                        });
                      },
                    ),
                  );
              },
            );
}
  Widget _buildGrid() {
    return Expanded(
      child: PageView.builder(
        controller: _pageController,
        scrollDirection: Axis.horizontal,
        dragStartBehavior: DragStartBehavior.down,
        pageSnapping: true,
        scrollBehavior: ScrollBehavior(),
        onPageChanged: (value) {
          setState(() {
            _currentDate = EtDatetime(
              year:
                  EtDatetime.now().year + (value - EthUtils.initialPage) ~/ 12,
              month:
                  EtDatetime.now().month + (value - EthUtils.initialPage) % 12,
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
          return MonthlyCalendarView(month: _currentDate);
        },
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

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed:
                () => _pageController.previousPage(
                  duration: const Duration(
                    milliseconds: 300,
                  ), // Animation duration
                  curve: Curves.easeInOut, // Animation curve
                ),
          ),
          Text(
            '${_currentDate.monthGeez} ${_currentDate.year}',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          IconButton(
            icon: const Icon(Icons.chevron_right),
            onPressed:
                () => _pageController.nextPage(
                  duration: const Duration(
                    milliseconds: 300,
                  ), // Animation duration
                  curve: Curves.easeInOut, // Animation curve
                ),
          ),
        ],
      ),
    );
  }
}
