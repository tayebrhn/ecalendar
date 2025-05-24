import 'package:abushakir/abushakir.dart';
import 'package:flutter/material.dart';
import './utils/eth_utils.dart';

class MonthlyCalendarView extends StatelessWidget {
  final EtDatetime month;
  const MonthlyCalendarView({super.key, required this.month});

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
    final totalCells = (leadingDays.length + currentDays.length)>35?42:35;
    final trailingNeeded = totalCells - (leadingDays.length + currentDays.length);
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
