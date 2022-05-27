import 'package:flutter/material.dart';

class HandyManProvider with ChangeNotifier {
  DateTime? selectedStartDate;
  DateTime? selectedEndDate;
  String? selectedHandyManRadioValue;
  bool? selectedRentalCategoryValue;
  String? selectedCompensationRadioValue;
  String? selectedUsingSubContractorRadioValue;
  String? selectedCompensationPaidRadioValue;

  void onSelectedStartChanged(DateTime? dateTime) {
    selectedStartDate = dateTime;
    notifyListeners();
  }

  void onSelectedEndChanged(DateTime? dateTime) {
    selectedEndDate = dateTime;
    notifyListeners();
  }

  void onChangedTimeLineRadioValue(String? value) {
    selectedHandyManRadioValue = value;
    notifyListeners();
  }

  void onChangedCheckBoxValue(bool? value) {
    selectedRentalCategoryValue = value;
    notifyListeners();
  }

  void onChangedUsingSubContractorsRadioValue(String? value) {
    selectedUsingSubContractorRadioValue = value;
    notifyListeners();
  }
  void onChangedCompensationRadioValue(String? value) {
    selectedCompensationRadioValue = value;
    notifyListeners();
  }
  void onChangedCompensationPaidRadioValue(String? value) {
    selectedCompensationPaidRadioValue = value;
    notifyListeners();
  }
}
