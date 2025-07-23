// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:mobigic/common_files/constants/app_color_constants.dart';

// class BirthdateWidget extends StatefulWidget {
//   const BirthdateWidget({super.key});

//   @override
//   State<BirthdateWidget> createState() => _BirthdateWidgetState();
// }

// class _BirthdateWidgetState extends State<BirthdateWidget> {
//   DateTime? selectedDate;
//   final TextEditingController _controller = TextEditingController();

//   DateTime get today => DateTime.now();

//   // Date Picker
//   Future<void> _pickDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: selectedDate ?? today,
//       firstDate: DateTime(1990),
//       lastDate: today,
//     );

//     if (picked != null) {
//       setState(() {
//         selectedDate = picked;
//         _controller.text = DateFormat('dd-MM-yyyy').format(picked);
//       });
//     }
//   }

//   // Calculate Age
//   String _calculateAge(DateTime birthDate) {
//     final now = DateTime.now();
//     int years = now.year - birthDate.year;
//     int months = now.month - birthDate.month;
//     int days = now.day - birthDate.day;

//     if (days < 0) {
//       months -= 1;
//       final prevMonth = DateTime(now.year, now.month, 0);
//       days += prevMonth.day;
//     }

//     if (months < 0) {
//       years -= 1;
//       months += 12;
//     }

//     return "$years year(s), $months month(s), $days day(s)";
//   }

//   @override
//   Widget build(BuildContext context) {
//     final ageText = selectedDate != null ? _calculateAge(selectedDate!) : null;
//     final dateFormat = DateFormat('dd-MM-yyyy');

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: [
//         // 🔹 Birthdate input card
//         Card(
//           elevation: 4,
//           margin: const EdgeInsets.symmetric(vertical: 8),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: Padding(
//             padding: const EdgeInsets.all(16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text(
//                   "2. Select your birthdate:",
//                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//                 ),
//                 const SizedBox(height: 10),
//                 TextField(
//                   controller: _controller,
//                   keyboardType: TextInputType.datetime,
//                   decoration: InputDecoration(
//                     hintText: "DD-MM-YYYY",
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     suffixIcon: IconButton(
//                       icon: const Icon(Icons.calendar_today),
//                       onPressed: () => _pickDate(context),
//                     ),
//                   ),
//                   onChanged: (value) {
//                     try {
//                       final parsed = DateFormat(
//                         'dd-MM-yyyy',
//                       ).parseStrict(value);
//                       if (parsed.isBefore(today)) {
//                         setState(() {
//                           selectedDate = parsed;
//                         });
//                       }
//                     } catch (_) {
//                       // Invalid input ignored
//                     }
//                   },
//                 ),
//                 const SizedBox(height: 12),
//                 if (ageText != null)
//                   Text(
//                     "You are $ageText old",
//                     style: const TextStyle(fontSize: 16, color: AppColors.blue),
//                   ),
//               ],
//             ),
//           ),
//         ),

//         Card(
//           elevation: 4,
//           margin: const EdgeInsets.symmetric(vertical: 8),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: Padding(
//             padding: const EdgeInsets.all(16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     const Text(
//                       "Epoch Time (Milliseconds):",
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                     IconButton(
//                       icon: const Icon(Icons.refresh),
//                       onPressed: () {
//                         setState(() {});
//                       },
//                       tooltip: "Refresh current time",
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 10),
//                 Text(
//                   "• Current Time: ${DateTime.now().millisecondsSinceEpoch}",
//                 ),
//                 if (selectedDate != null)
//                   Text("• Birthdate: ${selectedDate!.millisecondsSinceEpoch}"),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
