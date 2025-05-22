import 'package:abushakir/abushakir.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EthMonthlyView extends StatefulWidget {
  const EthMonthlyView({super.key});

  @override
  EthMonthlyViewState createState() => EthMonthlyViewState();
}

class EthMonthlyViewState extends State<EthMonthlyView> {
  final EtDatetime _baseMonth = EtDatetime.now();
  static const _initialPage = 10000;
  final PageController _controller = PageController(initialPage: _initialPage);

  EtDatetime getfirstDayOfWeek(EtDatetime date) {
    return date.subtract(Duration(days: date.weekday - 1));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Month View")),
      body: PageView.builder(
        controller: _controller,
        scrollDirection: Axis.horizontal,
        dragStartBehavior: DragStartBehavior.down,
        pageSnapping: true,
        scrollBehavior: ScrollBehavior(),
        itemBuilder: (context, index) {
          final monthOffset = index - _initialPage;
          final targetMonth = EtDatetime(
            year: _baseMonth.year,
            month: _baseMonth.month + monthOffset,
          );
          return MonthlyCalendarView(today: _baseMonth, month: targetMonth);
        },
      ),
    );
  }
}

class MonthlyCalendarView extends StatelessWidget {
  final EtDatetime month;
  final EtDatetime today;
  const MonthlyCalendarView({
    super.key,
    required this.month,
    required this.today,
  });

  List<_DayCell> _generateMonthDays(EtDatetime month) {
    final firstDay = EtDatetime(year: month.year, month: month.month, day: 1);
    final startWeekDay = firstDay.weekday % 7;
    final totalDays =
        ETC(year: month.year, month: month.month).monthDays().length;

    //prev month
    final prevMonth = EtDatetime(year: month.year, month: month.month - 1);
    final prevMonthDays =
        ETC(year: prevMonth.year, month: prevMonth.month).monthDays().length+1;
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

    print("DATES:$totalDays MONTH:${month.month}");

    // Next month
    final trailingNeeded = 42 - (leadingDays.length + currentDays.length);
    final nextMonth = EtDatetime(year: month.year, month: month.month + 1);
    final trailingDays = [
      for (int d = 1; d <= trailingNeeded; d++)
        _DayCell(
          date: EtDatetime(year: nextMonth.year, month: nextMonth.month, day: d),
          isCurrentMonth: false,
        ),
    ];

    return [...leadingDays, ...currentDays, ...trailingDays];
  }

  @override
  Widget build(BuildContext context) {
    final days = _generateMonthDays(month);
    final weekdayLabels = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

    return Column(
      children: [
        SizedBox(height: 16),
        Text(
          '${month.monthGeez} ${month.year}',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),

        // Weekday headers
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children:
                weekdayLabels
                    .map(
                      (day) => Expanded(
                        child: Center(
                          child: Text(
                            day,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.grey[700],
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
          ),
        ),

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
              final isToday =
                  cell.date.year == today.year &&
                  cell.date.month == today.month &&
                  cell.date.day == today.day;

              return Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color:
                      isToday
                          ? Colors.blue[200]
                          : cell.isCurrentMonth
                          ? null
                          : Colors.grey[200]!,
                  border: Border.all(color: Colors.grey[300]!),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  '${cell.date.day}',
                  style: TextStyle(
                    color: cell.isCurrentMonth ? Colors.black : Colors.grey,
                    fontWeight:
                        cell.isCurrentMonth
                            ? FontWeight.normal
                            : FontWeight.w400,
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
