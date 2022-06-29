import 'package:fyp/screens/repository/contract/contarct_api.dart';
import 'package:fyp/screens/repository/contract/contract_repository.dart';
import 'package:fyp/screens/repository/review/review_api.dart';
import 'package:fyp/screens/repository/review/review_repository.dart';
import 'package:fyp/screens/repository/storage/prefs_storage.dart';
import 'package:fyp/screens/repository/storage/storage.dart';
import 'package:fyp/screens/repository/user/user_api.dart';
import 'package:fyp/screens/repository/user/user_repository.dart';
import 'package:get_it/get_it.dart';

final _locator = GetIt.instance;

IUserRepository get userRepository => _locator<IUserRepository>();
IReviewRepository get reviewRepository => _locator<IReviewRepository>();

IContractRepository get contractRepository => _locator<IContractRepository>();
IStorage get storage => _locator<IStorage>();

abstract class DependencyInjectionEnvironment {
  static Future<void> setup() async {
    _locator.registerLazySingleton<IUserRepository>(() => UserApi());
    _locator.registerLazySingleton<IContractRepository>(() => ContractApi());
    _locator.registerLazySingleton<IReviewRepository>(() => ReviewApi());
    _locator.registerLazySingleton<IStorage>(() => PrefStorage());
  }
}
