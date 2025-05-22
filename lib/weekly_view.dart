import 'package:abushakir/abushakir.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EthWeeklyView extends StatefulWidget {
  const EthWeeklyView({super.key});

  @override
  EthWeeklyViewState createState() => EthWeeklyViewState();
}

class EthWeeklyViewState extends State<EthWeeklyView> {
  final PageController _controller = PageController(initialPage: 0);
  final EtDatetime _baseDate = EtDatetime.now();
  final List weekDayNames = ETC.today().weekdays;

  EtDatetime getfirstDayOfWeek(EtDatetime date) {
    return date.subtract(Duration(days: date.weekday - 1));
  }

  List<EtDatetime> getWeekDates(EtDatetime startOfWeek) {
    return List.generate(7, (index) => startOfWeek.add(Duration(days: index)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Week View(Moth view) Calendar")),
      body: PageView.builder(
        controller: _controller,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          EtDatetime weekStart = getfirstDayOfWeek(
            _baseDate.add(Duration(days: index * 7)),
          );

          List<EtDatetime> weekDays = getWeekDates(weekStart);

          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children:
                  weekDays.map((day) {
                    final ethNow = EtDatetime.now();
                    bool isToday =
                        ethNow.day == day.day &&
                        ethNow.year == day.year &&
                        ethNow.month == day.month;
                    return Container(
                      width: 48,
                      decoration: BoxDecoration(
                        color: isToday ? Colors.redAccent : Colors.blueAccent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        children: [
                          Text(
                            DateFormat.E().format(
                              DateTime.fromMillisecondsSinceEpoch(day.moment),
                            ),
                            style: TextStyle(color: Colors.white70),
                          ),
                          SizedBox(height: 5),
                          Text(
                            day.day.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.white60,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
            ),
          );
        },
      ),
    );
  }
}
