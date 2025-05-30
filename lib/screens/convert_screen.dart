import 'package:abushakir/abushakir.dart';
import 'package:eccalendar/widgets/vertical_date_picker.dart';
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
          SizedBox(height: 20),
          Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(
                    'App Version: 1.0.0',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 10),
                  Text(
"Todo",                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  SizedBox(height: 20),
                  Text(
                    '© 2024 Flutter Calendar Demo App',
                    style: TextStyle(color: Colors.grey[500], fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: VerticalDatePicker(
              onDateChange: (date) {
                setState(() {
                  _selectedDate = date;
                });
              },
              initialDate: _selectedDate,
              firstDate: EtDatetime(year:1780),
              lastDate: EtDatetime(year:2200),
            ),
          ),
        ],
      );
  }
}

