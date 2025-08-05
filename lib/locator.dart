import 'package:flutter_mobigic/http_methods/services/data_service.dart';
import 'package:flutter_mobigic/http_methods/services/web_data_service.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

setupServiceLocator() {
  locator.registerLazySingleton<DataService>(() => WebDataService());
}
