import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class PreferencesKey {
  static const String VIP_INFO = 'VIP_INFO';
}

class PreferencesStorage {
  static Future<bool> save<T>(String key, T value) async {
    switch (T) {
      case String:
        return saveStr(key, value as String);
      case int:
        return saveInt(key, value as int);
      case double:
        return saveDouble(key, value as double);
      case bool:
        return saveBool(key, value as bool);
      case List:
        return saveStringList(key, value as List);
      case Map:
        return saveMap(key, value as Map);
      default:
    }
    return false;
  }

  static Future<bool> saveStr(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(key, value);
  }

  static Future<bool> saveInt(String key, int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setInt(key, value);
  }

  static Future<bool> saveDouble(String key, double value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setDouble(key, value);
  }

  static Future<bool> saveBool(String key, bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(key, value);
  }

  static Future<bool> saveStringList(String key, List<String> value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setStringList(key, value);
  }

  static Future<bool> saveMap(String key, Map<String, dynamic> value) async {
    var temp = json.encode(value);
    return PreferencesStorage.saveStr(key, temp);
  }

  static Future<bool> remove(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove(key);
  }

  static Future<String> getStr(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }
  static Future<Map<String, dynamic>> getMap(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String temp = prefs.getString(key);
    if (temp == null) {
      return null;
    }
    return json.decode(temp);
  }
}
