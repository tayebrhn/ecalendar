import 'package:abushakir/abushakir.dart';
import 'package:ecalendar/l10n/app_localizations.dart';
import '../widgets/vertical_date_picker.dart';
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
                  AppLocalizations.of(context)!.toGregorian,
                  style: TextStyle(color: Colors.grey[500], fontSize: 12),
                ),
                SizedBox(height: 20),
                Text(
                  DateFormat.yMEd().add_MMM().format(
                    DateTime.fromMillisecondsSinceEpoch(_selectedDate.moment),
                  ),
                  style: TextStyle(fontSize: 16),
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
            firstDate: EtDatetime(year: 1780),
            lastDate: EtDatetime(year: 2200),
          ),
        ),
      ],
    );
  }
}
