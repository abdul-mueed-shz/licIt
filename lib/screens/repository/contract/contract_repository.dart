import 'package:fyp/model/contract_model.dart';

abstract class IContractRepository {
  Future<ContractModel?> get(String documentId);
  Future<List<ContractModel>?> getAll();
  Future<void> add(ContractModel user);
  Future<void> update(String documentId, Map<String, dynamic> map);
  Future<void> delete(String documentId);
}
