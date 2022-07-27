import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fyp/locator.dart';
import 'package:fyp/model/contract_model.dart';
import 'package:fyp/screens/job_agreement/job_agreement_screen.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

class JobProvider with ChangeNotifier {
  bool isDraft = false;
  bool isShow = false;
  void updateShow(bool data) {
    isShow = data;
    notifyListeners();
  }

  final jobUserName = TextEditingController();
  final jobAddress = TextEditingController();
  final jobName = TextEditingController();
  final jobCity = TextEditingController();
  final jobProvince = TextEditingController();
  final jobPostalCode = TextEditingController();
  final jobCountry = TextEditingController();
  final jobAgreementTitle = TextEditingController();

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
        contractName: 'Handy',
        status: 'Draft',
        contractStartDate: DateTime.now().toString(),
        contractStatus: 'Handy',
        savedPlace: JobAgreementScreen.routeName,
        jobAddress: jobAddress.text.trim(),
        jobCountry: jobCountry.text.trim(),
        jobCity: jobCity.text.trim(),
        jobProvince: jobProvince.text.trim(),
        jobAgreementTitle: jobAgreementTitle.text.trim(),
        jobUserName: jobUserName.text.trim(),
        jobPostalCode: jobPostalCode.text.trim(),
        jobName: jobName.text.trim(),
      );
      await contractRepository.add(myModel);
      await setContractPref(myModel);
      EasyLoading.dismiss();
      return;
    }
    final updateBody = {
      'id': generatedContractID,
      'contractName': 'Handy',
      'contractStatus': 'Handy',
      'savedPlace': JobAgreementScreen.routeName,
      'jobAddress': jobAddress.text.trim(),
      'jobCountry': jobCountry.text.trim(),
      'jobCity': jobCity.text.trim(),
      'jobProvince': jobProvince.text.trim(),
      'jobAgreementTitle': jobAgreementTitle.text.trim(),
      'jobUserName': jobUserName.text.trim(),
      'jobPostalCode': jobPostalCode.text.trim(),
      'jobName': jobName.text.trim(),
    };
    await contractRepository.update(contract?.id ?? '', updateBody);
    final model = await contractRepository.get(storage.id ?? '3123456789123');
    if (model != null) {
      storage.setContract(model);
    }
    EasyLoading.dismiss();
    notifyListeners();
  }

  void clearAllJobData() {
    jobUserName.clear();
    jobAddress.clear();
    jobName.clear();
    jobCity.clear();
    jobProvince.clear();
    jobPostalCode.clear();
    jobCountry.clear();
    jobAgreementTitle.clear();
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

  updateJobField() {
    final pref = storage.contract;
    jobUserName.text = pref?.jobUserName ?? '';
    jobAddress.text = pref?.jobAddress ?? '';
    jobName.text = pref?.jobName ?? '';
    jobCity.text = pref?.jobCity ?? '';
    jobProvince.text = pref?.jobProvince ?? '';
    jobPostalCode.text = pref?.jobPostalCode ?? '';
    jobCountry.text = pref?.jobCountry ?? '';
    jobAgreementTitle.text = pref?.jobAgreementTitle ?? '';
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
