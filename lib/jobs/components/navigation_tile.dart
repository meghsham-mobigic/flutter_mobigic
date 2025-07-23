import 'package:flutter/material.dart';

class NavigationTile extends StatelessWidget {
  const NavigationTile({required this.title, required this.route, super.key});

  final String title;
  final String route;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward),
      onTap: () => Navigator.pushNamed(context, route),
    );
  }
}
