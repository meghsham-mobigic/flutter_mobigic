import 'package:flutter/material.dart';
import 'package:flutter_mobigic/time_operations/birthdate_widget.dart';
import 'package:flutter_mobigic/time_operations/today_date_widget.dart';


class DateAndTimeAppRoot extends StatelessWidget {
  const DateAndTimeAppRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Date & Time Tasks'), centerTitle: true),
      body: const Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [TodayDateWidget(), BirthdateWidget()],
        ),
      ),
    );
  }
}
