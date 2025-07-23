import 'package:flutter/material.dart';
import 'package:flutter_mobigic/jobs/components/navigation_tile.dart';

class AssignmentGroup extends StatelessWidget {
  const AssignmentGroup({Key? key, required this.title, required this.tasks})
    : super(key: key);
  final String title;
  final List<NavigationTile> tasks;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const Divider(),
            ...tasks,
          ],
        ),
      ),
    );
  }
}
