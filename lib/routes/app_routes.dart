import 'package:flutter/material.dart';
import 'package:flutter_mobigic/grid/screens/grid_screen_home.dart';
import 'package:flutter_mobigic/home_screen/home_screen.dart';
import 'package:flutter_mobigic/icons/material_icons.dart';
import 'package:flutter_mobigic/images_in_ratio/image_input_page.dart';
import 'package:flutter_mobigic/jobs/jobs_login.dart';
import 'package:flutter_mobigic/jobs/jobs_login_failure.dart';
import 'package:flutter_mobigic/jobs/jobs_register_screen.dart';
import 'package:flutter_mobigic/splash/splash_screen.dart';
import 'package:flutter_mobigic/themes_and_counter/themes_and_counter_home.dart';
import 'package:flutter_mobigic/time_operations/date_and_time_app_root.dart';

class AppRoutes {
  static const String splashScreen = '/splashScreen';
  static const String homeScreenRoute = '/';
  //incomplete
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
    print(settings.name);
    switch (settings.name) {
      case splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case homeScreenRoute:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case darkLightCounterAppRoot:
        return MaterialPageRoute(builder: (_) => const LightDarkAppRoot());
      case loginRoute:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case registerRoute:
        return MaterialPageRoute(builder: (_) => const RegistrationScreen());
      case gridLayoutRoute:
        return MaterialPageRoute(builder: (_) => const CalenderGridAppRoot());
      case dateAndTimeApp:
        return MaterialPageRoute(builder: (_) => const DateAndTimeAppRoot());
      case imageInputRoute:
        return MaterialPageRoute(builder: (_) => const AspectRatioAppRoot());
      case materialIcons:
        return MaterialPageRoute(builder: (_) => const MaterialIconsAppRoot());
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
