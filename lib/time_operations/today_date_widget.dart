import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TodayDateWidget extends StatefulWidget {
  const TodayDateWidget({super.key});

  @override
  State<TodayDateWidget> createState() => _TodayDateWidgetState();
}

class _TodayDateWidgetState extends State<TodayDateWidget> {
  late DateTime now;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    now = DateTime.now();
    _startAutoUpdate();
  }

  void _startAutoUpdate() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        now = DateTime.now();
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final formatter = DateFormat('dd-MM-yyyy HH:mm:ss');
    final before = now.subtract(const Duration(hours: 9, minutes: 30));
    final after = now.add(const Duration(hours: 9, minutes: 30));

    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "1. Today's Date and Time:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),
              Text(
                'Current: ${formatter.format(now)}',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 6),
              Text(
                '9.5 hrs Before: ${formatter.format(before)}',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 6),
              Text(
                '9.5 hrs After: ${formatter.format(after)}',
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
