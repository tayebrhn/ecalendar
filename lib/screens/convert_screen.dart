import 'package:abushakir/abushakir.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ConvertScreen extends StatefulWidget {
  const ConvertScreen({super.key});

  @override
  State<ConvertScreen> createState() {
    return _ConvertScreenState();
  }
}

class _ConvertScreenState extends State<ConvertScreen> {
    EtDatetime _selectedDate = EtDatetime.now();

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Text(
          //   'Selected Date: ${DateFormat('MMMM d, yyyy').format(_selectedDate)}',
          //   style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          // ),
          const SizedBox(height: 20),
          Expanded(
            child: VerticalDatePicker(
              onDateChange: (date) {
                setState(() {
                  _selectedDate = date;
                });
              },
              initialDate: _selectedDate,
              firstDate: EtDatetime(year:1980),
              lastDate: EtDatetime(year:2100),
            ),
          ),
        ],
      );
  }
}

class VerticalDatePicker extends StatefulWidget {
  final ValueChanged<EtDatetime> onDateChange;
  final EtDatetime initialDate;
  final EtDatetime firstDate;
  final EtDatetime lastDate;

  const VerticalDatePicker({
    super.key,
    required this.onDateChange,
    required this.initialDate,
    required this.firstDate,
    required this.lastDate,
  });
  @override
  State<VerticalDatePicker> createState() {
    return _VerticalDatePickerState();
  }
}

class _VerticalDatePickerState extends State<VerticalDatePicker> {
  late FixedExtentScrollController _dayController;
  late FixedExtentScrollController _monthController;
  late FixedExtentScrollController _yearController;
  late EtDatetime _selectedDate;
  late List<int> _years;
  late List<int> _months;
  late List<int> _days;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate;
    _years = List<int>.generate(
      widget.lastDate.year - widget.firstDate.year + 1,
      (index) => widget.firstDate.year + index,
    );

    _months = List<int>.generate(13, (index) => index + 1);

    _updateDays();

    _yearController = FixedExtentScrollController(
      initialItem: _years.indexOf(_selectedDate.year),
    );
    _monthController = FixedExtentScrollController(
      initialItem: _selectedDate.month - 1,
    );
    _dayController = FixedExtentScrollController(
      initialItem: _selectedDate.day - 1,
    );
  }

  @override
  void dispose() {
    _dayController.dispose();
    _monthController.dispose();
    _yearController.dispose();
    super.dispose();
  }

  void _updateDays() {
    _days = List<int>.generate(
      _getDaysInMonth(_selectedDate.year, _selectedDate.month),
      (index) => index + 1,
    );
  }

  int _getDaysInMonth(int year, int month) {
    return EtDatetime(year: year, month: month + 1, day: 0).day;
  }

  void _onDateChanged() {
    try {
      final newDate = EtDatetime(
        year: _years[_yearController.selectedItem],
        month: _months[_monthController.selectedItem],
        day:
            _dayController.selectedItem + 1 <= _days.length
                ? _dayController.selectedItem + 1
                : _days.length,
      );

      if (newDate.isBefore(widget.firstDate) ||
          newDate.isAfter(widget.lastDate)) {
        return;
      }

      setState(() {
        _selectedDate = newDate;
        _updateDays();
      });

      widget.onDateChange(_selectedDate);
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Year picker
        Expanded(
          child: Container(
            height: 250,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListWheelScrollView.useDelegate(
              controller: _yearController,
              itemExtent: 50,
              perspective: 0.005,
              diameterRatio: 1.5,
              physics: const FixedExtentScrollPhysics(),
              onSelectedItemChanged: (index) {
                _onDateChanged();
              },
              childDelegate: ListWheelChildBuilderDelegate(
                builder: (context, index) {
                  if (index < 0 || index >= _years.length) {
                    return null;
                  }
                  return _buildDateItem(_years[index].toString());
                },
                childCount: _years.length,
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        // Month picker
        Expanded(
          child: Container(
            height: 250,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListWheelScrollView.useDelegate(
              controller: _monthController,
              itemExtent: 50,
              perspective: 0.005,
              diameterRatio: 1.5,
              physics: const FixedExtentScrollPhysics(),
              onSelectedItemChanged: (index) {
                _onDateChanged();
              },
              childDelegate: ListWheelChildBuilderDelegate(
                builder: (context, index) {
                  if (index < 0 || index >= _months.length) {
                    return null;
                  }
                  return _buildDateItem(DateFormat('MMM').format(DateTime(2022, index + 1)));
                },
                childCount: _months.length,
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        // Day picker
        Expanded(
          child: Container(
            height: 250,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListWheelScrollView.useDelegate(
              controller: _dayController,
              itemExtent: 50,
              perspective: 0.005,
              diameterRatio: 1.5,
              physics: const FixedExtentScrollPhysics(),
              onSelectedItemChanged: (index) {
                _onDateChanged();
              },
              childDelegate: ListWheelChildBuilderDelegate(
                builder: (context, index) {
                  if (index < 0 || index >= _days.length) {
                    return null;
                  }
                  return _buildDateItem(_days[index].toString());
                },
                childCount: _days.length,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDateItem(String text) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5),
        alignment: Alignment.center,
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
