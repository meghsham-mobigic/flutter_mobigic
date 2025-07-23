import 'package:flutter/material.dart';
import 'package:flutter_mobigic/homescreen/home_screen.dart';
import 'package:flutter_mobigic/splash/splash_screen.dart';
import 'package:flutter_mobigic/themes_and_counter/themes_and_counter_dark_page.dart';
import 'package:flutter_mobigic/themes_and_counter/themes_and_counter_home.dart';

class AppRoutes {
  static const String splashScreen = '/splashScreen';
  static const String homeScreenRoute = '/';
  static const String loginRoute = '/login';
  static const String registerRoute = '/register';
  static const String loginFailedRoute = '/loginFailed';
  static const String loginSuccessRoute = '/loginSuccess';
  static const String jobApplicationFormRoute = '/jobApplicationForm';
  static const String dateOperationsRoute = '/dateOperations';
  static const String gridLayoutRoute = '/gridLayoutRoute';
  static const String darkLightCounterAppRoot = '/darkLightCounterAppRoot';

  static const String lightModeCounterPage = '/lightModeCounterPage';
  static const String dateAndTimeApp = '/dateAndTimeApp';
  static const String imageInputRoute = '/imageInput';
  static const String imagePreviewRoute = '/imagePreview';
  static const String materialIcons = '/MaterialIcons';

  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case homeScreenRoute:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case darkLightCounterAppRoot:
        return MaterialPageRoute(builder: (_) => const LightDarkAppRoot());

      // case darkLightChanger:
      //   return MaterialPageRoute(builder: (_) => const ThemePracticePage());
      // case loginRoute:
      //   return MaterialPageRoute(builder: (_) => const LoginScreen());
      // case registerRoute:
      //   return MaterialPageRoute(builder: (_) => const RegistrationScreen());
      // case loginFailedRoute:
      //   return MaterialPageRoute(builder: (_) => const FailureScreen());
      // case loginSuccessRoute:
      //   return MaterialPageRoute(builder: (_) => const SuccessScreen());
      // case jobApplicationFormRoute:
      //   return MaterialPageRoute(
      //     builder: (_) => const JobApplicationFormScreen(),
      //   );
      // case gridLayoutRoute:
      //   return MaterialPageRoute(builder: (_) => const AppRootCalenderGrid());
      // case dateAndTimeApp:
      //   return MaterialPageRoute(builder: (_) => const DateAndTimeAppRoot());

      // case imageInputRoute:
      //   return MaterialPageRoute(builder: (_) => const AspectRatioInputPage());

      // case imagePreviewRoute:
      //   final args = settings.arguments! as Map<String, dynamic>;
      //   return MaterialPageRoute(
      //     builder: (_) => ImagePreviewPage(
      //       aspectRatio: args['aspectRatio'] as double,
      //       label: args['label'] as String,
      //     ),
      //   );
      // // IMP : use model class for passing data to route

      // case materialIcons:
      //   return MaterialPageRoute(builder: (_) => const MaterialIcons());

      //if everything fails
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            appBar: AppBar(title: const Text('Error')),
            body: const Center(child: Text('Route not found')),
          ),
        );
    }
  }
}
