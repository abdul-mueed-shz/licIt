import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fyp/model/local_user.dart';
import 'package:fyp/screens/repository/review/review_repository.dart';

class ReviewApi implements IReviewRepository {
  final user = FirebaseFirestore.instance;

  final CollectionReference<ReviewModel> modelsRef = FirebaseFirestore.instance
      .collection('reviews')
      .withConverter<ReviewModel>(
        fromFirestore: (snapshot, _) => ReviewModel.fromJson(snapshot.data()!),
        toFirestore: (user, _) => user.toJson(),
      );

  @override
  Future<ReviewModel?> get(String documentId) =>
      modelsRef.doc(documentId).get().then((s) => s.data());

  @override
  Future<List<ReviewModel>?> getAll() async {
    final snapshot = await modelsRef.get();
    final docs = snapshot.docs;

    if (docs.isNotEmpty) {
      final List<ReviewModel> users = [];
      for (int i = 0; i < docs.length; i++) {
        users.add(docs[i].data());
      }
      return users;
    }
    return null;
  }

  @override
  Future<void> add(ReviewModel reviewModel) =>
      modelsRef.doc(reviewModel.contractID).set(reviewModel);

  @override
  Future<void> update(String documentId, Map<String, dynamic> map) =>
      modelsRef.doc(documentId).update(map);

  @override
  Future<void> delete(String documentId) => modelsRef.doc(documentId).delete();
}
