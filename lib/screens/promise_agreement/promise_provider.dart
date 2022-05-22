import 'package:flutter/material.dart';
import 'package:fyp/locator.dart';
import 'package:fyp/model/contract_model.dart';
import 'package:fyp/screens/promise_agreement/component/additional_screen.dart';
import 'package:fyp/screens/promise_agreement/component/penalties_screen.dart';
import 'package:fyp/screens/promise_agreement/promise_agreement.dart';
import 'package:fyp/util/pref.dart';
import 'package:uuid/uuid.dart';

class PromiseProvider with ChangeNotifier {
  DateTime? selectedStartDate;
  DateTime? selectedEndDate;
  String? selectedTimeLineRadioValue;
  String? selectedAdditionalRadioValue;
  String? selectedPenaltiesRadioValue;
  final nameController = TextEditingController();
  final myselfController = TextEditingController();
  final healthyController = TextEditingController();
  final conditionController = TextEditingController();
  final penaltyController = TextEditingController();
  final haveController = TextEditingController();
  final uuid = const Uuid();

  void setPromiseValueDefault() {
    final contractModel = Prefs.instance.contract;
    nameController.text = contractModel?.contractDetail?.name ?? '';
    myselfController.text = contractModel?.contractDetail?.contractPerson ?? '';
    healthyController.text = contractModel?.contractDetail?.reason ?? '';
  }

  void clearAllValue() {
    nameController.clear();
    myselfController.clear();
    healthyController.clear();
    notifyListeners();
  }

  void onSelectedStartChanged(DateTime? dateTime) {
    selectedStartDate = dateTime;
    notifyListeners();
  }

  void setContractPref(ContractModel contractDataModel) async {
    await Prefs.instance.setContract(contractDataModel);
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

  Future<ContractModel?> addPromiseAgreementData(
      String title, String savedLocation, String status) async {
    ContractModel? contractModelDataId = Prefs.instance.contract;

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
      Prefs.instance.setContract(contract);
      notifyListeners();
      return contract;
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
      Prefs.instance.setContract(dataGet);
      return dataGet;
    }
    return null;
  }

  void updateTimeLineField() async {
    final contract = Prefs.instance.contract;
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
    final model = await contractRepository
        .get(Prefs.instance.getLoginUserId() ?? '3123456789123');
    print(model?.contractDetail?.additionalConditionsRadio);
    if (model != null) {
      Prefs.instance.setContract(model);
    }
    notifyListeners();
  }

  void addAdditionalScreenField() async {
    final contract = Prefs.instance.contract;

    final update = {
      'savedPlace': PenaltiesScreen.routeName,
      'contractDetail.additionalConditionsRadio': selectedAdditionalRadioValue,
      'contractDetail.additionalCondition': selectedAdditionalRadioValue == 'No'
          ? null
          : conditionController.text.trim(),
    };
    await contractRepository.update(contract?.id ?? '', update);
    final timeModel = await contractRepository
        .get(Prefs.instance.getLoginUserId() ?? '3123456789123');
    if (timeModel != null) {
      Prefs.instance.setContract(timeModel);
    }
    notifyListeners();
  }

  void clearTimeLineField() {
    selectedTimeLineRadioValue = null;
    selectedEndDate = null;
    selectedStartDate = null;
    notifyListeners();
  }

  void setAdditionalValue() {
    final pref = Prefs.instance.contract;
    selectedAdditionalRadioValue =
        pref?.contractDetail?.additionalConditionsRadio;
    if (selectedAdditionalRadioValue == 'Yes') {
      conditionController.text =
          pref?.contractDetail?.additionalCondition ?? '';
    } else if (selectedAdditionalRadioValue == 'No') {
      conditionController.clear();
    }
    notifyListeners();
  }

  void setTimeLineUpdate() {
    final pref = Prefs.instance.contract;
    final contract = pref?.contractDetail;
    selectedTimeLineRadioValue = contract?.isCompletionRadio;
    selectedStartDate = DateTime.parse(contract?.executionDate ?? '');
    if (selectedTimeLineRadioValue == 'No') {
      selectedEndDate = DateTime.parse(contract?.endDate ?? '');
    } else if (selectedTimeLineRadioValue == 'Yes') {
      selectedEndDate = null;
    }
    notifyListeners();
  }

  void updatePenaltyField() async {
    final contract = Prefs.instance.contract;
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
      'status': Status.active.value,
    };
    await contractRepository.update(contract?.id ?? '', updateBody);
    final model = await contractRepository
        .get(Prefs.instance.getLoginUserId() ?? '3123456789123');
    if (model != null) {
      Prefs.instance.setContract(model);
    }
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
    notifyListeners();
  }
}
