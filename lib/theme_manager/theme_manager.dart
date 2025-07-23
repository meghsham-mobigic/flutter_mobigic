import 'package:flutter/material.dart';

class ThemeManager extends ChangeNotifier with WidgetsBindingObserver {
  ThemeManager() {
    WidgetsBinding.instance.addObserver(this);
  }

  bool isDarkTheme = false;

  ThemeMode currentTheme() {
    return isDarkTheme ? ThemeMode.dark : ThemeMode.light;
  }

  void toggleTheme() {
    print('Toggling theme: $isDarkTheme');
    isDarkTheme = !isDarkTheme;
    notifyListeners();
  }

  void setSystemTheme(bool value) {
    isDarkTheme = value;
    notifyListeners();
  }

  @override
  void didChangePlatformBrightness() {
    final brightness =
        WidgetsBinding.instance.platformDispatcher.platformBrightness;
    isDarkTheme = brightness == Brightness.dark;
    notifyListeners();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
