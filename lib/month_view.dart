import 'package:abushakir/abushakir.dart';
import 'package:flutter/material.dart';

class MonthlyCalendarView extends StatelessWidget {
  final EtDatetime month;
  const MonthlyCalendarView({
    super.key,
    required this.month,
  });

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
    final trailingNeeded = 42 - (leadingDays.length + currentDays.length);
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
