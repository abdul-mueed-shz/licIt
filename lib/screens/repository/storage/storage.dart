import 'package:fyp/model/contract_model.dart';

abstract class IStorage {
  Future<void> init();

  Future<bool> setContract(ContractModel? contract);
  ContractModel? get contract;
  Future<void> setId(String cnic);
  Future<void> setCnicToken(String cnic);

  String? get id;
  Future<void> allClear();
  Future<bool> removeUser();
}
