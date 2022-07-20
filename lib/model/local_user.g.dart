// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocalUser _$LocalUserFromJson(Map<String, dynamic> json) => LocalUser(
      name: json['name'] as String,
      cnicNo: json['cnicNo'] as String,
      rejectWitness: (json['rejectWitness'] as List<dynamic>?)
              ?.map((e) => WitnessShowModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      witnessScreenShow: (json['witnessScreenShow'] as List<dynamic>?)
              ?.map((e) => WitnessShowModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      contractDetailTab: (json['contractDetailTab'] as List<dynamic>?)
              ?.map(
                  (e) => ContractDetailTab.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      phoneNumber: json['phoneNumber'] as String,
      email: json['email'] as String,
      signedWitness: (json['signedWitness'] as List<dynamic>?)
              ?.map((e) => WitnessShowModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      comments: (json['comments'] as List<dynamic>?)
              ?.map((e) => CommentModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      token: json['token'] as String?,
      contractId: (json['contractId'] as List<dynamic>?)
              ?.map((e) => ReviewIDModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      password: json['password'] as String,
      cnicImageUrl: json['cnicImageUrl'] as String?,
      signatureImage: json['signatureImage'] as String?,
    );

Map<String, dynamic> _$LocalUserToJson(LocalUser instance) => <String, dynamic>{
      'name': instance.name,
      'cnicNo': instance.cnicNo,
      'phoneNumber': instance.phoneNumber,
      'email': instance.email,
      'password': instance.password,
      'token': instance.token,
      'cnicImageUrl': instance.cnicImageUrl,
      'signatureImage': instance.signatureImage,
      'contractId': instance.contractId.map((e) => e.toJson()).toList(),
      'comments': instance.comments.map((e) => e.toJson()).toList(),
      'rejectWitness': instance.rejectWitness.map((e) => e.toJson()).toList(),
      'contractDetailTab':
          instance.contractDetailTab.map((e) => e.toJson()).toList(),
      'signedWitness': instance.signedWitness.map((e) => e.toJson()).toList(),
      'witnessScreenShow':
          instance.witnessScreenShow.map((e) => e.toJson()).toList(),
    };

ReviewModel _$ReviewModelFromJson(Map<String, dynamic> json) => ReviewModel(
      reviewRequestId: json['reviewRequestId'] as String,
      contractID: json['contractID'] as String,
      reviewName: json['reviewName'] as String,
      requestName: json['requestName'] as String,
      user1Signed: json['user1Signed'] as bool? ?? false,
      user2Signed: json['user2Signed'] as bool? ?? false,
      receiverRequestId: json['receiverRequestId'] as String,
      contractName: json['contractName'] as String,
    );

Map<String, dynamic> _$ReviewModelToJson(ReviewModel instance) =>
    <String, dynamic>{
      'reviewRequestId': instance.reviewRequestId,
      'contractID': instance.contractID,
      'reviewName': instance.reviewName,
      'requestName': instance.requestName,
      'receiverRequestId': instance.receiverRequestId,
      'contractName': instance.contractName,
      'user1Signed': instance.user1Signed,
      'user2Signed': instance.user2Signed,
    };

ReviewIDModel _$ReviewIDModelFromJson(Map<String, dynamic> json) =>
    ReviewIDModel(
      contractID: json['contractID'] as String,
      userName: json['userName'] as String,
      contractName: json['contractName'] as String,
    );

Map<String, dynamic> _$ReviewIDModelToJson(ReviewIDModel instance) =>
    <String, dynamic>{
      'contractID': instance.contractID,
      'userName': instance.userName,
      'contractName': instance.contractName,
    };

WitnessSignedModel _$WitnessSignedModelFromJson(Map<String, dynamic> json) =>
    WitnessSignedModel(
      witnessId: json['witnessId'] as String,
      senderId: json['senderId'] as String?,
      witnessSigned: json['witnessSigned'] as bool? ?? false,
    );

Map<String, dynamic> _$WitnessSignedModelToJson(WitnessSignedModel instance) =>
    <String, dynamic>{
      'witnessId': instance.witnessId,
      'witnessSigned': instance.witnessSigned,
      'senderId': instance.senderId,
    };

WitnessShowModel _$WitnessShowModelFromJson(Map<String, dynamic> json) =>
    WitnessShowModel(
      witnessTabShow: json['witnessTabShow'] as bool? ?? false,
      user1: json['user1'] as String,
      user2: json['user2'] as String,
      contractName: json['contractName'] as String,
      contractID: json['contractID'] as String,
      contractIdUser: json['contractIdUser'] as String,
    );

Map<String, dynamic> _$WitnessShowModelToJson(WitnessShowModel instance) =>
    <String, dynamic>{
      'witnessTabShow': instance.witnessTabShow,
      'contractID': instance.contractID,
      'contractIdUser': instance.contractIdUser,
      'user1': instance.user1,
      'contractName': instance.contractName,
      'user2': instance.user2,
    };

ContractDetailTab _$ContractDetailTabFromJson(Map<String, dynamic> json) =>
    ContractDetailTab(
      contractID: json['contractID'] as String,
      reviewName: json['reviewName'] as String,
      contractUserId: json['contractUserId'] as String,
      requestName: json['requestName'] as String,
      contractName: json['contractName'] as String,
    );

Map<String, dynamic> _$ContractDetailTabToJson(ContractDetailTab instance) =>
    <String, dynamic>{
      'contractID': instance.contractID,
      'contractName': instance.contractName,
      'reviewName': instance.reviewName,
      'requestName': instance.requestName,
      'contractUserId': instance.contractUserId,
    };

CommentModel _$CommentModelFromJson(Map<String, dynamic> json) => CommentModel(
      commentName: json['commentName'] as String,
      comment: json['comment'] as String,
    );

Map<String, dynamic> _$CommentModelToJson(CommentModel instance) =>
    <String, dynamic>{
      'commentName': instance.commentName,
      'comment': instance.comment,
    };
