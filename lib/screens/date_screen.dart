import 'package:abushakir/abushakir.dart';
import 'package:ecalendar/state/state_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EtDateScreen extends StatelessWidget {
  final EtDatetime selectedDate;
  const EtDateScreen({super.key, required this.selectedDate});

  @override
  Widget build(BuildContext context) {
    final CalEventProvider calEventNotifier = Provider.of<CalEventProvider>(
      context,
      listen: false,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${selectedDate.monthGeez} ${selectedDate.year}',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Card(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(padding: const EdgeInsets.all(5),child: Icon(Icons.event,size: 35,)),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          calEventNotifier.bealEvent.beal,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${calEventNotifier.bealEvent.month} '
                          ' ${calEventNotifier.bealEvent.date}',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
