import 'package:fyp/util/pref.dart';
import 'package:json_annotation/json_annotation.dart';

part 'contract_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ContractModel {
  final String id;
  final String contractName;
  final String content;
  final String? state;
  final String status;
  final String savedPlace;
  final ContractDetail? contractDetail;
  static String getId() {
    return Prefs.instance.getLoginUserId() ?? '3123456789123';
  }

  ContractModel({
    required this.id,
    required this.contractName,
    required this.content,
    required this.savedPlace,
    required this.status,
    this.state,
    this.contractDetail,
  });
  factory ContractModel.fromJson(Map<String, dynamic> json) =>
      _$ContractModelFromJson(json);

  Map<String, dynamic> toJson() => _$ContractModelToJson(this);
}

@JsonSerializable()
class ContractDetail {
  final String? name;
  final String? contractPerson;
  final String? reason;
  final String? executionDate;
  final String? endDate;
  final String? additionalCondition;
  final String? isCompletionRadio;
  final String? additionalConditionsRadio;
  final String? haveTodo;
  final String? violateContractRadio;
  final String? amountPenalty;

  ContractDetail(
      {this.name,
      this.contractPerson,
      this.reason,
      this.executionDate,
      this.endDate,
      this.additionalCondition,
      this.isCompletionRadio,
      this.additionalConditionsRadio,
      this.haveTodo,
      this.violateContractRadio,
      this.amountPenalty});

  factory ContractDetail.fromJson(Map<String, dynamic> json) =>
      _$ContractDetailFromJson(json);

  Map<String, dynamic> toJson() => _$ContractDetailToJson(this);
}
