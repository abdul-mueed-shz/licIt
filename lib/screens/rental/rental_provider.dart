import 'package:flutter/material.dart';

class RentalProvider with ChangeNotifier {
  DateTime? selectedStartDate;
  DateTime? selectedDateOfSecurity;
  String? selectedRentalRadioValue;
  String? selectedRentalOccupantRadioValue;
  bool? selectedRentalCategoryValue;
  String? selectedRentalPaymentRadioValue;
  String? selectedAssignmentRadioValue;
  String? selectedUtilitiesRadioValue;

  void onSelectedStartChanged(DateTime? dateTime) {
    selectedStartDate = dateTime;
    notifyListeners();
  }

  void onSelectedDateOfSecurityChanged(DateTime? dateTime) {
    selectedDateOfSecurity = dateTime;
    notifyListeners();
  }

  void onChangedRentalPaymentRadioValue(String? value) {
    selectedRentalRadioValue = value;
    print(value);
    notifyListeners();
  }

  void onChangedRentalOccupantRadioValue(String? value) {
    selectedRentalOccupantRadioValue = value;

    notifyListeners();
  }

  void onChangedUtilitiesRadioValue(String? value) {
    selectedUtilitiesRadioValue = value;

    notifyListeners();
  }
  void onChangedAssignmentRadioValue(String? value) {
    selectedAssignmentRadioValue = value;

    notifyListeners();
  }

  void onChangedCheckBoxValue(bool? value) {
    selectedRentalCategoryValue = value;
    notifyListeners();
  }

  void onChangedRentalPaymenRadioValue(String? value) {
    selectedRentalPaymentRadioValue = value;
    notifyListeners();
  }


}
