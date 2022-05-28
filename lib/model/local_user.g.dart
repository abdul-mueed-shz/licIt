// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocalUser _$LocalUserFromJson(Map<String, dynamic> json) => LocalUser(
      name: json['name'] as String,
      cnicNo: json['cnicNo'] as String,
      phoneNumber: json['phoneNumber'] as String,
      email: json['email'] as String,
      token: json['token'] as String?,
      allContractId: (json['allContractId'] as List<dynamic>?)
              ?.map((e) => e as String)
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
      'allContractId': instance.allContractId,
    };
