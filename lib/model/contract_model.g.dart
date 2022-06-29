// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contract_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContractModel _$ContractModelFromJson(Map<String, dynamic> json) =>
    ContractModel(
      id: json['id'] as String,
      contractName: json['contractName'] as String,
      content: json['content'] as String,
      savedPlace: json['savedPlace'] as String,
      status: json['status'] as String,
      contractDetail: json['contractDetail'] == null
          ? null
          : ContractDetail.fromJson(
              json['contractDetail'] as Map<String, dynamic>),
      contractStartDate: json['contractStartDate'] as String?,
      contractEndDate: json['contractEndDate'] as String?,
      userNameFrom: json['userNameFrom'] as String?,
      userNameTo: json['userNameTo'] as String?,
      userAddressFrom: json['userAddressFrom'] as String?,
      userAddressTo: json['userAddressTo'] as String?,
      userLocalityTo: json['userLocalityTo'] as String?,
      userLocalityFrom: json['userLocalityFrom'] as String?,
      userCityFrom: json['userCityFrom'] as String?,
      userProvinceFrom: json['userProvinceFrom'] as String?,
      userCountryFrom: json['userCountryFrom'] as String?,
      userCityTo: json['userCityTo'] as String?,
      userProvinceTo: json['userProvinceTo'] as String?,
      userCountryTo: json['userCountryTo'] as String?,
    );

Map<String, dynamic> _$ContractModelToJson(ContractModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'contractName': instance.contractName,
      'content': instance.content,
      'status': instance.status,
      'savedPlace': instance.savedPlace,
      'contractStartDate': instance.contractStartDate,
      'contractEndDate': instance.contractEndDate,
      'userNameFrom': instance.userNameFrom,
      'userNameTo': instance.userNameTo,
      'userAddressFrom': instance.userAddressFrom,
      'userAddressTo': instance.userAddressTo,
      'userLocalityTo': instance.userLocalityTo,
      'userLocalityFrom': instance.userLocalityFrom,
      'userCityFrom': instance.userCityFrom,
      'userProvinceFrom': instance.userProvinceFrom,
      'userCountryFrom': instance.userCountryFrom,
      'userCityTo': instance.userCityTo,
      'userProvinceTo': instance.userProvinceTo,
      'userCountryTo': instance.userCountryTo,
      'contractDetail': instance.contractDetail?.toJson(),
    };

ContractDetail _$ContractDetailFromJson(Map<String, dynamic> json) =>
    ContractDetail(
      name: json['name'] as String?,
      showSendOption: json['showSendOption'] as bool? ?? false,
      witness1: json['witness1'] == null
          ? null
          : WitnessSignedModel.fromJson(
              json['witness1'] as Map<String, dynamic>),
      witness2: json['witness2'] == null
          ? null
          : WitnessSignedModel.fromJson(
              json['witness2'] as Map<String, dynamic>),
      contractPerson: json['contractPerson'] as String?,
      reason: json['reason'] as String?,
      warning: json['warning'] as String?,
      executionDate: json['executionDate'] as String?,
      endDate: json['endDate'] as String?,
      additionalCondition: json['additionalCondition'] as String?,
      isCompletionRadio: json['isCompletionRadio'] as String?,
      additionalConditionsRadio: json['additionalConditionsRadio'] as String?,
      haveTodo: json['haveTodo'] as String?,
      violateContractRadio: json['violateContractRadio'] as String?,
      amountPenalty: json['amountPenalty'] as String?,
    );

Map<String, dynamic> _$ContractDetailToJson(ContractDetail instance) =>
    <String, dynamic>{
      'name': instance.name,
      'contractPerson': instance.contractPerson,
      'reason': instance.reason,
      'executionDate': instance.executionDate,
      'endDate': instance.endDate,
      'warning': instance.warning,
      'additionalCondition': instance.additionalCondition,
      'isCompletionRadio': instance.isCompletionRadio,
      'additionalConditionsRadio': instance.additionalConditionsRadio,
      'haveTodo': instance.haveTodo,
      'violateContractRadio': instance.violateContractRadio,
      'amountPenalty': instance.amountPenalty,
      'showSendOption': instance.showSendOption,
      'witness1': instance.witness1,
      'witness2': instance.witness2,
    };
