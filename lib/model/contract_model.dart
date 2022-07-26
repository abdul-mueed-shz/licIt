import 'package:fyp/model/local_user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'contract_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ContractModel {
  final String id;
  final String contractName;
  final String content;
  final String status;
  final String savedPlace;
  final String? contractStartDate;
  final String? contractEndDate;
  final String? userNameFrom;
  final String? userNameTo;
  final String? userAddressFrom;
  final String? userAddressTo;
  final String? userLocalityTo;
  final String? userLocalityFrom;
  final String? userCityFrom;
  final String? userProvinceFrom;
  final String? userCountryFrom;
  final String? userCityTo;
  final String? userProvinceTo;
  final String? userCountryTo;

  final ContractDetail? contractDetail;

  ContractModel({
    required this.id,
    required this.contractName,
    required this.content,
    required this.savedPlace,
    required this.status,
    this.contractDetail,
    this.contractStartDate,
    this.contractEndDate,
    this.userNameFrom,
    this.userNameTo,
    this.userAddressFrom,
    this.userAddressTo,
    this.userLocalityTo,
    this.userLocalityFrom,
    this.userCityFrom,
    this.userProvinceFrom,
    this.userCountryFrom,
    this.userCityTo,
    this.userProvinceTo,
    this.userCountryTo,
  });
  factory ContractModel.fromJson(Map<String, dynamic> json) =>
      _$ContractModelFromJson(json);

  Map<String, dynamic> toJson() => _$ContractModelToJson(this);

  @override
  String toString() {
    return 'ContractModel{id: $id, contractName: $contractName, content: $content, status: $status, savedPlace: $savedPlace, contractStartDate: $contractStartDate, contractEndDate: $contractEndDate, userNameFrom: $userNameFrom, userNameTo: $userNameTo, userAddressFrom: $userAddressFrom, userAddressTo: $userAddressTo, userLocalityTo: $userLocalityTo, userLocalityFrom: $userLocalityFrom, userCityFrom: $userCityFrom, userProvinceFrom: $userProvinceFrom, userCountryFrom: $userCountryFrom, userCityTo: $userCityTo, userProvinceTo: $userProvinceTo, userCountryTo: $userCountryTo, contractDetail: $contractDetail}';
  }
}

@JsonSerializable()
class ContractDetail {
  final String? name;
  final String? contractPerson;
  final String? reason;
  final String? executionDate;
  final String? endDate;
  final String? warning;
  final String? additionalCondition;
  final String? isCompletionRadio;
  final String? additionalConditionsRadio;
  final String? haveTodo;
  final String? violateContractRadio;
  final String? amountPenalty;
  final bool showSendOption;
  final WitnessSignedModel? witness1;
  final WitnessSignedModel? witness2;

  ContractDetail(
      {this.name,
      this.showSendOption = false,
      this.witness1,
      this.witness2,
      this.contractPerson,
      this.reason,
      this.warning,
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

  @override
  String toString() {
    return 'ContractDetail{name: $name, contractPerson: $contractPerson, reason: $reason, executionDate: $executionDate, endDate: $endDate, additionalCondition: $additionalCondition, isCompletionRadio: $isCompletionRadio, additionalConditionsRadio: $additionalConditionsRadio, haveTodo: $haveTodo, violateContractRadio: $violateContractRadio, amountPenalty: $amountPenalty}';
  }
}
