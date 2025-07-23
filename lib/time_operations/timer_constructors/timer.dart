import 'dart:async';

import 'package:flutter/material.dart';

class TimerImplementation extends StatefulWidget {
  const TimerImplementation({super.key});

  @override
  State<TimerImplementation> createState() => _TimerImplementationState();
}

class _TimerImplementationState extends State<TimerImplementation> {
  final timerDurationInputSeconds = TextEditingController();
  bool isClicked = false;
  bool isMessageVisible = false;
  int secondsElapsed = 0;
  int timerDuration = 0;
  Timer? periodicTimer;

  void startCounterWithTimer() {
    FocusScope.of(context).unfocus(); // dismiss keyboard

    final input = timerDurationInputSeconds.text.trim();
    final parsed = int.tryParse(input);

    if (input.isEmpty || parsed == null || parsed <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter a valid positive number")),
      );
      return;
    }

    timerDuration = int.parse(input);

    setState(() {
      isClicked = true;
      isMessageVisible = true;
      secondsElapsed = 0;
    });

    periodicTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        secondsElapsed++;
      });

      if (secondsElapsed >= timerDuration) {
        timer.cancel();
        setState(() {
          isClicked = false;
          isMessageVisible = false;
          secondsElapsed = 0;
          timerDuration = 0;
        });
        timerDurationInputSeconds.clear(); //  clears input field
      }
    });
  }

  @override
  void dispose() {
    periodicTimer?.cancel();
    timerDurationInputSeconds.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double progress = (timerDuration > 0)
        ? (secondsElapsed / timerDuration).clamp(0.0, 1.0)
        : 0.0;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Timer with Duration & Callback"),
        backgroundColor: Colors.indigo.shade700,
        foregroundColor: Colors.white,
        elevation: 6,
      ),
      body: Center(
        child: Card(
          elevation: 12,
          color: Colors.indigo.shade50,
          margin: const EdgeInsets.symmetric(horizontal: 40),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            padding: const EdgeInsets.all(24),
            height: 300,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: timerDurationInputSeconds,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  enabled: !isClicked,
                  style: const TextStyle(fontSize: 18),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 12,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.indigo),
                    ),
                    hintText: "Enter time in seconds",
                    hintStyle: TextStyle(color: Colors.grey[600]),
                  ),
                ),
                const SizedBox(height: 30),
                if (isMessageVisible) ...[
                  Text(
                    "Timer is running: $secondsElapsed second${secondsElapsed == 1 ? '' : 's'} elapsed",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.indigo.shade800,
                    ),
                  ),
                  const SizedBox(height: 20),
                  LinearProgressIndicator(
                    value: progress,
                    backgroundColor: Colors.grey[300],
                    color: Colors.indigo,
                    minHeight: 10,
                  ),
                  const SizedBox(height: 20),
                ],
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo.shade700,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 4,
                      textStyle: const TextStyle(fontSize: 16),
                    ),
                    onPressed: isClicked ? null : startCounterWithTimer,
                    child: const Text("Start Timer"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
