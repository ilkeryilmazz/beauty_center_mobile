import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedManager {
  SharedPreferences? preferences;

  SharedManager();

  Future<void> init() async {
   
    preferences = await SharedPreferences.getInstance();
  }

  Future<void> saveString(SharedKeys key, String value) async {
    await preferences?.setString(key.name, value);
  }

  Future<void> saveBool(SharedKeys key, bool value) async {
    await preferences?.setBool(key.name, value);
  }

  bool? getBool(SharedKeys key) {
    return preferences?.getBool(key.name);
  }

  Future<void> saveStringItems(SharedKeys key, List<String> value) async {
    await preferences?.setStringList(key.name, value);
  }

  List<String>? getStrings(SharedKeys key) {
    return preferences?.getStringList(key.name);
  }

  String? getString(SharedKeys key) {
    return preferences?.getString(key.name);
  }

  int? getInt(SharedKeys key) {
    return preferences?.getInt(key.name);
  }

  Future<bool> removeItem(SharedKeys key) async {
    return (await preferences?.remove(key.name)) ?? false;
  }
}

enum SharedKeys { user_id }
