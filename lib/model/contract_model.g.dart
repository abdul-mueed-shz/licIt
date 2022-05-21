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
      state: json['state'] as String?,
      contractDetail: json['contractDetail'] == null
          ? null
          : ContractDetail.fromJson(
              json['contractDetail'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ContractModelToJson(ContractModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'contractName': instance.contractName,
      'content': instance.content,
      'state': instance.state,
      'status': instance.status,
      'savedPlace': instance.savedPlace,
      'contractDetail': instance.contractDetail?.toJson(),
    };

ContractDetail _$ContractDetailFromJson(Map<String, dynamic> json) =>
    ContractDetail(
      name: json['name'] as String?,
      contractPerson: json['contractPerson'] as String?,
      reason: json['reason'] as String?,
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
      'additionalCondition': instance.additionalCondition,
      'isCompletionRadio': instance.isCompletionRadio,
      'additionalConditionsRadio': instance.additionalConditionsRadio,
      'haveTodo': instance.haveTodo,
      'violateContractRadio': instance.violateContractRadio,
      'amountPenalty': instance.amountPenalty,
    };
