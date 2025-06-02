import 'package:abushakir/abushakir.dart';
import '../screens/date_screen.dart';
import '../state/state_manager.dart';
import '../utils/eth_utils.dart';
import '../utils/themedata_extension.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MonthlyWidget extends StatefulWidget {
  final EtDatetime date;
  final void Function(EtDatetime date) onDateChanged;

  const MonthlyWidget({
    super.key,
    required this.date,
    required this.onDateChanged,
  });

  @override
  State<MonthlyWidget> createState() => _MonthlyWidgetState();
}

class _MonthlyWidgetState extends State<MonthlyWidget> {
  List<EtDatetime>? dayCells;
  final Map<int, List<EtDatetime>> _monthCache = {};
  int _currentMonth = DateTime.now().month;

  @override
  void initState() {
    super.initState();
    computeMonthDays();
  }
@override
  void didUpdateWidget(covariant MonthlyWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.date != widget.date) {
      computeMonthDays();
    }
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
    //not advisable to dispose provider objects
    // dateChangeNotifier.dispose();
    // calEventNotifier.dispose();
  }

  Future<void> computeMonthDays() async {
    final List<EtDatetime> futureCell = await compute(
      generateMonthDaysNew,
      widget.date,
    );
    setState(() {
      dayCells = futureCell;
    });
  }

  @override
  Widget build(BuildContext context) {
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   widget.onDateChanged(widget.date);
    // });
    if (dayCells == null) {
      return Center(child: CircularProgressIndicator());
    }
    // final CalendarThemeData calendarTheme =
    //     Theme.of(context).extension<CalendarThemeData>()!;
    // final ColorScheme colorScheme = Theme.of(context).colorScheme;
    // DateChangeNotifier dateChangeNotifier = Provider.of<DateChangeNotifier>(
    //   context,
    //   listen: true,
    // );
    // CalEventProvider calEventNotifier = Provider.of<CalEventProvider>(
    //   context,
    //   listen: false,
    // );
    return Table(children: _buildCalendarRows());
  }

  List<TableRow> _buildCalendarRows() {
    // Create list of days to display (including leading/trailing days from other months)
    // final List<DayCell> dayCells! = _generateMonthdayCells(widget.month);
    // Build table rows
    final rows = <TableRow>[];

    // Add day cells
    for (var i = 0; i < dayCells!.length; i += 7) {
      final week = dayCells!.sublist(i, i + 7);

      rows.add(
        TableRow(children: week.map((date) => _buildDayCell(date)).toList()),
      );
    }

    return rows;
  }

  Widget _buildDayCell(EtDatetime cellDate) {
    final CalendarThemeData calendarTheme =
        Theme.of(context).extension<CalendarThemeData>()!;
    // final ColorScheme colorScheme = Theme.of(context).colorScheme;
    DateChangeNotifier dateChangeNotifier = Provider.of<DateChangeNotifier>(
      context,
      listen: true,
    );
    CalEventProvider calEventNotifier = Provider.of<CalEventProvider>(
      context,
      listen: false,
    );

    final EtDatetime today = EtDatetime.now();
    final isToday = isSameDay(cellDate, today);
    final isSelected = isSameDay(cellDate, dateChangeNotifier.selectedDate);
    final isCurrentMonth = currentMonth(cellDate, widget.date);
    return GestureDetector(
      onTap: () {
        dateChangeNotifier.selectedDate = cellDate;
        calEventNotifier.bealEvent = bealEvent(cellDate);
        if (isSelected) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EtDateDetails(selectedDate: cellDate),
            ),
          );
        }
      },
      child: Container(
        height: 85,
        alignment: Alignment.center,
        margin: const EdgeInsets.all(1),
        padding: const EdgeInsets.all(2),
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
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                '${cellDate.day}',
                style: TextStyle(
                  color:
                      isCurrentMonth
                          ? isToday
                              ? Colors.white
                              : Colors.lightBlueAccent
                          : Colors.grey,
                  fontWeight:
                      isCurrentMonth ? FontWeight.w500 : FontWeight.w300,
                  fontSize: isCurrentMonth ? 18 : 17,
                ),
              ),
            ),
            Text(
              DateTime.fromMillisecondsSinceEpoch(
                cellDate.moment,
              ).day.toString(),
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
            hasEvents(cellDate)
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
}
