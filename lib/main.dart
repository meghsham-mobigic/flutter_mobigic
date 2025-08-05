import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_mobigic/l10n/app_localizations.dart';
import 'package:flutter_mobigic/l10n/utility/local_manager.dart';
import 'package:flutter_mobigic/locator.dart';
import 'package:flutter_mobigic/routes/app_routes.dart';
import 'package:flutter_mobigic/theme_manager/theme_config.dart';
import 'package:flutter_mobigic/theme_manager/theme_manager.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';

final ThemeManager themeManager = ThemeManager();
final LocaleManager localeManager = LocaleManager();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //HIVE IMPL
  final Directory dir =
      await getApplicationDocumentsDirectory(); // function in path_provider.dart
  Hive.init(dir.path);
  await Hive.openBox<String>('HiveBox');
  setupServiceLocator();
  runApp(const MaterialRoot());
}

class MaterialRoot extends StatefulWidget {
  const MaterialRoot({super.key});

  @override
  State<MaterialRoot> createState() => _MaterialRootState();
}

class _MaterialRootState extends State<MaterialRoot> {
  @override
  void initState() {
    super.initState();
    themeManager.addListener(_themeListener);
    localeManager.addListener(_localeListener);
  }

  void _themeListener() {
    setState(() {});
  }

  void _localeListener() {
    setState(() {});
  }

  @override
  void dispose() {
    themeManager
      ..removeListener(_themeListener)
      ..dispose();
    localeManager.removeListener(_localeListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeConfig.lightTheme,
      darkTheme: ThemeConfig.darkTheme,
      themeMode: themeManager.currentTheme(),
      locale: localeManager.locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('mr'),
      ],
      // home: const ImageUploaderHome(),
      initialRoute: AppRoutes.splashScreen,
      onGenerateRoute: AppRoutes.generateRoutes,
    );
  }
}
