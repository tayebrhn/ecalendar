import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calendar Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CalendarScreen(),
    );
  }
}

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  final PageController _pageController = PageController(initialPage: _initialPage);
  DateTime _currentDate = DateTime.now();
  
  static int get _initialPage => 12 * 5; // Start at a middle page (5 years in future)

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calendar')),
      body: Column(
        children: [
          // Month/year header with navigation
          _buildHeader(),
          
          // Weekday names
          _buildWeekdays(),
          
          // The swipeable calendar with animation
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentDate = DateTime(
                    DateTime.now().year + (index - _initialPage) ~/ 12,
                    DateTime.now().month + (index - _initialPage) % 12,
                    1,
                  );
                });
              },
              itemBuilder: (context, index) {
                final date = DateTime(
                  DateTime.now().year + (index - _initialPage) ~/ 12,
                  DateTime.now().month + (index - _initialPage) % 12,
                  1,
                );
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder: (Widget child, Animation<double> animation) {
                    return SlideTransition(
                      position: Tween<Offset>(
                        begin: Offset(index > _initialPage ? 1.0 : -1.0, 0.0),
                        end: Offset.zero,
                      ).animate(animation),
                      child: child,
                    );
                  },
                  child: KeyedSubtree(
                    key: ValueKey<DateTime>(date),
                    child: MonthTableView(
                      selectedDate: _currentDate,
                      displayedDate: date,
                      onDateSelected: (newDate) {
                        setState(() {
                          _currentDate = newDate;
                          // Jump to the correct page if needed
                          final diff = (newDate.year - DateTime.now().year) * 12 + 
                                      (newDate.month - DateTime.now().month);
                          _pageController.jumpToPage(_initialPage + diff);
                        });
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
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
            onPressed: () => _navigateToMonth(-1),
          ),
          Text(
            DateFormat('MMMM yyyy').format(_currentDate),
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          IconButton(
            icon: const Icon(Icons.chevron_right),
            onPressed: () => _navigateToMonth(1),
          ),
        ],
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

  void _navigateToMonth(int monthsToAdd) {
    final newDate = DateTime(
      _currentDate.year,
      _currentDate.month + monthsToAdd,
      1,
    );
    final diff = (newDate.year - DateTime.now().year) * 12 + 
                (newDate.month - DateTime.now().month);
    _pageController.animateToPage(
      _initialPage + diff,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
}

class MonthTableView extends StatelessWidget {
  final DateTime selectedDate;
  final DateTime displayedDate;
  final ValueChanged<DateTime> onDateSelected;

  const MonthTableView({
    super.key,
    required this.selectedDate,
    required this.displayedDate,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Table(
      children: _buildCalendarRows(),
    );
  }

  List<TableRow> _buildCalendarRows() {
    final year = displayedDate.year;
    final month = displayedDate.month;
    final firstDay = DateTime(year, month, 1);
    final daysInMonth = DateTime(year, month + 1, 0).day;
    
    // Calculate weekday of first day (1 = Monday, 7 = Sunday)
    final firstWeekday = firstDay.weekday;
    
    // Create list of days to display (including leading/trailing days from other months)
    final days = <DateTime>[];
    
    // Add leading days from previous month if needed
    if (firstWeekday != 1) {
      final previousMonth = DateTime(year, month - 1, 1);
      final daysInPreviousMonth = DateTime(year, month, 0).day;
      for (var i = daysInPreviousMonth - (firstWeekday - 2); i <= daysInPreviousMonth; i++) {
        days.add(DateTime(year, month - 1, i));
      }
    }
    
    // Add current month days
    for (var i = 1; i <= daysInMonth; i++) {
      days.add(DateTime(year, month, i));
    }
    
    // Add trailing days from next month if needed
    final totalCells = days.length > 35 ? 42 : 35; // 6 or 5 weeks
    for (var i = 1; days.length < totalCells; i++) {
      days.add(DateTime(year, month + 1, i));
    }
    
    // Build table rows
    final rows = <TableRow>[];
    
    // Add day cells
    for (var i = 0; i < days.length; i += 7) {
      final week = days.sublist(i, i + 7);
      rows.add(TableRow(
        children: week.map((date) => _buildDayCell(date)).toList(),
      ));
    }
    
    return rows;
  }

  Widget _buildDayCell(DateTime date) {
    final isCurrentMonth = date.month == displayedDate.month;
    final isSelected = date.day == selectedDate.day && 
                      date.month == selectedDate.month && 
                      date.year == selectedDate.year;
    final isToday = date.day == DateTime.now().day && 
                   date.month == DateTime.now().month && 
                   date.year == DateTime.now().year;
    
    return GestureDetector(
      onTap: () => onDateSelected(date),
      child: Container(
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: isSelected 
              ? Colors.blue 
              : isToday 
                  ? Colors.blue.withOpacity(0.2) 
                  : Colors.transparent,
          shape: BoxShape.circle,
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