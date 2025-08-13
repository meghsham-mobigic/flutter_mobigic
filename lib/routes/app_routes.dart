import 'package:flutter/material.dart';
import 'package:flutter_mobigic/file_handling/file_handler.dart';
import 'package:flutter_mobigic/file_handling/read_write_app.dart';
import 'package:flutter_mobigic/grid/screens/grid_calendar_input_form.dart';
import 'package:flutter_mobigic/grid/screens/grid_horizontal_dated_month.dart';
import 'package:flutter_mobigic/grid/screens/grid_vertical_dated_month.dart';
import 'package:flutter_mobigic/hive_DB/hive_app_root.dart';
import 'package:flutter_mobigic/home_screen/home_screen.dart';
import 'package:flutter_mobigic/http_methods/Model/product_model.dart';
import 'package:flutter_mobigic/http_methods/image_multipart/image_upload_screen.dart';
import 'package:flutter_mobigic/http_methods/screen/product_create.dart';
import 'package:flutter_mobigic/http_methods/screen/product_dashboard.dart';
import 'package:flutter_mobigic/http_methods/screen/product_details.dart';
import 'package:flutter_mobigic/http_methods/screen/product_update.dart';
import 'package:flutter_mobigic/icons/material_icons.dart';
import 'package:flutter_mobigic/images_in_ratio/image_input_page.dart';
import 'package:flutter_mobigic/images_in_ratio/image_preview_page.dart';
import 'package:flutter_mobigic/jobs/jobs_login.dart';
import 'package:flutter_mobigic/jobs/jobs_register_screen.dart';
import 'package:flutter_mobigic/splash_screen/splash_screen.dart';
import 'package:flutter_mobigic/themes_and_counter/themes_and_counter_home.dart';
import 'package:flutter_mobigic/time_operations/date_and_time_app_root.dart';

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
  static const String fileHandler = '/fileHandler';
  static const String readWriteApp = '/readWriteApp';
  static const String hiveDB = '/hiveDB';
  static const String httpMethod = '/httpMethod';
  static const String editProduct = '/editProduct';
  static const String addProduct = '/addProduct';
  static const String detailsProduct = '/detailsProduct';
  static const String imageUploader = '/imageUploader';
  static const String updateProduct = '/updateProduct';
  static const String datedMonthGrid = '/datedMonthGrid';

  static Route<dynamic> generateRoutes(RouteSettings settings) {
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
        return MaterialPageRoute(builder: (_) => const CalendarInputForm());
      case datedMonthGrid:
        final args = settings.arguments as Map<String, dynamic>;
        final String layoutType = args['layoutType'] as String;
        final int weekStartsOn = args['weekStartsOn'] as int;
        final int monthStartsOn = args['monthStartsOn'] as int;
        final int daysInMonth = args['daysInMonth'] as int;

        if (layoutType == 'vertical') {
          return MaterialPageRoute(
            builder: (_) => VerticalDatedMonthGrid(
              title: 'Vertical Calendar',
              weekStartsOn: weekStartsOn,
              monthStartsOn: monthStartsOn,
              daysInMonth: daysInMonth,
            ),
          );
        } else {
          return MaterialPageRoute(
            builder: (_) => HorizontalDatedMonthGrid(
              title: 'Horizontal Calendar',
              weekStartsOn: weekStartsOn,
              monthStartsOn: monthStartsOn,
              daysInMonth: daysInMonth,
            ),
          );
        }
      case dateAndTimeApp:
        return MaterialPageRoute(builder: (_) => const DateAndTimeAppRoot());
      case imageInputRoute:
        return MaterialPageRoute(builder: (_) => const AspectRatioAppRoot());
      case materialIcons:
        return MaterialPageRoute(builder: (_) => const MaterialIconsAppRoot());
      case fileHandler:
        return MaterialPageRoute(builder: (_) => const FilePickerAppRoot());
      case readWriteApp:
        return MaterialPageRoute(builder: (_) => const ReadWriteAppRoot());
      case hiveDB:
        return MaterialPageRoute(builder: (_) => const HiveDBAppRoot());
      case imageUploader:
        return MaterialPageRoute(builder: (_) => const FileUploaderHome());
      case imagePreviewRoute:
        final Map<String, dynamic> args =
            settings.arguments as Map<String, dynamic>;
        final double aspectRatio = args['aspectRatio'] as double;
        final String label = args['label'] as String;
        return MaterialPageRoute(
          builder: (_) => ImagePreviewPage(
            aspectRatio: aspectRatio,
            label: label,
          ),
        );

      case httpMethod:
        return MaterialPageRoute(builder: (_) => const ProductDashboard());
      case editProduct:
        ProductModel product = settings.arguments! as ProductModel;
        return MaterialPageRoute(
          builder: (_) => UpdateProduct(product: product),
        );
      case addProduct:
        return MaterialPageRoute(builder: (_) => CreateProduct());

      case updateProduct:
        ProductModel product = settings.arguments! as ProductModel;
        return MaterialPageRoute(
          builder: (_) => UpdateProduct(product: product),
        );

      case detailsProduct:
        ProductModel product = settings.arguments! as ProductModel;
        return MaterialPageRoute(
          builder: (_) => ProductDetailScreen(product: product),
        );

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
