import 'package:json_annotation/json_annotation.dart';

part 'my_response_model.g.dart';

@JsonSerializable()
class MyApiResponse {
  final String message;
  final int code;

  MyApiResponse({
    required this.message,
    required this.code,
  });
  factory MyApiResponse.fromJson(Map<String, dynamic> json) =>
      _$MyApiResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MyApiResponseToJson(this);
}
