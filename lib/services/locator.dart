import 'package:get_it/get_it.dart';
import 'package:aptus/services/auth.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => AuthService());
}
