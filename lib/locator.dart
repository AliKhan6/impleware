import 'package:get_it/get_it.dart';
import 'core/services/auth_service.dart';
import 'core/services/database_service.dart';

GetIt locator = GetIt.instance;

setupLocator() {
  locator.registerSingleton(AuthService());
  locator.registerSingleton(DatabaseService());
}