import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fyp/locator.dart';
import 'package:fyp/model/contract_model.dart';
import 'package:fyp/screens/general_template/general_template_dart.dart';
import 'package:fyp/screens/promise_agreement/component/additional_screen.dart';
import 'package:fyp/screens/promise_agreement/component/penalties_screen.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

class PromiseProvider with ChangeNotifier {
  DateTime? selectedStartDate;
  DateTime? selectedEndDate;
  String? selectedTimeLineRadioValue;
  String? selectedAdditionalRadioValue;
  String? selectedPenaltiesRadioValue;
  DateTime? selectedStartDateTemplate;
  bool isDraft = false;
  bool isShow = false;
  void updateShow(bool data) {
    isShow = data;
    notifyListeners();
  }

  final nameController = TextEditingController();
  final myselfController = TextEditingController();
  final healthyController = TextEditingController();
  final conditionController = TextEditingController();
  final penaltyController = TextEditingController();
  final haveController = TextEditingController();

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

  void clearAllValue() {
    nameController.clear();
    myselfController.clear();
    healthyController.clear();
    notifyListeners();
  }

  void signed() {
    isShow = true;
    notifyListeners();
  }

  void onSelectedStartChanged(DateTime? dateTime) {
    selectedStartDate = dateTime;
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

  void onSelectedEndChanged(DateTime? dateTime) {
    selectedEndDate = dateTime;
    notifyListeners();
  }

  void onChangedTimeLineRadioValue(String? value) {
    selectedTimeLineRadioValue = value;
    notifyListeners();
  }

  void onChangedAdditionalRadioValue(String? value) {
    selectedAdditionalRadioValue = value;
    print(selectedAdditionalRadioValue);
    notifyListeners();
  }

  void onChangedPenaltiesRadioValue(String? value) {
    selectedPenaltiesRadioValue = value;
    notifyListeners();
  }

  Future<void> addPromiseAgreementData(
      String title, String savedLocation, String status) async {
    EasyLoading.show();
    ContractModel? contractModelDataId = storage.contract;

    final id =
        contractModelDataId?.id != null ? contractModelDataId!.id : uuid.v4();
    if (contractModelDataId?.id == null) {
      final contract = ContractModel(
          id: id,
          contractName: title,
          content: 'yes bro its working',
          savedPlace: savedLocation,
          status: status,
          contractDetail: ContractDetail(
            name: nameController.text.trim(),
            contractPerson: myselfController.text.trim(),
            reason: healthyController.text.trim(),
          ));
      await contractRepository.add(contract);
      setContractPref(contract);
      EasyLoading.dismiss();
      return;
    }
    final updateData = {
      'id': id,
      'contractName': title,
      'content': 'yes  its working',
      'contractDetail.name': nameController.text.trim(),
      'contractDetail.contractPerson': myselfController.text.trim(),
      'contractDetail.reason': healthyController.text.trim(),
    };

    await contractRepository.update(id, updateData);
    final dataGet = await contractRepository.get(id);
    if (dataGet != null) {
      setContractPref(dataGet);
    }
    EasyLoading.dismiss();
  }

  void updateTimeLineField() async {
    EasyLoading.show();
    final contract = storage.contract;
    if (selectedTimeLineRadioValue == 'Yes') {
      selectedEndDate = null;
    }
    final updateBody = {
      'savedPlace': AdditionalScreen.routeName,
      'contractDetail.executionDate': selectedStartDate.toString(),
      'contractDetail.endDate': selectedEndDate.toString(),
      'contractDetail.isCompletionRadio': selectedTimeLineRadioValue
    };
    await contractRepository.update(contract?.id ?? '', updateBody);
    final model = await contractRepository.get(storage.id ?? '3123456789123');
    print(model?.contractDetail?.additionalConditionsRadio);
    if (model != null) {
      storage.setContract(model);
    }
    EasyLoading.dismiss();
    notifyListeners();
  }

  void setPromiseValueDefault() {
    final contractModel = storage.contract;
    nameController.text = contractModel?.contractDetail?.name ?? '';
    myselfController.text = contractModel?.contractDetail?.contractPerson ?? '';
    healthyController.text = contractModel?.contractDetail?.reason ?? '';
  }

  void addAdditionalScreenField() async {
    EasyLoading.show();
    final contract = storage.contract;

    final update = {
      'savedPlace': PenaltiesScreen.routeName,
      'contractDetail.additionalConditionsRadio': selectedAdditionalRadioValue,
      'contractDetail.additionalCondition': selectedAdditionalRadioValue == 'No'
          ? null
          : conditionController.text.trim(),
    };
    await contractRepository.update(contract?.id ?? '', update);
    final timeModel =
        await contractRepository.get(storage.id ?? '3123456789123');
    if (timeModel != null) {
      storage.setContract(timeModel);
    }
    EasyLoading.dismiss();
    notifyListeners();
  }

  void clearTimeLineField() {
    selectedTimeLineRadioValue = null;
    selectedEndDate = null;
    selectedStartDate = null;
    notifyListeners();
  }

  void setAdditionalValue() {
    final pref = storage.contract;
    selectedAdditionalRadioValue =
        pref?.contractDetail?.additionalConditionsRadio;
    if (selectedAdditionalRadioValue == 'Yes') {
      conditionController.text =
          pref?.contractDetail?.additionalCondition ?? '';
    } else if (selectedAdditionalRadioValue == 'No') {
      conditionController.clear();
    }
  }

  void setPenaltyValues() {
    final pref = storage.contract;
    EasyLoading.show();
    selectedPenaltiesRadioValue = pref?.contractDetail?.violateContractRadio;
    if (selectedPenaltiesRadioValue == 'Pay a Monetary penalty') {
      penaltyController.text = pref?.contractDetail?.amountPenalty ?? '';
      haveController.clear();
    } else if (selectedPenaltiesRadioValue == 'Have to do') {
      haveController.text = pref?.contractDetail?.haveTodo ?? '';
      penaltyController.clear();
    } else if (selectedPenaltiesRadioValue == 'Renegotiate') {
      haveController.clear();
      penaltyController.clear();
    } else if (selectedPenaltiesRadioValue == 'Nothing') {
      haveController.clear();
      penaltyController.clear();
    }
    EasyLoading.dismiss();
  }

  void setTimeLineUpdate() {
    EasyLoading.show();
    final pref = storage.contract;
    final contract = pref?.contractDetail;
    selectedTimeLineRadioValue = contract?.isCompletionRadio;
    selectedStartDate = DateTime.parse(contract?.executionDate ?? '');
    if (selectedTimeLineRadioValue == 'No') {
      selectedEndDate = DateTime.parse(contract?.endDate ?? '');
    } else if (selectedTimeLineRadioValue == 'Yes') {
      selectedEndDate = null;
    }
    EasyLoading.dismiss();
  }

  void updatePenaltyField() async {
    EasyLoading.show();
    final contract = storage.contract;
    if (selectedPenaltiesRadioValue == 'Pay a Monetary penalty') {
      haveController.clear();
    } else if (selectedPenaltiesRadioValue == 'Have to do') {
      penaltyController.clear();
    } else if (selectedPenaltiesRadioValue == 'Renegotiate') {
      haveController.clear();
      penaltyController.clear();
    } else if (selectedPenaltiesRadioValue == 'Nothing') {
      haveController.clear();
      penaltyController.clear();
    }
    final updateBody = {
      'contractDetail.violateContractRadio': selectedPenaltiesRadioValue,
      'contractDetail.amountPenalty': penaltyController.text.trim(),
      'contractDetail.haveTodo': haveController.text.trim(),
    };
    await contractRepository.update(contract?.id ?? '', updateBody);
    final model = await contractRepository.get(storage.id ?? '3123456789123');
    if (model != null) {
      storage.setContract(model);
    }
    EasyLoading.dismiss();
    notifyListeners();
  }

  void updateGeneralTextField(String endDate) async {
    EasyLoading.show();
    final contract = storage.contract;
    final updateBody = {
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
    selectedStartDate = null;
    selectedEndDate = null;
    selectedTimeLineRadioValue = null;
    selectedAdditionalRadioValue = null;
    selectedPenaltiesRadioValue = null;
    nameController.clear();
    myselfController.clear();
    healthyController.clear();
    conditionController.clear();
    penaltyController.clear();
    haveController.clear();
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
