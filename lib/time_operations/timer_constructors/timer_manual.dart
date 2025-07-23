// import 'package:flutter/material.dart';
// import 'package:mobigic/common_files/constants/app_color_constants.dart';

// class TimerPage extends StatefulWidget {
//   const TimerPage({super.key});

//   @override
//   State<TimerPage> createState() => _TimerPageState();
// }

// class _TimerPageState extends State<TimerPage> {
//   bool isClicked = false;
//   bool isMessageVisible = false;
//   int secondsElapsed = 0;
//   final int totalSeconds = 3;

//   Future<void> explode() async {
//     setState(() {
//       isClicked = true;
//       isMessageVisible = true;
//       secondsElapsed = 0;
//     });

//     for (int i = 0; i < totalSeconds; i++) {
//       await Future.delayed(const Duration(seconds: 1));
//       setState(() => secondsElapsed++);
//     }

//     setState(() {
//       isClicked = false;
//       isMessageVisible = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     double progress = (secondsElapsed / totalSeconds).clamp(
//       0.0,
//       1.0,
//     ); // used to ensure that the value of progress is between 0.0 and 1.0.

//     return Scaffold(
//       appBar: AppBar(title: const Text('10 Sec Timer Page')),
//       body: Center(
//         child: SizedBox(
//           height: 300,
//           width: double.infinity,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               if (isMessageVisible)
//                 Column(
//                   children: [
//                     Text(
//                       'Timer is running, $secondsElapsed seconds elapsed',
//                       style: const TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.w500,
//                         color: AppColors.blue,
//                       ),
//                     ),
//                     const SizedBox(height: 16),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 20),
//                       child: LinearProgressIndicator(
//                         value: progress,
//                         backgroundColor: AppColors.grey,
//                         color: AppColors.blue,
//                         minHeight: 10,
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//                   ],
//                 ),
//               ElevatedButton(
//                 onPressed: !isClicked ? explode : null,
//                 child: const Text('Start Timer'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
