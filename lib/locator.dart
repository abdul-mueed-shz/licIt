import 'package:fyp/screens/repository/contract/contarct_api.dart';
import 'package:fyp/screens/repository/contract/contract_repository.dart';
import 'package:fyp/screens/repository/user/user_api.dart';
import 'package:fyp/screens/repository/user/user_repository.dart';
import 'package:get_it/get_it.dart';

final _locator = GetIt.instance;

IUserRepository get userRepository => _locator<IUserRepository>();
IContractRepository get contractRepository => _locator<IContractRepository>();

abstract class DependencyInjectionEnvironment {
  static Future<void> setup() async {
    _locator.registerLazySingleton<IUserRepository>(() => UserApi());
    _locator.registerLazySingleton<IContractRepository>(() => ContractApi());
  }
}
