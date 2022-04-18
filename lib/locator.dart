import 'package:calkitna_mobile_app/core/services/locato_storage_service.dart';
import 'package:calkitna_mobile_app/core/services/notification_service.dart';
import 'package:get_it/get_it.dart';
import 'core/services/auth_service.dart';
import 'core/services/database_service.dart';

GetIt locator = GetIt.instance;

setupLocator() {
  locator.registerSingleton(AuthService());
  locator.registerSingleton(DatabaseService());
  locator.registerSingleton(LocalStorageService());
  locator.registerSingleton(NotificationsService());
}
