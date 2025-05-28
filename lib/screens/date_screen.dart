
import 'package:abushakir/abushakir.dart';
import 'package:flutter/material.dart';

class EtDateDetails extends StatelessWidget{
  final EtDatetime selectedDate;
  const EtDateDetails({super.key, required this.selectedDate});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            '${selectedDate.monthGeez} ${selectedDate.year}',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
      ),
    );
  }
}