import 'package:flutter/material.dart';

//this class manage states and notifies listeners when the state value is  changes
class Score extends ChangeNotifier {
  int _score = 0;

  int get score => _score; // getter

  void increment() {
    _score++;
    notifyListeners(); // notify listeners when the state value is changed
  }

  void decrement() {
    _score--;
    notifyListeners();
  }
}

// reusable component to display the score
class ScoreDisplay extends StatelessWidget {
  // constructor that takes a Score object as an argument
  const ScoreDisplay({super.key, required this.score});

  final Score score;

  @override
  Widget build(BuildContext context) {
    // use ListenableBuilder to rebuild the widget when the score changes
    return ListenableBuilder(
      // listen to the score object
      listenable: score,
      // build method that returns the widget with the changed current score
      builder: (context, child) {
        return Text(
          'Score: ${score.score}',
          style: const TextStyle(fontSize: 24),
        );
      },
    );
  }
}

class ScoreUpdateModifier extends StatefulWidget {
  const ScoreUpdateModifier({super.key});

  @override
  State<ScoreUpdateModifier> createState() => _ScoreUpdateModifierState();
}

class _ScoreUpdateModifierState extends State<ScoreUpdateModifier> {
  final Score _score = Score();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Score Update")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                ScoreDisplay(score: _score),
                const SizedBox(width: 10),

                ScoreDisplay(score: _score),
                const SizedBox(width: 10),

                ScoreDisplay(score: _score),
                const SizedBox(width: 10),

                ScoreDisplay(score: _score),
                const SizedBox(width: 10),

                ScoreDisplay(score: _score),
                const SizedBox(width: 10),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _score.increment,
                  child: const Text('Increment'),
                ),

                const SizedBox(width: 10),

                ElevatedButton(
                  onPressed: _score.decrement,
                  child: const Text('Decrement'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // score is initialized in the constructor
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _score.dispose(); // after the widget is disposed, dispose the score object
  }
}
