import 'dart:convert';

import 'package:flutter/foundation.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:gold/app/core/models/user_model.dart';
import 'package:gold/app/core/shared.dart';

class LocalStorage {
  setJwtTokenPrefs(String token) async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    SharedPreferencesNative.setString('token', token);
  }

  Future<String?> getJwtTokenPrefs() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    return SharedPreferencesNative.getString('token');
  }

  static Future<void> setUserData(UserModel user) async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    await SharedPreferencesNative.setString('UserKey', jsonEncode(user.toMap()));
  }

  static Future<UserModel?> getUserData() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    final data =await SharedPreferencesNative.getString('UserKey');
    if (data != null) {
      debugPrint(data);
      // Map<String, dynamic> jsonData = json.decode(data);
      UserModel user = UserModel.fromJson(data);
      return user;
    }

    return null;
  }

  static Future<bool> clearData() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    return await SharedPreferencesNative.clearData();
  }
}
