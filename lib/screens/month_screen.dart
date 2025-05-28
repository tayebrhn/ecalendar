import 'package:abushakir/abushakir.dart';
import 'package:eccalendar/state/state_manager.dart';
import 'package:eccalendar/utils/themedata_extension.dart';
import 'package:eccalendar/widgets/month_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../utils/eth_utils.dart';

class EthMonthlyView extends StatefulWidget {
  const EthMonthlyView({super.key});
  @override
  State<EthMonthlyView> createState() => _EthMonthlyViewState();
}

class _EthMonthlyViewState extends State<EthMonthlyView> {
  late final PageController _pageController;

  late DateChangeNotifier selectedNotifier;
  late DateChangeNotifier dateChangeProvider;
  late final CalendarThemeData calendarTheme;
  late final ColorScheme colorScheme;
  late final CalEventProvider calEvent;
  late final PageProvider pageProvider;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: EthUtils.initialPage);
  }

  @override
  void didUpdateWidget(covariant EthMonthlyView oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    calendarTheme = Theme.of(context).extension<CalendarThemeData>()!;
    colorScheme = Theme.of(context).colorScheme;
    pageProvider = Provider.of<PageProvider>(context);
    calEvent = Provider.of<CalEventProvider>(context, listen: false);
    dateChangeProvider = Provider.of<DateChangeNotifier>(
      context,
      listen: false,
    );

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
    //not advisable to dispose provider objects
    // pageProvider.dispose();
    // dateChangeProvider.dispose();
    // calEvent.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final pageManager =
    //     Provider.of<DateChangeNotifier>(context, listen: false).pageController;

    return Scaffold(
      backgroundColor: calendarTheme.headerBackgroundColor,
      appBar: AppBar(
        backgroundColor: calendarTheme.headerBackgroundColor,
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () => pageProvider.openSideBar(),
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
              // dateChangeProvider.jumpToDay();
              dateChangeProvider.selectedDate =
                  dateChangeProvider.changeDate = dateChangeProvider.today;

              // setState(() {
              // var newDate = EtDatetime.now();
              // _currentDate = newDate;
              // _selectedtDate = newDate;
              // // Jump to the correct page if needed
              // final diff =
              //     (dateChangeProvider.changeDate.year - dateChangeProvider.today.year) * 13 +
              //     (dateChangeProvider.changeDate.month - dateChangeProvider.today.month);
              _pageController.jumpToPage(EthUtils.initialPage);
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
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(flex: 1, child: _buildWeekdayHeaders(2)),
          Expanded(
            flex: 5,
            child: Container(
              margin: const EdgeInsets.only(bottom: 0, left: 5, right: 5),
              padding: const EdgeInsets.all(5),

              decoration: BoxDecoration(
                color: colorScheme.surface,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 2,
                    offset: Offset(0, 1),
                  ),
                ],
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              child: PageView.builder(
                controller: _pageController,
                scrollDirection: Axis.horizontal,
                dragStartBehavior: DragStartBehavior.down,
                pageSnapping: true,
                key: ValueKey(dateChangeProvider.changeDate.month),
                scrollBehavior: ScrollBehavior(),
                onPageChanged: (value) {
                  if (mounted) {
                    dateChangeProvider.changeDate = EtDatetime(
                      year:
                          EtDatetime.now().year +
                          (value - EthUtils.initialPage) ~/ 12,
                      month:
                          EtDatetime.now().month +
                          (value - EthUtils.initialPage) % 13,
                      day: 1,
                    );
                    // dateChangeProvider.currentPageIndex = value;
                  }
                },
                itemBuilder: (context, index) {
                  // dateChangeProvider.changeDate =

                  return RepaintBoundary(
                    child: MonthlyCalendarView(
                      month: EtDatetime(
                        year:
                            EtDatetime.now().year +
                            (index - EthUtils.initialPage) ~/ 13,
                        month:
                            EtDatetime.now().month +
                            (index - EthUtils.initialPage) % 13,
                        day: 1,
                      ),
                      // onDateSelected: (EtDatetime date) {
                      //   setState(() {
                      //     _selectedtDate = date;
                      //   });
                      // },
                      // prevMonthCallback: _goToPreviousMonth,
                      // nextMonthCallback: _goToNextMonth,
                    ),
                  );
                },
              ),
            ),
          ),

          Expanded(
            flex: 4,
            child: Container(
              height: 100.0,
              padding: const EdgeInsets.all(5),
              margin: const EdgeInsets.all(5),
              alignment: Alignment.topLeft,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white10),
              ),
              child: Consumer<CalEventProvider>(
                builder: (context, value, child) {
                  return Text(
                    value.bealEvent.beal,
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.left,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeekdayHeaders(int startOfWeek) {
    final calendarTheme = Theme.of(context).extension<CalendarThemeData>()!;
    final colorScheme = Theme.of(context).colorScheme;
    // Generate weekday names starting from custom start day
    final weekdays = List.generate(7, (index) {
      final weekday =
          (startOfWeek - 1 + index) % 7 + 1; // Calculate weekday number
      return DateFormat(
        'E',
      ).format(DateTime(2023, 1, weekday)); // Any date with known weekday
    });

    return Container(
      margin: const EdgeInsets.only(top: 10, right: 5, left: 5),
      padding: const EdgeInsets.only(top: 20, right: 5, left: 5),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 2, offset: Offset(0, 1)),
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Table(
        children: [
          TableRow(
            children:
                weekdays
                    .map(
                      (day) => Container(
                        alignment: Alignment.center,
                        child: Text(
                          day,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: colorScheme.onSurface,
                          ),
                        ),
                      ),
                    )
                    .toList(),
          ),
        ],
      ),
    );
  }
}
