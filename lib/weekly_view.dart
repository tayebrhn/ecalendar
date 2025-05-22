import 'package:abushakir/abushakir.dart';
import 'package:eccalendar/utils/eth_utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EthWeeklyView extends StatefulWidget {
  const EthWeeklyView({super.key});

  @override
  EthWeeklyViewState createState() => EthWeeklyViewState();
}

class EthWeeklyViewState extends State<EthWeeklyView> with EthUtils{
  final PageController _controller = PageController(initialPage: EthUtils.initialPage);
  final EtDatetime _baseDate = EtDatetime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Week View")),
      body: PageView.builder(
        controller: _controller,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final monthOffset = index - EthUtils.initialPage;
          final targetMonth = EtDatetime(
            year: _baseDate.year,
            month: _baseDate.month + monthOffset,
          );
          EtDatetime weekStart = getfirstDayOfWeek(
            targetMonth.add(Duration(days: index * 7)),
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
