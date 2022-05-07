import 'package:fyp/user/user_api.dart';
import 'package:fyp/user/user_repository.dart';
import 'package:get_it/get_it.dart';

final _locator = GetIt.instance;

IUserRepository get userRepository => _locator<IUserRepository>();

abstract class DependencyInjectionEnvironment {
  static Future<void> setup() async {
    _locator.registerLazySingleton<IUserRepository>(() => UserApi());
  }
}
