import 'package:flutter/material.dart';
import 'package:flutter_mobigic/constants/app_colors.dart';
import 'package:intl/intl.dart';

class BirthdateWidget extends StatefulWidget {
  const BirthdateWidget({super.key});

  @override
  State<BirthdateWidget> createState() => _BirthdateWidgetState();
}

class _BirthdateWidgetState extends State<BirthdateWidget> {
  DateTime? selectedDate;
  final TextEditingController _controller = TextEditingController();

  DateTime get today => DateTime.now();

  // Date Picker
  Future<void> _pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? today,
      firstDate: DateTime(1990),
      lastDate: today,
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
        _controller.text = DateFormat('dd-MM-yyyy').format(picked);
      });
    }
  }



  String getFormattedAge(DateTime birthDate) {
    final now = DateTime.now();
    return (birthDate.isAfter(now))
        ? 'Invalid birth date'
        : _getAgeDifference(birthDate, now);
  }

  String _getAgeDifference(DateTime birthDate, DateTime now) {
    if (birthDate.isAfter(now)) return 'Invalid birth date';

    int years = now.year - birthDate.year;
    int months = now.month - birthDate.month;
    int days = now.day - birthDate.day;

    if (days < 0) {
      final prevMonth = DateTime(now.year, now.month, 0);
      days += prevMonth.day;
      months -= 1;
    }

    if (months < 0) {
      months += 12;
      years -= 1;
    }

    return '$years year(s), $months month(s), $days day(s)';
  }

  @override
  Widget build(BuildContext context) {
    final ageText = selectedDate != null
        ? getFormattedAge(selectedDate!)
        : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Card(
          elevation: 4,
          margin: const EdgeInsets.symmetric(vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '2. Select your birthdate:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () => _pickDate(context),
                  child: AbsorbPointer(
                    // Prevents keyboard interaction
                    child: TextField(
                      controller: _controller,
                      readOnly: true, // Prevents manual typing
                      decoration: InputDecoration(
                        hintText: 'DD-MM-YYYY',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.calendar_today),
                          onPressed: () => _pickDate(context),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                if (ageText != null)
                  Text(
                    'You are $ageText old',
                    style: const TextStyle(fontSize: 16, color: AppColors.blue),
                  ),
              ],
            ),
          ),
        ),

        Card(
          elevation: 4,
          margin: const EdgeInsets.symmetric(vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Epoch Time (Milliseconds):',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.refresh),
                      onPressed: () {
                        setState(() {});
                      },
                      tooltip: 'Refresh current time',
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Center(
                  child: Text(
                    'Current Date in Milliseconds since Epoch :\n ${DateTime.now().millisecondsSinceEpoch}',
                    style: const TextStyle(fontSize: 16, color: AppColors.blue),
                  ),
                ),
                if (selectedDate != null)
                  Center(
                    child: Text(
                      'Selected Date in Milliseconds since Epoch:\n ${selectedDate!.millisecondsSinceEpoch}',
                      style: const TextStyle(
                        fontSize: 16,
                        color: AppColors.blue,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
