import 'dart:developer';

import 'package:flutter/services.dart';

class SharedPreferencesNative {
  static const platform = MethodChannel('com.example.app/shared_preferences');

  static Future<void> setString(String key, String value) async {
    try {
      await platform.invokeMethod('setString', {'key': key, 'value': value});
    } on PlatformException catch (e) {
      log("Failed to set string: ${e.message}");
    }
  }

  static Future<String?> getString(String key) async {
    try {
      final String? value =
          await platform.invokeMethod('getString', {'key': key});
      return value;
    } on PlatformException catch (e) {
      log("Failed to get string: ${e.message}");
      return null;
    }
  }

  static Future<void> setInt(String key, int value) async {
    try {
      await platform.invokeMethod('setInt', {'key': key, 'value': value});
    } on PlatformException catch (e) {
      log("Failed to set int: ${e.message}");
    }
  }

  static Future<int?> getInt(String key) async {
    try {
      final int? value = await platform.invokeMethod('getInt', {'key': key});
      return value;
    } on PlatformException catch (e) {
      log("Failed to get int: ${e.message}");
      return null;
    }
  }

  // Method to clear user data from SharedPreferences
  static Future<bool> clearData() async {
    try {
      await platform.invokeMethod('clear');
      return true;
    } on PlatformException catch (e) {
      log("Failed to clear shared preferences: ${e.message}");
      return false;
    }
  }
}
