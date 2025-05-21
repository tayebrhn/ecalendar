import 'package:abushakir/abushakir.dart';
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
  late int _currentMonth;
  late Iterable<List<dynamic>> _currentCalenderDays;

  @override
  void initState() {
    super.initState();
    _selectedDate = ETC.today();
    _currentMonth = _selectedDate.month;
    _currentCalenderDays = _selectedDate.monthDays(weekDayName: true);
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _previousMonth(){
    setState(() {
      _currentMonth=_selectedDate.prevMonth.month;
    });
  }
  void _nextMonth(){
    setState(() {
      _currentMonth=_selectedDate.nextMonth.month;
    });
  }
  void _goToToday(){
    setState(() {
      _selectedDate = ETC.today();
      _currentMonth= _selectedDate.month;
      _currentCalenderDays = _selectedDate.monthDays(weekDayName: true);
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
        ],
      ),
    );
  }
}

