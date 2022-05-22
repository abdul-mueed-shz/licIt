import 'dart:convert';

import 'package:fyp/model/contract_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  static final Prefs _instance = Prefs._internal();

  static Prefs get instance => _instance;

  factory Prefs() {
    return _instance;
  }
  Prefs._internal();

  static late SharedPreferences _prefs;

  static const _keyName = 'cnic';
  static const _keyContract = 'contractModel';

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> setId(String cnic) => _prefs.setString(_keyName, cnic);

  String? getLoginUserId() => _prefs.getString(_keyName);

  Future<bool> setContract(ContractModel contractModel) =>
      _prefs.setString(_keyContract, jsonEncode(contractModel.toJson()));

  ContractModel? get contract {
    final userString = _prefs.getString(_keyContract);
    if (userString != null) {
      final userJson = jsonDecode(userString);
      return ContractModel.fromJson(userJson);
    }
    return null;
  }

  Future<bool> removeUser() => _prefs.remove(_keyContract);
  Future<void> allClear() => _prefs.clear();
}
