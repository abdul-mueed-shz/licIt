import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fyp/model/contract_model.dart';
import 'package:fyp/screens/repository/contract/contract_repository.dart';
import 'package:fyp/util/pref.dart';

class ContractApi implements IContractRepository {
  final user = FirebaseFirestore.instance;

  final CollectionReference<ContractModel> modelsRef = FirebaseFirestore
      .instance
      .collection('users')
      .doc(Prefs.instance.getLoginUserId() ?? "3123456789123")
      .collection("contract")
      .withConverter<ContractModel>(
        fromFirestore: (snapshot, _) =>
            ContractModel.fromJson(snapshot.data()!),
        toFirestore: (user, _) => user.toJson(),
      );

  @override
  Future<ContractModel?> get(String documentId) =>
      modelsRef.doc(documentId).get().then((s) => s.data());

  @override
  Future<List<ContractModel>?> getAll() async {
    final snapshot = await modelsRef.get();
    final docs = snapshot.docs;

    if (docs.isNotEmpty) {
      final List<ContractModel> users = [];
      for (int i = 0; i < docs.length; i++) {
        users.add(docs[i].data());
      }
      return users;
    }
    return null;
  }

  @override
  Future<void> add(ContractModel user) => modelsRef.doc(user.id).set(user);

  @override
  Future<void> update(String documentId, Map<String, dynamic> map) =>
      modelsRef.doc(documentId).update(map);

  @override
  Future<void> delete(String documentId) => modelsRef.doc(documentId).delete();
}
