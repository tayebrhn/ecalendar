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
      //todo
      body: Text("Todo"),
    );
  }
}
