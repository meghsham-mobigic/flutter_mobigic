import 'package:flutter/material.dart';
import 'package:flutter_mobigic/constants/app_colors.dart';

class FailureScreen extends StatelessWidget {
  const FailureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Failure')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/failure.png', height: 200),
            const SizedBox(height: 20),
            const Text(
              'Login Failed!',
              style: TextStyle(fontSize: 24, color: AppColors.red),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Back to Login'),
            ),
          ],
        ),
      ),
    );
  }
}
