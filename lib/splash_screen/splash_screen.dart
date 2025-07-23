import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobigic/constants/app_colors.dart';
import 'package:flutter_mobigic/routes/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.immersiveSticky,
    ); 
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pushReplacementNamed(context, AppRoutes.homeScreenRoute);
    });
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        //stretch to the full width of its parent widget
        height: double.infinity,
        //stretch to the full height of its parent widget
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.blue, AppColors.teal],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.05, 0.5],
          ),
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Mobigic',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 60,
                color: AppColors.yellow,
                fontWeight: FontWeight.w900,
                decoration: TextDecoration.underline,
                decorationColor: AppColors.yellow,
                decorationThickness: 1.5,
                letterSpacing: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
