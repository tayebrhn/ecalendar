import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InfiniteCalendarWidget extends StatefulWidget {
  final Function(DateTime)? onRangeSelected;
  final Future<List<String>> Function(DateTime month)? loadEventsForMonth;

  InfiniteCalendarWidget({this.onRangeSelected, this.loadEventsForMonth});

  @override
  _InfiniteCalendarWidgetState createState() => _InfiniteCalendarWidgetState();
}

class _InfiniteCalendarWidgetState extends State<InfiniteCalendarWidget> {
  final PageController _pageController = PageController(initialPage: 0);
  final DateTime _baseDate = DateTime(2025, 1);
  final Map<int, ScrollController> _scrollControllers = {};
  final Map<String, List<String>> _monthEvents = {};
  final Set<String> _loadedMonths = {};

  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  DateTime _getMonthForIndex(int index) =>
      DateTime(_baseDate.year, _baseDate.month + index);
  String _formatKey(DateTime date) => "${date.year}-${date.month}";

  ScrollController _getScrollController(int index) {
    return _scrollControllers.putIfAbsent(index, () => ScrollController());
  }

  void _onPageChanged(int index) async {
    DateTime month = _getMonthForIndex(index);
    String key = _formatKey(month);
    if (!_loadedMonths.contains(key) && widget.loadEventsForMonth != null) {
      List<String> events = await widget.loadEventsForMonth!(month);
      setState(() {
        _monthEvents[key] = events;
        _loadedMonths.add(key);
      });
    }
  }

  void _onDayTapped(DateTime day) {
    setState(() {
      if (_rangeStart == null || (_rangeStart != null && _rangeEnd != null)) {
        _rangeStart = day;
        _rangeEnd = null;
      } else if (_rangeStart != null && _rangeEnd == null) {
        _rangeEnd = day.isBefore(_rangeStart!) ? _rangeStart : day;
        _rangeStart = day.isBefore(_rangeStart!) ? day : _rangeStart;
        widget.onRangeSelected?.call(day);
      }
    });
  }

  bool _isInRange(DateTime date) {
    if (_rangeStart != null && _rangeEnd != null) {
      return (date.isAfter(_rangeStart!) && date.isBefore(_rangeEnd!)) ||
          date == _rangeStart ||
          date == _rangeEnd;
    }
    return false;
  }

  List<Widget> _buildMonthGrid(DateTime month) {
    final firstDay = DateTime(month.year, month.month, 1);
    final totalDays = DateUtils.getDaysInMonth(month.year, month.month);
    final startingWeekday = firstDay.weekday % 7;
    final List<Widget> dayWidgets = [];

    for (int i = 0; i < startingWeekday; i++) {
      dayWidgets.add(Container());
    }

    for (int i = 1; i <= totalDays; i++) {
      final date = DateTime(month.year, month.month, i);
      final isSelected = _isInRange(date);

      dayWidgets.add(
        GestureDetector(
          onTap: () => _onDayTapped(date),
          child: Container(
            margin: EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: isSelected ? Colors.orange : Colors.blue.shade300,
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: Alignment.center,
            child: Text("$i", style: TextStyle(color: Colors.white)),
          ),
        ),
      );
    }

    return dayWidgets;
  }

  @override
  void dispose() {
    _pageController.dispose();
    for (final controller in _scrollControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      scrollDirection: Axis.horizontal,
      onPageChanged: _onPageChanged,
      itemBuilder: (context, index) {
        DateTime month = _getMonthForIndex(index);
        ScrollController controller = _getScrollController(index);

        return Column(
          children: [
            SizedBox(height: 16),
            Text(
              DateFormat.yMMMM().format(month),
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: GridView.count(
                controller: controller,
                crossAxisCount: 7,
                children: _buildMonthGrid(month),
              ),
            ),
          ],
        );
      },
    );
  }
}
