import 'package:flutter/material.dart';

class GenderSelector extends StatelessWidget {
  final String? gender;
  final ValueChanged<String?> onChanged;

  const GenderSelector({
    Key? key,
    required this.gender,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Gender *', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Row(
            children: [
              Row(
                children: [
                  Radio<String>(
                    value: 'Male',
                    groupValue: gender,
                    onChanged: onChanged,
                  ),
                  const Text('Male'),
                ],
              ),
              const SizedBox(width: 16),
              Row(
                children: [
                  Radio<String>(
                    value: 'Female',
                    groupValue: gender,
                    onChanged: onChanged,
                  ),
                  const Text('Female'),
                ],
              ),
              const SizedBox(width: 16),
              Row(
                children: [
                  Radio<String>(
                    value: 'Other',
                    groupValue: gender,
                    onChanged: onChanged,
                  ),
                  const Text('Other'),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
} 