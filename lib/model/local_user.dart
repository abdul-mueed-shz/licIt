import 'package:fyp/model/contract_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'local_user.g.dart';

@JsonSerializable()
class LocalUser {
  final String name;
  final String cnicNo;
  final String phoneNumber;
  final String email;
  final String password;
  final String? cnicImageUrl;
  final String? signatureImage;

  LocalUser(
      {required this.name,
      required this.cnicNo,
      required this.phoneNumber,
      required this.email,
      required this.password,
      this.cnicImageUrl,
      this.signatureImage});
  factory LocalUser.fromJson(Map<String, dynamic> json) =>
      _$LocalUserFromJson(json);

  Map<String, dynamic> toJson() => _$LocalUserToJson(this);
}
