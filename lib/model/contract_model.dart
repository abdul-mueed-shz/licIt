import 'package:fyp/model/local_user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'contract_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ContractModel {
  final String id;
  final String contractName;
  final String status;
  final String contractStatus;
  final bool isReviewState;
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
  final String? jobUserName;
  final String? jobAddress;
  final String? jobName;
  final String? jobCity;
  final String? jobProvince;
  final String? jobPostalCode;
  final String? jobCountry;
  final String? jobAgreementTitle;
  final String? rentalAgreementLocation;
  final String? rentalAgreementDate;
  final String? rentalAgreementUserNameFrom;
  final String? rentalAgreementGender;
  final String? rentalAgreementAge;
  final String? rentalAgreementResiding;
  final String? rentalAgreementUserAddressFrom;
  final String? rentalAgreementUserCityFrom;
  final String? rentalAgreementUserAreaCodeFrom;
  final String? rentalAgreementUserCountryFrom;
  final String? rentalAgreementUserCnicFrom;
  final String? rentalAgreementUserNameTO;
  final String? rentalAgreementUserGender;
  final String? rentalAgreementUserAgeTo;
  final String? rentalAgreementUserResidingTo;
  final String? rentalAgreementUserAddressTo;
  final String? rentalAgreementUserCityTo;
  final String? rentalAgreementUserAreaCodeTo;
  final String? rentalAgreementUserCountryTo;
  final String? rentalAgreementUserCnicTo;
  final String? rentalAgreementUserHouse;
  final String? rentalAgreementUserHouseBlock;
  final String? rentalAgreementUserHouseAddress;
  final String? rentalAgreementUserHouseCity;
  final String? rentalAgreementUserHouseAreaCode;
  final String? rentalAgreementUserHouseCountry;
  final String? rentalAgreementUserHouseBedroom;
  final String? rentalAgreementUserHouseBathroom;
  final String? rentalAgreementUserHouseBalconey;
  final String? rentalAgreementUserHouseCarPorch;
  final String? rentalAgreementUserHousekitchen;
  final String? rentalAgreementUserHouseAnyFitting;
  final ContractDetail? contractDetail;

  ContractModel({
    required this.id,
    this.jobUserName,
    this.rentalAgreementLocation,
    this.rentalAgreementDate,
    this.rentalAgreementUserNameFrom,
    this.rentalAgreementGender,
    this.rentalAgreementAge,
    this.rentalAgreementResiding,
    this.rentalAgreementUserAddressFrom,
    this.rentalAgreementUserCityFrom,
    this.rentalAgreementUserAreaCodeFrom,
    this.rentalAgreementUserCountryFrom,
    this.rentalAgreementUserCnicFrom,
    this.rentalAgreementUserNameTO,
    this.rentalAgreementUserGender,
    this.rentalAgreementUserAgeTo,
    this.rentalAgreementUserResidingTo,
    this.rentalAgreementUserAddressTo,
    this.rentalAgreementUserCityTo,
    this.rentalAgreementUserAreaCodeTo,
    this.rentalAgreementUserCountryTo,
    this.rentalAgreementUserCnicTo,
    this.rentalAgreementUserHouse,
    this.rentalAgreementUserHouseBlock,
    this.rentalAgreementUserHouseAddress,
    this.rentalAgreementUserHouseCity,
    this.rentalAgreementUserHouseAreaCode,
    this.rentalAgreementUserHouseCountry,
    this.rentalAgreementUserHouseBedroom,
    this.rentalAgreementUserHouseBathroom,
    this.rentalAgreementUserHouseBalconey,
    this.rentalAgreementUserHouseCarPorch,
    this.rentalAgreementUserHousekitchen,
    this.rentalAgreementUserHouseAnyFitting,
    this.jobAddress,
    this.jobName,
    this.contractStatus = 'Promise',
    this.jobCity,
    this.jobProvince,
    this.jobPostalCode,
    this.jobCountry,
    this.jobAgreementTitle,
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
    required this.contractName,
    this.isReviewState = false,
    required this.savedPlace,
    required this.status,
    this.contractDetail,
  });
  factory ContractModel.fromJson(Map<String, dynamic> json) =>
      _$ContractModelFromJson(json);

  Map<String, dynamic> toJson() => _$ContractModelToJson(this);
}

@JsonSerializable()
class ContractDetail {
  final String? warning;
  final bool showSendOption;
  final WitnessSignedModel? witness1;
  final WitnessSignedModel? witness2;

  ContractDetail({
    this.showSendOption = false,
    this.witness1,
    this.witness2,
    this.warning,
  });

  factory ContractDetail.fromJson(Map<String, dynamic> json) =>
      _$ContractDetailFromJson(json);

  Map<String, dynamic> toJson() => _$ContractDetailToJson(this);
}

enum Status { pending, active, delete, rejected, draft }

extension StatusValue on Status {
  String get value {
    switch (this) {
      case Status.active:
        return 'Active';
      case Status.pending:
        return 'Pending';
      case Status.delete:
        return 'Delete';
      case Status.rejected:
        return 'Rejected';
      case Status.draft:
        return 'Draft';
    }
  }
}
