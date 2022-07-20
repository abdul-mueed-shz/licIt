import 'package:json_annotation/json_annotation.dart';

part 'local_user.g.dart';

@JsonSerializable(explicitToJson: true)
class LocalUser {
  final String name;
  final String cnicNo;
  final String phoneNumber;
  final String email;
  final String password;
  final String? token;
  final String? cnicImageUrl;
  final String? signatureImage;
  final List<ReviewIDModel> contractId;
  final List<CommentModel> comments;
  final List<WitnessShowModel> rejectWitness;
  final List<ContractDetailTab> contractDetailTab;
  final List<WitnessShowModel> signedWitness;
  final List<WitnessShowModel> witnessScreenShow;

  LocalUser(
      {required this.name,
      required this.cnicNo,
      this.rejectWitness = const [],
      this.witnessScreenShow = const [],
      this.contractDetailTab = const [],
      required this.phoneNumber,
      required this.email,
      this.signedWitness = const [],
      this.comments = const [],
      this.token,
      this.contractId = const [],
      required this.password,
      this.cnicImageUrl,
      this.signatureImage});
  factory LocalUser.fromJson(Map<String, dynamic> json) =>
      _$LocalUserFromJson(json);

  Map<String, dynamic> toJson() => _$LocalUserToJson(this);
}

@JsonSerializable()
class ReviewModel {
  final String reviewRequestId;
  final String contractID;
  final String reviewName;
  final String requestName;
  final String receiverRequestId;
  final String contractName;
  final bool user1Signed;
  final bool user2Signed;

  factory ReviewModel.fromJson(Map<String, dynamic> json) =>
      _$ReviewModelFromJson(json);

  ReviewModel(
      {required this.reviewRequestId,
      required this.contractID,
      required this.reviewName,
      required this.requestName,
      this.user1Signed = false,
      this.user2Signed = false,
      required this.receiverRequestId,
      required this.contractName});

  Map<String, dynamic> toJson() => _$ReviewModelToJson(this);
}

@JsonSerializable()
class ReviewIDModel {
  final String contractID;
  final String userName;
  final String contractName;

  ReviewIDModel(
      {required this.contractID,
      required this.userName,
      required this.contractName});

  factory ReviewIDModel.fromJson(Map<String, dynamic> json) =>
      _$ReviewIDModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewIDModelToJson(this);
}

@JsonSerializable()
class WitnessSignedModel {
  final String witnessId;
  final bool witnessSigned;
  final String? senderId;

  WitnessSignedModel({
    required this.witnessId,
    this.senderId,
    this.witnessSigned = false,
  });

  factory WitnessSignedModel.fromJson(Map<String, dynamic> json) =>
      _$WitnessSignedModelFromJson(json);

  Map<String, dynamic> toJson() => _$WitnessSignedModelToJson(this);
}

@JsonSerializable()
class WitnessShowModel {
  final bool witnessTabShow;
  final String contractID;
  final String contractIdUser;
  final String user1;
  final String contractName;
  final String user2;

  WitnessShowModel(
      {this.witnessTabShow = false,
      required this.user1,
      required this.user2,
      required this.contractName,
      required this.contractID,
      required this.contractIdUser});
  factory WitnessShowModel.fromJson(Map<String, dynamic> json) =>
      _$WitnessShowModelFromJson(json);

  Map<String, dynamic> toJson() => _$WitnessShowModelToJson(this);
}

@JsonSerializable()
class ContractDetailTab {
  final String contractID;
  final String contractName;
  final String reviewName;
  final String requestName;
  final String contractUserId;

  ContractDetailTab(
      {required this.contractID,
      required this.reviewName,
      required this.contractUserId,
      required this.requestName,
      required this.contractName});

  factory ContractDetailTab.fromJson(Map<String, dynamic> json) =>
      _$ContractDetailTabFromJson(json);

  Map<String, dynamic> toJson() => _$ContractDetailTabToJson(this);
}

@JsonSerializable()
class CommentModel {
  final String commentName;
  final String comment;

  CommentModel({required this.commentName, required this.comment});

  factory CommentModel.fromJson(Map<String, dynamic> json) =>
      _$CommentModelFromJson(json);

  Map<String, dynamic> toJson() => _$CommentModelToJson(this);
}
