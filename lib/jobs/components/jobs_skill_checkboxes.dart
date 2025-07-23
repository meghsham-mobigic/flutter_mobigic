import 'package:flutter/material.dart';

class SkillCheckboxes extends StatelessWidget {
  final Map<String, bool> skills;
  final void Function(String skill, bool checked) onChanged;

  const SkillCheckboxes({
    Key? key,
    required this.skills,
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
          const Text('Skills *', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: skills.keys.map((skill) {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Checkbox(
                      value: skills[skill],
                      onChanged: (checked) => onChanged(skill, checked ?? false),
                    ),
                    Text(skill),
                    const SizedBox(width: 8),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
} 