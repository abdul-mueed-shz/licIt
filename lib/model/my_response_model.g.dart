// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyApiResponse _$MyApiResponseFromJson(Map<String, dynamic> json) =>
    MyApiResponse(
      message: json['message'] as String,
      code: json['code'] as int,
    );

Map<String, dynamic> _$MyApiResponseToJson(MyApiResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'code': instance.code,
    };
