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
        padding: const EdgeInsets.all(16),
        children: [
          ColoredBox(
            color: Theme.of(context).primaryColor,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Center(child: Text(localizations.quote)),
            ),
          ),
          const SizedBox(height: 10),
          const AssignmentGroup(
            title: 'Assignment 1: Page Navigation with Data',
            tasks: [
              NavigationTile(
                title: 'Multi-page Counter App',
                route: AppRoutes.darkLightCounterAppRoot,
              ),
            ],
          ),
          const AssignmentGroup(
            title: 'Assignment 2: Login & Registration',
            tasks: [
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
          const AssignmentGroup(
            title: 'Assignment 3: Grid Layouts',
            tasks: [
              NavigationTile(
                title: 'Calender Grid Layout Generator',
                route: AppRoutes.gridLayoutRoute,
              ),
            ],
          ),
          const AssignmentGroup(
            title: 'Assignment 4: Date & Time Operations',
            tasks: [
              NavigationTile(
                title: 'Age Calculator',
                route: AppRoutes.dateAndTimeApp,
              ),
            ],
          ),
          const AssignmentGroup(
            title: 'Assignment 5: Image Aspect Ratio Demo',
            tasks: [
              NavigationTile(
                title: 'Input Aspect Ratio',
                route: AppRoutes.imageInputRoute,
              ),
            ],
          ),
          const AssignmentGroup(
            title: 'Assignment 6: Material Icons',
            tasks: [
              NavigationTile(
                title: 'Material Icons Sizing and Colors',
                route: AppRoutes.materialIcons,
              ),
            ],
          ),
          const AssignmentGroup(
            title: 'Assignment 7: File Handling',
            tasks: [
              NavigationTile(
                title: 'Pick file and show details',
                route: AppRoutes.fileHandler,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
