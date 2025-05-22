import 'package:abushakir/abushakir.dart';
import 'package:eccalendar/calander_grid.dart';
import 'package:eccalendar/month_view.dart';
import 'package:eccalendar/weekly_view.dart';
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
      home: const EthWeeklyView(),
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
  late List<List<dynamic>> monthData;
  late Iterable<List<dynamic>> _calendarDays;

  @override
  void initState() {
    super.initState();
    _selectedDate = ETC.today();
    _currentMonth = _selectedDate;
    _generateMonthData();
  }

  @override
  void dispose() {
    super.dispose();
  }


  void _generateMonthData() {
    // Create a complete month grid with all days
    _calendarDays = _currentMonth.monthDays();
    monthData = [];

    // Find the first day of the month from our data
    int firstDayIndex = _calendarDays.toList()[0][3];
    if (firstDayIndex == -1) firstDayIndex = 4; // Default to Friday if not found

    // Calculate days in the month (Ethiopian months have 30 days except Pagume)
    int daysInMonth = _currentMonth.dayNumbers.length;

    // Add empty cells for days before the 1st of the month
    List<List<dynamic>> completeMonth = [];
    for (int i = 0; i < firstDayIndex; i++) {
      completeMonth.add([_currentMonth.year, _currentMonth.month, 0, ""]);
    }

    // Add all days of the month
    for (int day = 1; day <= daysInMonth; day++) {
      // Find the weekday for this date if it exists in our data

      String weekday = "";
      for (var date in _calendarDays) {
        if (date[2] == day) {
          weekday = _currentMonth.weekdays[date[3]];
          break;
        }
      }

      // // If we don't have the weekday in our data, calculate it
      // if (weekday.isEmpty) {
      //   // Simple formula to calculate weekday from first day
      //   int dayIndex = (firstDayIndex + day - 1) % 7;
      //   weekday = ethiopianWeekdays[dayIndex];
      // }

      completeMonth.add([_currentMonth.year, _currentMonth.month, day, weekday]);
    }

    // Fill remaining cells to complete the grid (if needed)
    while (completeMonth.length % 7 != 0) {
      completeMonth.add([_currentMonth.year, _currentMonth.month, 0, ""]);
    }

    monthData = completeMonth;
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
      _generateMonthData();
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
      _generateMonthData();    });
  }
  void _goToToday(){
    setState(() {
      _selectedDate = ETC.today();
      _currentMonth= _selectedDate;
      _generateMonthData();
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

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: ETC(year: 2017).weekdays.map((day) => Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  alignment: Alignment.center,
                  child: Text(
                    day,
                    style: const TextStyle(fontWeight: FontWeight.bold,overflow: TextOverflow.visible),
                  ),
                ),
              )).toList(),
            ),
          ),

          // Calendar grid
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(8.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
                childAspectRatio: 1.0,
              ),
              itemCount: monthData.length,
              itemBuilder: (context, index) {
                final date = monthData[index];
                final day = date[2];

                // Check if this is a date in our original data
                bool isHighlighted = _calendarDays.any((d) =>
                d[0] == date[0] && d[1] == date[1] && d[2] == date[2]);

                return Container(
                  margin: const EdgeInsets.all(2.0),
                  decoration: BoxDecoration(
                    color: isHighlighted ? Colors.lightBlue.withOpacity(0.2) : Colors.transparent,
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: day > 0 ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          day.toString(),
                          style: TextStyle(
                            fontWeight: isHighlighted ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                        if (isHighlighted)
                          Text(
                            date[3],
                            style: const TextStyle(fontSize: 10),
                          ),
                      ],
                    ),
                  ) : null,
                );
              },
            ),
          ),

          // Legend for highlighted dates
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    color: Colors.lightBlue.withOpacity(0.2),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                ),
                const SizedBox(width: 8),
                const Text('Dates from provided data'),
              ],
            ),
          ),
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

