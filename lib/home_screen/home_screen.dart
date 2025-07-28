import 'package:flutter/material.dart';
import 'package:flutter_mobigic/jobs/components/assignment_group.dart';
import 'package:flutter_mobigic/jobs/components/navigation_tile.dart';
import 'package:flutter_mobigic/l10n/app_localizations.dart';
import 'package:flutter_mobigic/main.dart';
import 'package:flutter_mobigic/routes/app_routes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final VoidCallback onToggleTheme;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.translate),
            onPressed: () {
              localeManager.locale.languageCode == 'en'
                  ? localeManager.changeLocale(const Locale('mr'))
                  : localeManager.changeLocale(const Locale('en'));
            },
          ),
          IconButton(
            icon: Icon(
              themeManager.isDarkTheme ? Icons.light_mode : Icons.dark_mode,
            ),
            onPressed: themeManager.toggleTheme,
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(15),
        children: [
          ColoredBox(
            color: Theme.of(context).primaryColor,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Center(child: Text(localizations.quote)),
            ),
          ),
          const SizedBox(height: 10),
          AssignmentGroup(
            title: localizations.assignement_1_title,
            tasks: const [
              NavigationTile(
                title: 'Multi-page Counter App',
                route: AppRoutes.darkLightCounterAppRoot,
              ),
            ],
          ),
          AssignmentGroup(
            title: localizations.assignement_2_title,
            tasks: const [
              NavigationTile(
                title: 'Login Page',
                route: AppRoutes.loginRoute,
              ),
              NavigationTile(
                title: 'Register Page',
                route: AppRoutes.registerRoute,
              ),
            ],
          ),
          AssignmentGroup(
            title: localizations.assignement_3_title,
            tasks: const [
              NavigationTile(
                title: 'Calender Grid Layout Generator',
                route: AppRoutes.gridLayoutRoute,
              ),
            ],
          ),
          AssignmentGroup(
            title: localizations.assignement_4_title,
            tasks: const [
              NavigationTile(
                title: 'Age Calculator',
                route: AppRoutes.dateAndTimeApp,
              ),
            ],
          ),
          AssignmentGroup(
            title: localizations.assignement_5_title,
            tasks: const [
              NavigationTile(
                title: 'Input Aspect Ratio',
                route: AppRoutes.imageInputRoute,
              ),
            ],
          ),
          AssignmentGroup(
            title: localizations.assignement_6_title,
            tasks: const [
              NavigationTile(
                title: 'Material Icons Sizing and Colors',
                route: AppRoutes.materialIcons,
              ),
            ],
          ),
          AssignmentGroup(
            title: localizations.assignement_7_title,
            tasks: const [
              NavigationTile(
                title: 'Pick file and show details',
                route: AppRoutes.fileHandler,
              ),
              NavigationTile(
                title: 'Read and Write application',
                route: AppRoutes.readWriteApp,
              ),
            ],
          ),

          AssignmentGroup(
            title: localizations.assignement_8_title,
            tasks: const [
              NavigationTile(
                title: 'Hive Database Implementation in flutter',
                route: AppRoutes.hiveDB,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
