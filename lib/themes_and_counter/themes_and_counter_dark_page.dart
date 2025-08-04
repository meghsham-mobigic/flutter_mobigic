import 'package:flutter/material.dart';

class DarkModeCounterPage extends StatelessWidget {
  const DarkModeCounterPage({
    required this.counter,
    required this.onIncrement,
    required this.onSwitch,
    super.key,
  });

  final int counter;
  final VoidCallback onIncrement;
  final VoidCallback onSwitch;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.dark(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Dark Mode Counter')),
        body: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('You have pushed the button this many times:'),
                  Text(
                    '$counter',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 20,
              left: 20,
              child: ElevatedButton(
                onPressed: onSwitch,
                child: const Text('Go to Light Mode'),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: onIncrement,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
