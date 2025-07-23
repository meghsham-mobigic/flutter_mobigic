import 'package:flutter/material.dart';
import 'package:flutter_mobigic/constants/app_colors.dart';

class ThemeConfig {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: Colors.orange,
    scaffoldBackgroundColor: AppColors.secondary1,
    cardColor: AppColors.sec,
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: Colors.red,
    scaffoldBackgroundColor: AppColors.primary1,
    cardColor: const Color.fromARGB(102, 153, 195, 81),
  );
}
