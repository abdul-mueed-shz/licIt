import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fyp/locator.dart';
import 'package:fyp/model/contract_model.dart';
import 'package:fyp/screens/general_template/general_template_dart.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

class PromiseProvider with ChangeNotifier {
  DateTime? selectedStartDateTemplate;
  bool isDraft = false;
  bool isShow = false;
  void updateShow(bool data) {
    isShow = data;
    notifyListeners();
  }

  final templateUserNameFrom = TextEditingController();
  final templateNameUserTo = TextEditingController();
  final templateUserAddressFrom = TextEditingController();
  final templateUserAddressTo = TextEditingController();
  final templateUserLocalityTo = TextEditingController();
  final templateUserLocalityFrom = TextEditingController();
  final templateUserCityFrom = TextEditingController();
  final templateUserCityTo = TextEditingController();
  final templateUserProvinceTo = TextEditingController();
  final templateUserProvinceFrom = TextEditingController();
  final templateUserCountryFrom = TextEditingController();
  final templateUserCountryTo = TextEditingController();
  final templateUserEndYear = TextEditingController();

  final uuid = const Uuid();

  void signed() {
    isShow = true;
    notifyListeners();
  }

  void onStartTemplateSelectedDate(DateTime? dateTime) {
    selectedStartDateTemplate = dateTime;
    notifyListeners();
  }

  void setContractPref(ContractModel contractDataModel) async {
    await storage.setContract(contractDataModel);
    notifyListeners();
  }

  void updateGeneralTextField(String endDate) async {
    EasyLoading.show();
    final contract = storage.contract;
    final generatedContractID = contract?.id != null ? contract!.id : uuid.v4();
    if (contract?.id == null) {
      final myModel = ContractModel(
        id: generatedContractID,
        contractName: 'Promise',
        status: 'Draft',
        userLocalityFrom: templateUserLocalityFrom.text.trim(),
        savedPlace: GeneralTemplate.routeName,
        userNameTo: templateNameUserTo.text.trim(),
        userCountryFrom: templateUserCountryFrom.text.trim(),
        userCityFrom: templateUserCityFrom.text.trim(),
        contractEndDate: endDate,
        userProvinceTo: templateUserProvinceTo.text.trim(),
        userCityTo: templateUserCityTo.text.trim(),
        userLocalityTo: templateUserLocalityTo.text.trim(),
        userCountryTo: templateUserCountryTo.text.trim(),
        userNameFrom: templateUserNameFrom.text.trim(),
        userProvinceFrom: templateUserProvinceFrom.text.trim(),
        userAddressTo: templateUserAddressTo.text.trim(),
        contractStartDate: selectedStartDateTemplate.toString(),
        userAddressFrom: templateUserAddressFrom.text.trim(),
      );
      await contractRepository.add(myModel);
      setContractPref(myModel);
      EasyLoading.dismiss();
      return;
    }
    final updateBody = {
      'id': generatedContractID,
      'savedPlace': GeneralTemplate.routeName,
      'userNameFrom': templateUserNameFrom.text.trim(),
      'userNameTo': templateNameUserTo.text.trim(),
      'userAddressFrom': templateUserAddressFrom.text.trim(),
      'userAddressTo': templateUserAddressTo.text.trim(),
      'userLocalityTo': templateUserLocalityTo.text.trim(),
      'userLocalityFrom': templateUserLocalityFrom.text.trim(),
      'userCityFrom': templateUserCityFrom.text.trim(),
      'userProvinceFrom': templateUserProvinceFrom.text.trim(),
      'userCountryFrom': templateUserCountryFrom.text.trim(),
      'userCityTo': templateUserCityTo.text.trim(),
      'userProvinceTo': templateUserProvinceTo.text.trim(),
      'userCountryTo': templateUserCountryTo.text.trim(),
      'contractStartDate': selectedStartDateTemplate.toString(),
      'contractEndDate': endDate
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
    templateUserNameFrom.clear();
    templateNameUserTo.clear();
    templateUserAddressFrom.clear();
    templateUserAddressTo.clear();
    templateUserLocalityTo.clear();
    templateUserLocalityFrom.clear();
    templateUserCityFrom.clear();
    templateUserCityTo.clear();
    templateUserProvinceTo.clear();
    templateUserProvinceFrom.clear();
    templateUserCountryFrom.clear();
    templateUserCountryTo.clear();
    templateUserEndYear.clear();
    selectedStartDateTemplate = null;
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

  updateTemplateField() {
    final pref = storage.contract;
    selectedStartDateTemplate = DateTime.parse(pref?.contractStartDate ?? '');
    templateUserNameFrom.text = pref?.userNameFrom ?? '';
    templateNameUserTo.text = pref?.userNameTo ?? '';
    templateUserAddressFrom.text = pref?.userAddressFrom ?? '';
    templateUserAddressTo.text = pref?.userAddressTo ?? '';
    templateUserLocalityTo.text = pref?.userLocalityTo ?? '';
    templateUserLocalityFrom.text = pref?.userLocalityFrom ?? '';
    templateUserCityFrom.text = pref?.userCityFrom ?? '';
    templateUserCityTo.text = pref?.userCityTo ?? '';
    templateUserProvinceTo.text = pref?.userProvinceTo ?? '';
    templateUserProvinceFrom.text = pref?.userProvinceFrom ?? '';
    templateUserCountryFrom.text = pref?.userCountryFrom ?? '';
    templateUserCountryTo.text = pref?.userCountryTo ?? '';
    final dateStartCal = DateTime.parse(pref?.contractStartDate ?? '');
    final dateEndCal = DateTime.parse(pref?.contractEndDate ?? '');
    final calculateDate = dateEndCal.difference(dateStartCal);
    final duration = calculateDate.inDays ~/ 365;

    templateUserEndYear.text = duration.toString();
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
