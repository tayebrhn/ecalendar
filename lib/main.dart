import 'package:abushakir/abushakir.dart';
import 'package:eccalendar/calander_grid.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const EthiopianDatePicker(title: 'EthCalender'),
    );
  }
}

class EthiopianDatePicker extends StatefulWidget {
  final title;
  const EthiopianDatePicker({super.key, required this.title});

  @override
  State<EthiopianDatePicker> createState() => _EthiopianDatePickerstate();
}

class _EthiopianDatePickerstate extends State<EthiopianDatePicker> {
  late ETC _selectedDate;
  late ETC _currentMonth;
  late Iterable<List<dynamic>> _calendarDays;

  @override
  void initState() {
    super.initState();
    _selectedDate = ETC.today();
    _currentMonth = _selectedDate;
    _generateCalendarDays();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _generateCalendarDays(){
    _calendarDays = _selectedDate.monthDays(weekDayName: true);
  }

  void _previousMonth(){
    setState(() {
      if(_currentMonth.month>1){
        // _currentMonth = ETC(year: _selectedDate.year,month: _selectedDate.month-1,day: 1);
        _currentMonth = _currentMonth.prevMonth;
      }else{
        _currentMonth = ETC(year: _currentMonth.year-1,month:13,day: 1);
        // _currentMonth = _currentMonth.prevYear;
      }
      _calendarDays = _currentMonth.monthDays(weekDayName: true);
    });
  }

  void _nextMonth(){
    setState(() {
      if(_currentMonth.month<13){
      // _currentMonth = ETC(year: _selectedDate.year,month: _selectedDate.month+1,day: 1);
        _currentMonth = _currentMonth.nextMonth;
      }else{
        _currentMonth = ETC(year: _currentMonth.year+1,month:1,day: 1);
        // _currentMonth = _currentMonth.nextYear;
      }
      _calendarDays = _currentMonth.monthDays(weekDayName: true);
    });
  }
  void _goToToday(){
    setState(() {
      _selectedDate = ETC.today();
      _currentMonth= _selectedDate;
      _calendarDays = _selectedDate.monthDays(weekDayName: true);
    });
  }

  // Future<void> _showDatePicker() async{
  //   final ETC pickedDate = await showDialog<ETC>(context: context, builder: (BuildContext context){
  //     return EthPickerDialog(
  //       initialDate:_selectedDate,
  //       firstDate: ETC(year: _selectedDate.year - 100, month: 1, day: 1),
  //       lastDate: ETC(year: _selectedDate.year + 100, month: 13, day: 6),
  //     );
  //   });
  //
  //   if(pickedDate!=null){
  //     setState(() {
  //       _selectedDate = ETC.today();
  //       _currentMonth= _selectedDate.month;
  //       _currentCalenderDays = _selectedDate.monthDays(weekDayName: true);
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
           IconButton(
            icon: Icon(Icons.today),
            onPressed: _goToToday,
            tooltip: 'Go to Today',
          ),
          // IconButton(
          //   icon: Icon(Icons.calendar_today),
          //   onPressed: _showDatePicker,
          //   tooltip: 'Pick a date',
          // )
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            color: Colors.green.shade50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Today (Ethiopian)',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      EtDatetime.now().toString()
                      ,
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Today (Gregorian)',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      DateTime.now().toString().substring(0, 10),
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Month navigation
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Icon(Icons.chevron_left),
                  onPressed: _previousMonth,
                ),

                // Year input
                // SizedBox(
                //   width: 70,
                //   child: TextField(
                //     controller: _yearController,
                //     decoration: InputDecoration(
                //       labelText: 'Year',
                //       border: OutlineInputBorder(),
                //       contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                //     ),
                //     keyboardType: TextInputType.number,
                //     textAlign: TextAlign.center,
                //   ),
                // ),

                // Month input
                // Container(
                //   width: 70,
                //   child: TextField(
                //     controller: _monthController,
                //     decoration: InputDecoration(
                //       labelText: 'Month',
                //       border: OutlineInputBorder(),
                //       contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                //     ),
                //     keyboardType: TextInputType.number,
                //     textAlign: TextAlign.center,
                //   ),
                // ),

                // ElevatedButton(
                //   onPressed: _updateCalendar,
                //   child: Text('Go'),
                //   style: ElevatedButton.styleFrom(
                //     padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                //   ),
                // ),

                IconButton(
                  icon: Icon(Icons.chevron_right),
                  onPressed: _nextMonth,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Text(
              '${_currentMonth.monthName} ${_currentMonth.year}',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // Day of week headers
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: _getWeekdayHeaders(),
            ),
          ),

          // Calendar grid
          CalendarGrid(monthDays: _calendarDays)
        ],
      ),
    );
  }


  List<Widget> _getWeekdayHeaders() {
    final weekdays = _currentMonth.weekdays;
    return List.generate(7, (index) {
      return Expanded(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 8),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.green.shade100,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            weekdays[index],
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      );
    });
  }
}

