import 'package:flutter/material.dart';

class ThemeConfig {




  // Light Theme
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true, // Material 3 enable

    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white70,
      foregroundColor: Colors.black87,
    ),

    scaffoldBackgroundColor: Colors.grey.shade300,
    
    // Define consistent color scheme for light theme
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blue,
    ),
  );
//==============================================================================
  // Dark Theme
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true, // Material 3 enable disable

    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black87,
      foregroundColor: Colors.white70,
    ),

    scaffoldBackgroundColor: Colors.grey.shade700,

    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blue, // Same primary seed, works well in dark too
      brightness: Brightness.dark, // Dark theme brightness
    ),
  );
}
