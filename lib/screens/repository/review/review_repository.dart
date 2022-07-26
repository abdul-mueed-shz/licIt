import 'package:fyp/model/local_user.dart';

abstract class IReviewRepository {
  Future<ReviewModel?> get(String documentId);
  Future<List<ReviewModel>?> getAll();
  Future<void> add(ReviewModel user);
  Future<void> update(String documentId, Map<String, dynamic> map);
  Future<void> delete(String documentId);
}
