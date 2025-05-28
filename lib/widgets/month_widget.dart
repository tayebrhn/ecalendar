import 'package:abushakir/abushakir.dart';
import 'package:eccalendar/screens/date_screen.dart';
import 'package:eccalendar/state/state_manager.dart';
import 'package:eccalendar/utils/eth_utils.dart';
import 'package:eccalendar/utils/themedata_extension.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MonthlyCalendarView extends StatefulWidget {
  final EtDatetime month;

  const MonthlyCalendarView({super.key, required this.month});

  @override
  State<MonthlyCalendarView> createState() => _MonthlyCalendarViewState();
}

class _MonthlyCalendarViewState extends State<MonthlyCalendarView> {
  late List<_DayCell> genDays;
  late CalendarThemeData calendarTheme;
  late ColorScheme colorScheme;

  late DateChangeNotifier selectedNotifier;
  late CalEventProvider calEventNotifier;

  @override
  void initState() {
    super.initState();
    genDays = _generateMonthDays(widget.month);
  }

  @override
  void didUpdateWidget(covariant MonthlyCalendarView oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.month != widget.month) {
      genDays = _generateMonthDays(widget.month);
    }
  }

  @override
  void didChangeDependencies() {
    calendarTheme = Theme.of(context).extension<CalendarThemeData>()!;
    colorScheme = Theme.of(context).colorScheme;
    selectedNotifier = Provider.of<DateChangeNotifier>(context, listen: true);
    calEventNotifier = Provider.of<CalEventProvider>(context, listen: false);

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
        //not advisable to dispose provider objects
    // selectedNotifier.dispose();
    // calEventNotifier.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.symmetric(),
      children: _buildCalendarRows(),
    );
  }

  List<TableRow> _buildCalendarRows() {
    // Create list of days to display (including leading/trailing days from other months)
    // final List<_DayCell> genDays = _generateMonthgenDays(widget.month);
    // Build table rows
    final rows = <TableRow>[];

    // Add day cells
    for (var i = 0; i < genDays.length; i += 7) {
      final week = genDays.sublist(i, i + 7);

      rows.add(
        TableRow(children: week.map((date) => _buildDayCell(date)).toList()),
      );
    }

    return rows;
  }

  Widget _buildDayCell(_DayCell cellDate) {
    final EtDatetime today = EtDatetime.now();
    final isToday = EthUtils.isSameDay(cellDate.date, today);
    final isSelected = EthUtils.isSameDay(
      cellDate.date,
      selectedNotifier.selectedDate,
    );
    return GestureDetector(
      onTap: () {
        selectedNotifier.selectedDate = cellDate.date;
        calEventNotifier.bealEvent = cellDate.bealEvent;
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
        padding: const EdgeInsets.all(2),
        height: 55,
        width: 65,
        decoration: BoxDecoration(
          border: Border.all(
            color:
                isSelected ? calendarTheme.selectedDayColor : Color(0x00000000),
          ),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Container(
              alignment: Alignment.center,
              // margin: const EdgeInsets.only(top: 2),
              decoration: BoxDecoration(
                color: isToday ? Colors.cyan : null,
                borderRadius: BorderRadius.circular(6),
              ),
              width: 25,
              child: Text(
                '${cellDate.date.day}',
                style: TextStyle(
                  color:
                      cellDate.isCurrentMonth
                          ? isToday
                              ? Colors.white
                              : colorScheme.primary
                          : Colors.grey,
                  fontWeight:
                      cellDate.isCurrentMonth
                          ? FontWeight.w400
                          : FontWeight.w300,
                  fontSize: 16.5,
                ),
              ),
            ),

            Container(
              alignment: Alignment.bottomRight,
              margin: const EdgeInsets.only(top: 0),
              // width: 6,
              // height: 6,
              child: Text(
                DateTime.fromMillisecondsSinceEpoch(
                  cellDate.date.moment,
                ).day.toString(),
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
            ),
            cellDate.hasEvents
                ? Container(
                  alignment: Alignment.bottomLeft,
                  // margin: const EdgeInsets.only(top: 2),
                  width: 50,
                  height: 2,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.blue,
                  ),
                )
                : Container(
                  alignment: Alignment.bottomLeft,
                  margin: const EdgeInsets.only(top: 2),
                  width: 50,
                  height: 2,
                ),
          ],
        ),
      ),
    );
  }

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
    final trailingNeeded =
        EthUtils.dayGrid - (leadingDays.length + currentDays.length);
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

List loadEvents(List<_DayCell> dayCells) {
  return dayCells.map((element) {
    return EthUtils.dayEvent(element.date);
  }).toList();
}

class _DayCell {
  final EtDatetime date;
  final bool isCurrentMonth;
  _DayCell({required this.date, required this.isCurrentMonth});
  bool get hasEvents {
    return EthUtils.dayEvent(date).isNotEmpty;
  }

  BealEvent get bealEvent {
    return BealEvent.fromJson(EthUtils.dayEvent(date).toList());
  }
}

// extension on EtDatetime {
//   int get days {
//     return ETC(year: year, month: month).monthDays().length;
//   }
// }
