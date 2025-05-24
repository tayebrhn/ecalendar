import 'package:abushakir/abushakir.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import './utils/eth_utils.dart';

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
            onPressed: () {
              setState(() {
                var newDate = EtDatetime.now();
                _currentDate = newDate;
                // Jump to the correct page if needed
                final diff =
                    (newDate.year - EtDatetime.now().year) * 12 +
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

          Expanded(child: _buildGrid()),
        ],
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
        return KeyedSubtree(
          key: ValueKey<EtDatetime>(date),
          child: MonthTableView(
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
          return MonthlyCalendarView(month: _currentDate,);
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

class MonthlyCalendarView extends StatefulWidget {
  EtDatetime month;
  EtDatetime? selectedDate;

  MonthlyCalendarView({super.key, required this.month, this.selectedDate});

  @override
  State<MonthlyCalendarView> createState() => _MonthlyCalendarViewState();
}

class _MonthlyCalendarViewState extends State<MonthlyCalendarView> {
  List<_DayCell> _generateMonthDays(EtDatetime month) {
    final firstDay = EtDatetime(year: month.year, month: month.month);
    final startWeekDay = firstDay.weekday % 7;
    final totalDays =
        ETC(year: month.year, month: month.month).monthDays().length;

    //prev month
    final prevMonth = EtDatetime(year: month.year, month: month.month - 1);
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
    print((leadingDays.length + currentDays.length));

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

  @override
  Widget build(BuildContext context) {
    final EtDatetime month = widget.month;
    EtDatetime? selectedDate = widget.selectedDate;
    final days = _generateMonthDays(month);
    final EtDatetime today = EtDatetime.now();

    return Column(
      children: [
        SizedBox(height: 16),

        SizedBox(height: 4),

        // Full 6-row grid
        Expanded(
          child: GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(4),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
            ),
            itemCount: days.length,
            itemBuilder: (context, index) {
              final cell = days[index];
              final isToday = EthUtils.isSameDay(cell.date, today);
              final isSelected =
                  selectedDate != null &&
                  EthUtils.isSameDay(cell.date, selectedDate!);

              return GestureDetector(
                onTap: () {
                  setState(() {
                    widget.selectedDate = cell.date;
                    print("SELECTEDDATE:${selectedDate}");
                    print("SELECTEDWIDGET.DATE:${widget.selectedDate}");
                  });
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color:
                        isSelected
                            ? Colors.blueAccent.withOpacity(0.6)
                            : isToday
                            ? Colors.blue[200]
                            : cell.isCurrentMonth
                            ? null
                            : Colors.grey[200],
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    '${cell.date.day}',
                    style: TextStyle(
                      color: cell.isCurrentMonth ? Colors.black : Colors.grey,
                      fontWeight:
                          isSelected || isToday
                              ? FontWeight.bold
                              : FontWeight.normal,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
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
