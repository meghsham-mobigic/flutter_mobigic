import 'package:flutter/material.dart';
import 'package:flutter_mobigic/l10n/app_localizations.dart';

class LocaleManager extends ChangeNotifier {
  Locale locale = const Locale('en');

  void changeLocale(Locale newLocale) {
    if (AppLocalizations.supportedLocales.contains(newLocale)) {
      locale = newLocale;
      notifyListeners();
    }
  }
}
