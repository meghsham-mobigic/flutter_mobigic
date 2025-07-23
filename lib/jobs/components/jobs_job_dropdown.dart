import 'package:flutter/material.dart';

class JobDropdown extends StatelessWidget {
  final String? jobRole;
  final ValueChanged<String?> onChanged;
  final List<String> jobRoles;

  const JobDropdown({
    Key? key,
    required this.jobRole,
    required this.onChanged,
    this.jobRoles = const [
      'Flutter Developer',
      'Backend Developer',
      'UI/UX Designer',
      'QA Tester',
    ],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonFormField<String>(
        decoration: const InputDecoration(
          labelText: 'Job Role *',
          border: OutlineInputBorder(),
        ),
        value: jobRole,
        items: jobRoles
            .map((role) => DropdownMenuItem(
                  value: role,
                  child: Text(role),
                ))
            .toList(),
        onChanged: onChanged,
      ),
    );
  }
} 