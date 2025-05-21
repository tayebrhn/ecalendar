import 'package:flutter/material.dart';

class CalendarGrid extends StatelessWidget {
  final Iterable<List<dynamic>> monthDays;

  const CalendarGrid({Key? key, required this.monthDays}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Convert the iterable to a list for easier processing
    final daysList = monthDays.toList();

    // Find the first day's weekday (0=Sunday, 6=Saturday in Ethiopian calendar)
    final firstDay = daysList.first;
    final firstWeekday = getWeekdayIndex(firstDay[3].toString());

    // Create a list with leading empty days if month doesn't start on Sunday
    final allDays = <List<dynamic>?>[];
    for (var i = 0; i < firstWeekday; i++) {
      allDays.add(null); // Add empty days before the 1st
    }
    allDays.addAll(daysList);

    // Group into weeks (7 days each)
    final weeks = <List<List<dynamic>?>>[];
    for (var i = 0; i < allDays.length; i += 7) {
      final end = (i + 7 < allDays.length) ? i + 7 : allDays.length;
      var week = allDays.sublist(i, end);
      // Ensure each week has 7 days
      while (week.length < 7) {
        week.add(null);
      }
      weeks.add(week);
    }

    return Table(
      border: TableBorder.all(),
      children: [
        // Header row with day names
        const TableRow(
          decoration: BoxDecoration(color: Colors.grey),
          children: [
            TableCell(child: Center(child: Text('እሁድ'))), // Sunday
            TableCell(child: Center(child: Text('ሰኞ'))),   // Monday
            TableCell(child: Center(child: Text('ማክሰኞ'))), // Tuesday
            TableCell(child: Center(child: Text('ረቡዕ'))), // Wednesday
            TableCell(child: Center(child: Text('ሐሙስ'))), // Thursday
            TableCell(child: Center(child: Text('አርብ'))),  // Friday
            TableCell(child: Center(child: Text('ቅዳሜ'))), // Saturday
          ],
        ),
        // Add each week as a row
        ...weeks.map((week) {
          return TableRow(
            children: week.map((day) {
              return TableCell(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  height: 50,
                  child: day == null
                      ? const SizedBox.shrink() // Empty cell
                      : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(day[2].toString()), // Day number
                    ],
                  ),
                ),
              );
            }).toList(),
          );
        }),
      ],
    );
  }

  // Helper function to get weekday index (0=Sunday, 6=Saturday)
  int getWeekdayIndex(String weekday) {
    const weekdays = ['እሁድ', 'ሰኞ', 'ማክሰኞ', 'ረቡዕ', 'ሐሙስ', 'አርብ', 'ቅዳሜ'];
    return weekdays.indexOf(weekday);
  }
}