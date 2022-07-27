// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contract_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContractModel _$ContractModelFromJson(Map<String, dynamic> json) =>
    ContractModel(
      id: json['id'] as String,
      jobUserName: json['jobUserName'] as String?,
      rentalAgreementLocation: json['rentalAgreementLocation'] as String?,
      rentalAgreementDate: json['rentalAgreementDate'] as String?,
      rentalAgreementUserNameFrom:
          json['rentalAgreementUserNameFrom'] as String?,
      rentalAgreementGender: json['rentalAgreementGender'] as String?,
      rentalAgreementAge: json['rentalAgreementAge'] as String?,
      rentalAgreementResiding: json['rentalAgreementResiding'] as String?,
      rentalAgreementUserAddressFrom:
          json['rentalAgreementUserAddressFrom'] as String?,
      rentalAgreementUserCityFrom:
          json['rentalAgreementUserCityFrom'] as String?,
      rentalAgreementUserAreaCodeFrom:
          json['rentalAgreementUserAreaCodeFrom'] as String?,
      rentalAgreementUserCountryFrom:
          json['rentalAgreementUserCountryFrom'] as String?,
      rentalAgreementUserCnicFrom:
          json['rentalAgreementUserCnicFrom'] as String?,
      rentalAgreementUserNameTO: json['rentalAgreementUserNameTO'] as String?,
      rentalAgreementUserGender: json['rentalAgreementUserGender'] as String?,
      rentalAgreementUserAgeTo: json['rentalAgreementUserAgeTo'] as String?,
      rentalAgreementUserResidingTo:
          json['rentalAgreementUserResidingTo'] as String?,
      rentalAgreementUserAddressTo:
          json['rentalAgreementUserAddressTo'] as String?,
      rentalAgreementUserCityTo: json['rentalAgreementUserCityTo'] as String?,
      rentalAgreementUserAreaCodeTo:
          json['rentalAgreementUserAreaCodeTo'] as String?,
      rentalAgreementUserCountryTo:
          json['rentalAgreementUserCountryTo'] as String?,
      rentalAgreementUserCnicTo: json['rentalAgreementUserCnicTo'] as String?,
      rentalAgreementUserHouse: json['rentalAgreementUserHouse'] as String?,
      rentalAgreementUserHouseBlock:
          json['rentalAgreementUserHouseBlock'] as String?,
      rentalAgreementUserHouseAddress:
          json['rentalAgreementUserHouseAddress'] as String?,
      rentalAgreementUserHouseCity:
          json['rentalAgreementUserHouseCity'] as String?,
      rentalAgreementUserHouseAreaCode:
          json['rentalAgreementUserHouseAreaCode'] as String?,
      rentalAgreementUserHouseCountry:
          json['rentalAgreementUserHouseCountry'] as String?,
      rentalAgreementUserHouseBedroom:
          json['rentalAgreementUserHouseBedroom'] as String?,
      rentalAgreementUserHouseBathroom:
          json['rentalAgreementUserHouseBathroom'] as String?,
      rentalAgreementUserHouseBalconey:
          json['rentalAgreementUserHouseBalconey'] as String?,
      rentalAgreementUserHouseCarPorch:
          json['rentalAgreementUserHouseCarPorch'] as String?,
      rentalAgreementUserHousekitchen:
          json['rentalAgreementUserHousekitchen'] as String?,
      rentalAgreementUserHouseAnyFitting:
          json['rentalAgreementUserHouseAnyFitting'] as String?,
      jobAddress: json['jobAddress'] as String?,
      jobName: json['jobName'] as String?,
      contractStatus: json['contractStatus'] as String? ?? 'Promise',
      jobCity: json['jobCity'] as String?,
      jobProvince: json['jobProvince'] as String?,
      jobPostalCode: json['jobPostalCode'] as String?,
      jobCountry: json['jobCountry'] as String?,
      jobAgreementTitle: json['jobAgreementTitle'] as String?,
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
      contractName: json['contractName'] as String,
      isReviewState: json['isReviewState'] as bool? ?? false,
      savedPlace: json['savedPlace'] as String,
      status: json['status'] as String,
      contractDetail: json['contractDetail'] == null
          ? null
          : ContractDetail.fromJson(
              json['contractDetail'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ContractModelToJson(ContractModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'contractName': instance.contractName,
      'status': instance.status,
      'contractStatus': instance.contractStatus,
      'isReviewState': instance.isReviewState,
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
      'jobUserName': instance.jobUserName,
      'jobAddress': instance.jobAddress,
      'jobName': instance.jobName,
      'jobCity': instance.jobCity,
      'jobProvince': instance.jobProvince,
      'jobPostalCode': instance.jobPostalCode,
      'jobCountry': instance.jobCountry,
      'jobAgreementTitle': instance.jobAgreementTitle,
      'rentalAgreementLocation': instance.rentalAgreementLocation,
      'rentalAgreementDate': instance.rentalAgreementDate,
      'rentalAgreementUserNameFrom': instance.rentalAgreementUserNameFrom,
      'rentalAgreementGender': instance.rentalAgreementGender,
      'rentalAgreementAge': instance.rentalAgreementAge,
      'rentalAgreementResiding': instance.rentalAgreementResiding,
      'rentalAgreementUserAddressFrom': instance.rentalAgreementUserAddressFrom,
      'rentalAgreementUserCityFrom': instance.rentalAgreementUserCityFrom,
      'rentalAgreementUserAreaCodeFrom':
          instance.rentalAgreementUserAreaCodeFrom,
      'rentalAgreementUserCountryFrom': instance.rentalAgreementUserCountryFrom,
      'rentalAgreementUserCnicFrom': instance.rentalAgreementUserCnicFrom,
      'rentalAgreementUserNameTO': instance.rentalAgreementUserNameTO,
      'rentalAgreementUserGender': instance.rentalAgreementUserGender,
      'rentalAgreementUserAgeTo': instance.rentalAgreementUserAgeTo,
      'rentalAgreementUserResidingTo': instance.rentalAgreementUserResidingTo,
      'rentalAgreementUserAddressTo': instance.rentalAgreementUserAddressTo,
      'rentalAgreementUserCityTo': instance.rentalAgreementUserCityTo,
      'rentalAgreementUserAreaCodeTo': instance.rentalAgreementUserAreaCodeTo,
      'rentalAgreementUserCountryTo': instance.rentalAgreementUserCountryTo,
      'rentalAgreementUserCnicTo': instance.rentalAgreementUserCnicTo,
      'rentalAgreementUserHouse': instance.rentalAgreementUserHouse,
      'rentalAgreementUserHouseBlock': instance.rentalAgreementUserHouseBlock,
      'rentalAgreementUserHouseAddress':
          instance.rentalAgreementUserHouseAddress,
      'rentalAgreementUserHouseCity': instance.rentalAgreementUserHouseCity,
      'rentalAgreementUserHouseAreaCode':
          instance.rentalAgreementUserHouseAreaCode,
      'rentalAgreementUserHouseCountry':
          instance.rentalAgreementUserHouseCountry,
      'rentalAgreementUserHouseBedroom':
          instance.rentalAgreementUserHouseBedroom,
      'rentalAgreementUserHouseBathroom':
          instance.rentalAgreementUserHouseBathroom,
      'rentalAgreementUserHouseBalconey':
          instance.rentalAgreementUserHouseBalconey,
      'rentalAgreementUserHouseCarPorch':
          instance.rentalAgreementUserHouseCarPorch,
      'rentalAgreementUserHousekitchen':
          instance.rentalAgreementUserHousekitchen,
      'rentalAgreementUserHouseAnyFitting':
          instance.rentalAgreementUserHouseAnyFitting,
      'contractDetail': instance.contractDetail?.toJson(),
    };

ContractDetail _$ContractDetailFromJson(Map<String, dynamic> json) =>
    ContractDetail(
      showSendOption: json['showSendOption'] as bool? ?? false,
      witness1: json['witness1'] == null
          ? null
          : WitnessSignedModel.fromJson(
              json['witness1'] as Map<String, dynamic>),
      witness2: json['witness2'] == null
          ? null
          : WitnessSignedModel.fromJson(
              json['witness2'] as Map<String, dynamic>),
      warning: json['warning'] as String?,
    );

Map<String, dynamic> _$ContractDetailToJson(ContractDetail instance) =>
    <String, dynamic>{
      'warning': instance.warning,
      'showSendOption': instance.showSendOption,
      'witness1': instance.witness1,
      'witness2': instance.witness2,
    };
