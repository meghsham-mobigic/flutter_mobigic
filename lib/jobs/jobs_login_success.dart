import 'package:flutter/material.dart';
import 'package:flutter_mobigic/routes/app_routes.dart';
class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Success')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle, size: 100, color: Colors.green),
            const SizedBox(height: 20),
            const Text(
              'Login Successful!',
              style: TextStyle(fontSize: 24, color: Colors.green),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.homeScreenRoute,
                (route) => false,
              ),
              child: const Text('Back to Home'),
            ),
          ],
        ),
      ),
    );
  }
}
