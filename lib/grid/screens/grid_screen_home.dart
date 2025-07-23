import 'package:flutter/material.dart';
import 'package:flutter_mobigic/grid/screens/grid_calendar_input_form.dart';

class CalenderGridAppRoot extends StatelessWidget {
  const CalenderGridAppRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Calendar Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const CalendarInputForm(),
    );
  }
}
