import 'dart:convert';

import 'package:fyp/model/contract_model.dart';
import 'package:fyp/screens/repository/storage/storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefStorage implements IStorage {
  static final PrefStorage _instance = PrefStorage._internal();

  static PrefStorage get instance => _instance;

  factory PrefStorage() {
    return _instance;
  }
  PrefStorage._internal();

  static late SharedPreferences _prefs;

  static const _keyName = 'cnic';
  static const _keyContract = 'contractModel';
  static const _cnicToken = 'token';

  @override
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  @override
  Future<bool> setContract(ContractModel? contractModel) =>
      _prefs.setString(_keyContract, jsonEncode(contractModel?.toJson()));
  @override
  Future<void> setId(String cnic) => _prefs.setString(_keyName, cnic);
  @override
  Future<void> setCnicToken(String token) =>
      _prefs.setString(_cnicToken, token);
  @override
  String? get id => _prefs.getString(_keyName);
  @override
  Future<bool> removeUser() => _prefs.remove(_keyContract);
  @override
  Future<void> allClear() => _prefs.clear();

  @override
  ContractModel? get contract {
    final userString = _prefs.getString(_keyContract);
    if (userString != null) {
      final userJson = jsonDecode(userString);
      return ContractModel.fromJson(userJson);
    }
    return null;
  }
}
