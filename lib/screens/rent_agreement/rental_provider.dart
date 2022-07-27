import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fyp/locator.dart';
import 'package:fyp/model/contract_model.dart';
import 'package:fyp/screens/rent_agreement/rent_agreement_screen.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

class RentalProvider with ChangeNotifier {
  DateTime? selectedStartDateTemplate;
  bool isDraft = false;
  bool isShow = false;
  void updateShow(bool data) {
    isShow = data;
    notifyListeners();
  }

  final rentalAgreementLocation = TextEditingController();
  final rentalAgreementDate = TextEditingController();
  final rentalAgreementUserNameFrom = TextEditingController();
  final rentalAgreementGender = TextEditingController();
  final rentalAgreementAge = TextEditingController();
  final rentalAgreementResiding = TextEditingController();
  final rentalAgreementUserAddressFrom = TextEditingController();
  final rentalAgreementUserCityFrom = TextEditingController();
  final rentalAgreementUserAreaCodeFrom = TextEditingController();
  final rentalAgreementUserCountryFrom = TextEditingController();
  final rentalAgreementUserCnicFrom = TextEditingController();
  final rentalAgreementUserNameTO = TextEditingController();
  final rentalAgreementUserGender = TextEditingController();
  final rentalAgreementUserAgeTo = TextEditingController();
  final rentalAgreementUserResidingTo = TextEditingController();
  final rentalAgreementUserAddressTo = TextEditingController();
  final rentalAgreementUserCityTo = TextEditingController();
  final rentalAgreementUserAreaCodeTo = TextEditingController();
  final rentalAgreementUserCountryTo = TextEditingController();
  final rentalAgreementUserCnicTo = TextEditingController();
  final rentalAgreementUserHouse = TextEditingController();
  final rentalAgreementUserHouseBlock = TextEditingController();
  final rentalAgreementUserHouseAddress = TextEditingController();
  final rentalAgreementUserHouseCity = TextEditingController();
  final rentalAgreementUserHouseAreaCode = TextEditingController();
  final rentalAgreementUserHouseCountry = TextEditingController();
  final rentalAgreementUserHouseBedroom = TextEditingController();
  final rentalAgreementUserHouseBathroom = TextEditingController();
  final rentalAgreementUserHouseBalconey = TextEditingController();
  final rentalAgreementUserHouseCarPorch = TextEditingController();
  final rentalAgreementUserHousekitchen = TextEditingController();
  final rentalAgreementUserHouseAnyFitting = TextEditingController();

  final uuid = const Uuid();

  void signed() {
    isShow = true;
    notifyListeners();
  }

  Future<void> setContractPref(ContractModel contractDataModel) async {
    await storage.setContract(contractDataModel);
    notifyListeners();
  }

  void updateGeneralTextField() async {
    EasyLoading.show();
    final contract = storage.contract;
    final generatedContractID = contract?.id != null ? contract!.id : uuid.v4();
    if (contract?.id == null) {
      final myModel = ContractModel(
          id: generatedContractID,
          contractName: 'Rental',
          savedPlace: RentAgreementScreen.routeName,
          status: 'Draft',
          rentalAgreementLocation: rentalAgreementLocation.text.trim(),
          rentalAgreementAge: rentalAgreementAge.text.trim(),
          rentalAgreementDate: rentalAgreementDate.text.trim().toString(),
          rentalAgreementGender: rentalAgreementGender.text.trim(),
          rentalAgreementResiding: rentalAgreementResiding.text.trim(),
          rentalAgreementUserAddressFrom:
              rentalAgreementUserAddressFrom.text.trim(),
          rentalAgreementUserAddressTo:
              rentalAgreementUserAddressTo.text.trim(),
          rentalAgreementUserAgeTo: rentalAgreementUserAgeTo.text.trim(),
          rentalAgreementUserAreaCodeFrom:
              rentalAgreementUserAreaCodeFrom.text.trim(),
          rentalAgreementUserResidingTo:
              rentalAgreementUserResidingTo.text.trim(),
          rentalAgreementUserAreaCodeTo:
              rentalAgreementUserAreaCodeTo.text.trim(),
          rentalAgreementUserCityFrom: rentalAgreementUserCityFrom.text.trim(),
          rentalAgreementUserCityTo: rentalAgreementUserCityTo.text.trim(),
          rentalAgreementUserCnicFrom: rentalAgreementUserCnicFrom.text.trim(),
          rentalAgreementUserCnicTo: rentalAgreementUserCnicTo.text.trim(),
          rentalAgreementUserCountryFrom:
              rentalAgreementUserCountryFrom.text.trim(),
          rentalAgreementUserCountryTo:
              rentalAgreementUserCountryTo.text.trim(),
          rentalAgreementUserGender: rentalAgreementUserGender.text.trim(),
          rentalAgreementUserHouse: rentalAgreementUserHouse.text.trim(),
          rentalAgreementUserHouseAddress:
              rentalAgreementUserHouseAddress.text.trim(),
          rentalAgreementUserHouseAnyFitting:
              rentalAgreementUserHouseAnyFitting.text.trim(),
          rentalAgreementUserHouseAreaCode:
              rentalAgreementUserHouseAreaCode.text.trim(),
          rentalAgreementUserHouseBalconey:
              rentalAgreementUserHouseBalconey.text.trim(),
          rentalAgreementUserHouseBathroom:
              rentalAgreementUserHouseBathroom.text.trim(),
          rentalAgreementUserHouseBedroom:
              rentalAgreementUserHouseBedroom.text.trim(),
          rentalAgreementUserHouseBlock:
              rentalAgreementUserHouseBlock.text.trim(),
          rentalAgreementUserHouseCarPorch:
              rentalAgreementUserHouseCarPorch.text.trim(),
          rentalAgreementUserHouseCity:
              rentalAgreementUserHouseCity.text.trim(),
          rentalAgreementUserHouseCountry:
              rentalAgreementUserHouseCountry.text.trim(),
          rentalAgreementUserHousekitchen:
              rentalAgreementUserHousekitchen.text.trim(),
          rentalAgreementUserNameFrom: rentalAgreementUserNameFrom.text.trim(),
          rentalAgreementUserNameTO: rentalAgreementUserNameTO.text.trim());
      await contractRepository.add(myModel);
      await setContractPref(myModel);
      EasyLoading.dismiss();
      return;
    }

    final updateBody = {
      'id': generatedContractID,
      'contractStartDate': selectedStartDateTemplate.toString(),
      'rentalAgreementLocation': rentalAgreementLocation.text.trim(),
      'rentalAgreementAge': rentalAgreementAge.text.trim(),
      'rentalAgreementDate': rentalAgreementDate.text.trim().toString(),
      'rentalAgreementGender': rentalAgreementGender.text.trim(),
      'rentalAgreementResiding': rentalAgreementResiding.text.trim(),
      'rentalAgreementUserAddressFrom':
          rentalAgreementUserAddressFrom.text.trim(),
      'rentalAgreementUserAddressTo': rentalAgreementUserAddressTo.text.trim(),
      'rentalAgreementUserAgeTo': rentalAgreementUserAgeTo.text.trim(),
      'rentalAgreementUserAreaCodeFrom':
          rentalAgreementUserAreaCodeFrom.text.trim(),
      'rentalAgreementUserResidingTo':
          rentalAgreementUserResidingTo.text.trim(),
      'rentalAgreementUserAreaCodeTo':
          rentalAgreementUserAreaCodeTo.text.trim(),
      'rentalAgreementUserCityFrom': rentalAgreementUserCityFrom.text.trim(),
      'rentalAgreementUserCityTo': rentalAgreementUserCityTo.text.trim(),
      'rentalAgreementUserCnicFrom': rentalAgreementUserCnicFrom.text.trim(),
      'rentalAgreementUserCnicTo': rentalAgreementUserCnicTo.text.trim(),
      'rentalAgreementUserCountryFrom':
          rentalAgreementUserCountryFrom.text.trim(),
      'rentalAgreementUserCountryTo': rentalAgreementUserCountryTo.text.trim(),
      'rentalAgreementUserGender': rentalAgreementUserGender.text.trim(),
      'rentalAgreementUserHouse': rentalAgreementUserHouse.text.trim(),
      'rentalAgreementUserHouseAddress':
          rentalAgreementUserHouseAddress.text.trim(),
      'rentalAgreementUserHouseAnyFitting':
          rentalAgreementUserHouseAnyFitting.text.trim(),
      'rentalAgreementUserHouseAreaCode':
          rentalAgreementUserHouseAreaCode.text.trim(),
      'rentalAgreementUserHouseBalconey':
          rentalAgreementUserHouseBalconey.text.trim(),
      'rentalAgreementUserHouseBathroom':
          rentalAgreementUserHouseBathroom.text.trim(),
      'rentalAgreementUserHouseBedroom':
          rentalAgreementUserHouseBedroom.text.trim(),
      'rentalAgreementUserHouseBlock':
          rentalAgreementUserHouseBlock.text.trim(),
      'rentalAgreementUserHouseCarPorch':
          rentalAgreementUserHouseCarPorch.text.trim(),
      'rentalAgreementUserHouseCity': rentalAgreementUserHouseCity.text.trim(),
      'rentalAgreementUserHouseCountry':
          rentalAgreementUserHouseCountry.text.trim(),
      'rentalAgreementUserHousekitchen':
          rentalAgreementUserHousekitchen.text.trim(),
      'rentalAgreementUserNameFrom': rentalAgreementUserNameFrom.text.trim(),
      'rentalAgreementUserNameTO': rentalAgreementUserNameTO.text.trim()
    };
    await contractRepository.update(contract?.id ?? '', updateBody);
    final model = await contractRepository.get(storage.id ?? '3123456789123');
    if (model != null) {
      storage.setContract(model);
    }
    EasyLoading.dismiss();
    notifyListeners();
  }

  void clearAllData() {
    rentalAgreementLocation.clear();
    rentalAgreementUserNameFrom;
    rentalAgreementGender.clear();
    rentalAgreementAge.clear();
    rentalAgreementResiding.clear();
    rentalAgreementUserAddressFrom.clear();
    rentalAgreementUserCityFrom.clear();
    rentalAgreementUserAreaCodeFrom.clear();
    rentalAgreementUserCountryFrom.clear();
    rentalAgreementUserCnicFrom.clear();
    rentalAgreementUserNameTO.clear();
    rentalAgreementUserGender.clear();
    rentalAgreementUserAgeTo.clear();
    rentalAgreementUserResidingTo.clear();
    rentalAgreementUserAddressTo.clear();
    rentalAgreementUserCityTo.clear();
    rentalAgreementUserAreaCodeTo.clear();
    rentalAgreementUserCountryTo.clear();
    rentalAgreementUserCnicTo.clear();
    rentalAgreementUserHouse.clear();
    rentalAgreementUserHouseBlock.clear();
    rentalAgreementUserHouseAddress.clear();
    rentalAgreementUserHouseCity.clear();
    rentalAgreementUserHouseAreaCode.clear();
    rentalAgreementUserHouseCountry.clear();
    rentalAgreementUserHouseBedroom.clear();
    rentalAgreementUserHouseBathroom.clear();
    rentalAgreementUserHouseBalconey.clear();
    rentalAgreementUserHouseCarPorch.clear();
    rentalAgreementUserHousekitchen.clear();
    rentalAgreementUserHouseAnyFitting.clear();
    notifyListeners();
  }

  Future<String> getDeviceTokenToSendNotification() async {
    final token = await FirebaseMessaging.instance.getToken();
    print("Token Value $token");
    return token.toString();
  }

  Future<void> send(String token, String body, String title) async {
    final requestUrl = Uri.parse('https://fcm.googleapis.com/fcm/send');
    final headerMap = {
      'Content-Type': 'application/json',
      'Authorization':
          'key=AAAAPZfnkzY:APA91bHZ_WaFJymlWrMuNjvyX0RjC87li0HXZTO2g975YnX-on_NSmIYzWmTmlH6iM5iIS4nI_GBohfsL5qkz2mWd83m2Cw2j8IlQ4vMkM_3Idj1llGm4IXCL1e-Hq9J1qFYbo30ubtM',
    };
    final bodyMap = {
      'to': token,
      'notification': {
        'priority': 'high',
        "body": body,
        "title": title,
        "android_channel_id": "licitnotification",
      },
    };
    final response = await http.post(requestUrl,
        body: jsonEncode(bodyMap), headers: headerMap);
    final responseBody = jsonDecode(response.body);
    print(responseBody);
  }

  Future<bool> deleteStatus(BuildContext context) async {
    final contractModel = storage.contract;
    if (contractModel != null && contractModel.id.isNotEmpty) {
      final updatedContract = {'status': 'Delete'};
      await contractRepository.update(contractModel.id, updatedContract);
      return true;
    } else {
      return false;
    }
  }
}
