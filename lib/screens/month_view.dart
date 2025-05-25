import 'package:abushakir/abushakir.dart';
import 'package:eccalendar/screens/date_details.dart';
import 'package:eccalendar/utils/calendar_colors.dart';
import 'package:eccalendar/utils/themedata_extension.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../utils/eth_utils.dart';

class EthMonthlyView extends StatefulWidget {
  const EthMonthlyView({super.key});
  @override
  _EthMonthlyViewState createState() => _EthMonthlyViewState();
}

class _EthMonthlyViewState extends State<EthMonthlyView> {
  EtDatetime _currentDate = EtDatetime.now();
  EtDatetime _selectedtDate = EtDatetime.now();

  late final PageController _pageController = PageController(
    initialPage: EthUtils.initialPage,
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goToPreviousMonth() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _goToNextMonth() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final calendarTheme = Theme.of(context).extension<CalendarThemeData>()!;
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: calendarTheme.headerBackgroundColor,
      appBar: AppBar(
        backgroundColor: calendarTheme.headerBackgroundColor,

        title: Text(
          '${_currentDate.monthGeez} ${_currentDate.year}',
          style: TextStyle(
            color: calendarTheme.headerTextColor,
            fontSize: 24,
            fontWeight: FontWeight.w400,
          ),
        ),
        actions: [
          IconButton(
            color: calendarTheme.headerTextColor,
            icon: Icon(Icons.calendar_today_rounded),
            onPressed: () {
              setState(() {
                var newDate = EtDatetime.now();
                _currentDate = newDate;
                // Jump to the correct page if needed
                final diff =
                    (newDate.year - EtDatetime.now().year) * 13 +
                    (newDate.month - EtDatetime.now().month);
                _pageController.jumpToPage(EthUtils.initialPage + diff);
              });
            },
          ),
        ],
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [_buildWeekdayHeaders(2), Expanded(child: _buildGrid())],
      ),
    );
  }

  Widget _tableGrid() {
    return PageView.builder(
      controller: _pageController,
      onPageChanged: (value) {
        setState(() {
          _currentDate = EtDatetime(
            year: EtDatetime.now().year + (value - EthUtils.initialPage) ~/ 12,
            month: EtDatetime.now().month + (value - EthUtils.initialPage) % 12,
            day: 1,
          );
        });
      },
      itemBuilder: (context, index) {
        final date = EtDatetime(
          year: EtDatetime.now().year + (index - EthUtils.initialPage) ~/ 12,
          month: EtDatetime.now().month + (index - EthUtils.initialPage) % 12,
          day: 1,
        );
        return MonthTableView(
          selectedDate: _currentDate,
          displayedDate: date,
          onDateSelected: (newDate) {
            setState(() {
              _currentDate = newDate;
              // Jump to the correct page if needed
              final diff =
                  (newDate.year - EtDatetime.now().year) * 12 +
                  (newDate.month - EtDatetime.now().month);
              _pageController.jumpToPage(EthUtils.initialPage + diff);
            });
          },
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
                  EtDatetime.now().month + (value - EthUtils.initialPage) % 13,
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
            selectedDate: _selectedtDate,
            // prevMonthCallback: _goToPreviousMonth,
            // nextMonthCallback: _goToNextMonth,
          );
        },
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
      margin: const EdgeInsets.only( top: 5),

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
                        padding: const EdgeInsets.all(5.0),
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

class MonthlyCalendarView extends StatefulWidget {
  final EtDatetime month;
  EtDatetime selectedDate;
  // final VoidCallback prevMonthCallback;
  // final VoidCallback nextMonthCallback;

  MonthlyCalendarView({
    super.key,
    required this.month,
    required this.selectedDate,
    // required this.prevMonthCallback,
    // required this.nextMonthCallback,
  });

  @override
  State<MonthlyCalendarView> createState() => _MonthlyCalendarViewState();
}

class _MonthlyCalendarViewState extends State<MonthlyCalendarView> {
  @override
  Widget build(BuildContext context) {
    final calendarTheme = Theme.of(context).extension<CalendarThemeData>()!;
    final colorScheme = Theme.of(context).colorScheme;
    // final EtDatetime month = widget.month;
    // EtDatetime? selectedDate = widget.selectedDate;
    // final days = _generateMonthDays(month);
    // final EtDatetime today = EtDatetime.now();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Full 6-row grid
        Container(
          margin: const EdgeInsets.only(bottom: 5),
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
          child: Table(
            border: TableBorder.symmetric(),
            children: _buildCalendarRows(),
          ),
        ),
        SizedBox(height: 5),
        Flexible(fit: FlexFit.loose, child: Text("Todo Events")),
      ],
    );
  }

  List<TableRow> _buildCalendarRows() {
    // Create list of days to display (including leading/trailing days from other months)
    final List<_DayCell> days = _generateMonthDays(widget.month);

    // Build table rows
    final rows = <TableRow>[];

    // Add day cells
    for (var i = 0; i < days.length; i += 7) {
      final week = days.sublist(i, i + 7);

      rows.add(
        TableRow(children: week.map((date) => _buildDayCell(date)).toList()),
      );
    }

    return rows;
  }

  Widget _buildDayCell(_DayCell cellDate) {
    final calendarTheme = Theme.of(context).extension<CalendarThemeData>()!;
    final colorScheme = Theme.of(context).colorScheme;
    final EtDatetime today = EtDatetime.now();
    EtDatetime? selectedDate = widget.selectedDate;

    final isToday = EthUtils.isSameDay(cellDate.date, today);
    final isSelected = EthUtils.isSameDay(cellDate.date, selectedDate);
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.selectedDate = cellDate.date;
        });
        if (isSelected) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EtDateDetails(selectedDate: cellDate.date),
            ),
          );
        }
      },
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.all(1),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: isToday ? calendarTheme.todayHighlightColor : null,
          border: Border.all(
            color:
                isSelected
                    ? calendarTheme.selectedDayColor
                    : isToday
                    ? calendarTheme.todayHighlightColor
                    : Color(0x00000000),
          ),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          '${cellDate.date.day}',
          style: TextStyle(
            color:
                cellDate.isCurrentMonth
                    ? colorScheme.primary
                    : calendarTheme.disabledDayTextColor,
            fontWeight:
                isSelected || isToday
                    ? FontWeight.w800
                    : cellDate.isCurrentMonth
                    ? FontWeight.w500
                    : FontWeight.w400,
          ),
        ),
      ),
    );
  }

  // Widget _buildHeader() {
  //   return Padding(
  //     padding: const EdgeInsets.all(16.0),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       children: [
  //         IconButton(
  //           icon: const Icon(Icons.chevron_left),
  //           onPressed: widget.prevMonthCallback,
  //         ),
  //         Text(
  //           '${widget.month.monthGeez} ${widget.month.year}',
  //           style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
  //         ),
  //         IconButton(
  //           icon: const Icon(Icons.chevron_right),
  //           onPressed: widget.nextMonthCallback,
  //         ),
  //       ],
  //     ),
  //   );
  // }

  List<_DayCell> _generateMonthDays(EtDatetime month) {
    final firstDay = EtDatetime(year: month.year, month: month.month);
    final startWeekDay = firstDay.weekday % 7;
    final totalDays =
        ETC(year: month.year, month: month.month).monthDays().length;

    //prev month
    final EtDatetime prevMonth;
    if (month.month - 1 == 0) {
      prevMonth = EtDatetime(year: month.year - 1, month: 13);
    } else {
      prevMonth = EtDatetime(year: month.year, month: month.month - 1);
    }
    final prevMonthDays =
        ETC(year: prevMonth.year, month: prevMonth.month).monthDays().length +
        1;
    final leadingDays = [
      for (int i = startWeekDay; i > 0; i--)
        _DayCell(
          date: EtDatetime(
            year: prevMonth.year,
            month: prevMonth.month,
            day: prevMonthDays - i,
          ),
          isCurrentMonth: false,
        ),
    ];

    //current month
    final currentDays = [
      for (int d = 1; d <= totalDays; d++)
        _DayCell(
          date: EtDatetime(year: month.year, month: month.month, day: d),
          isCurrentMonth: true,
        ),
    ];

    // Next month
    final totalCells = (leadingDays.length + currentDays.length) > 35 ? 42 : 35;
    final trailingNeeded =
        totalCells - (leadingDays.length + currentDays.length);
    final nextMonth = EtDatetime(year: month.year, month: month.month + 1);
    final trailingDays = [
      for (int d = 1; d <= trailingNeeded; d++)
        _DayCell(
          date: EtDatetime(
            year: nextMonth.year,
            month: nextMonth.month,
            day: d,
          ),
          isCurrentMonth: false,
        ),
    ];

    return [...leadingDays, ...currentDays, ...trailingDays];
  }
}

class _DayCell {
  final EtDatetime date;
  final bool isCurrentMonth;

  _DayCell({required this.date, required this.isCurrentMonth});
}

class MonthTableView extends StatelessWidget {
  final EtDatetime selectedDate;
  final EtDatetime displayedDate;
  final ValueChanged<EtDatetime> onDateSelected;

  const MonthTableView({
    super.key,
    required this.selectedDate,
    required this.displayedDate,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Table(children: _buildCalendarRows());
  }

  List<TableRow> _buildCalendarRows() {
    final year = displayedDate.year;
    final month = displayedDate.month;
    final firstDay = EtDatetime(year: year, month: month, day: 1);
    final daysInMonth = firstDay.days;

    // Calculate weekday of first day (1 = Monday, 7 = Sunday)
    final firstWeekday = firstDay.weekday;

    // Create list of days to display (including leading/trailing days from other months)
    final days = <EtDatetime>[];

    // Add leading days from previous month if needed
    if (firstWeekday != 1) {
      final previousMonth = EtDatetime(year: year, month: month - 1, day: 1);
      final daysInPreviousMonth = previousMonth.days;

      for (
        var i = daysInPreviousMonth - (firstWeekday - 2);
        i <= daysInPreviousMonth;
        i++
      ) {
        days.add(EtDatetime(year: year, month: month - 1, day: i));
      }
    }

    // Add current month days
    for (var i = 1; i <= daysInMonth; i++) {
      days.add(EtDatetime(year: year, month: month, day: i));
    }

    // Add trailing days from next month if needed
    final totalCells = days.length > 35 ? 42 : 35; // 6 or 5 weeks
    final emptyCell = totalCells - days.length;
    for (int i = 1; i <= emptyCell; i++) {
      days.add(EtDatetime(year: year, month: month + 1, day: i));
    }

    // Build table rows
    final rows = <TableRow>[];

    // Add day cells
    for (var i = 0; i < days.length; i += 7) {
      final week = days.sublist(i, i + 7);

      rows.add(
        TableRow(children: week.map((date) => _buildDayCell(date)).toList()),
      );
    }

    return rows;
  }

  Widget _buildDayCell(EtDatetime date) {
    final isCurrentMonth = date.month == displayedDate.month;
    final isSelected =
        date.day == selectedDate.day &&
        date.month == selectedDate.month &&
        date.year == selectedDate.year;
    final isToday =
        date.day == EtDatetime.now().day &&
        date.month == EtDatetime.now().month &&
        date.year == EtDatetime.now().year;

    return GestureDetector(
      onTap: () => onDateSelected(date),
      child: Container(
        margin: const EdgeInsets.all(1),
        padding: const EdgeInsets.all(8),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color:
              isSelected
                  ? Colors.blueAccent
                  : isToday
                  ? Colors.blue[200]
                  : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: Center(
          child: Text(
            '${date.day}',
            style: TextStyle(
              color: isCurrentMonth ? Colors.black : Colors.grey,
              fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}

extension on EtDatetime {
  int get days {
    return ETC(year: year, month: month).monthDays().length;
  }
}
