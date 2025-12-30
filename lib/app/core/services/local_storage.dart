// import 'dart:convert';
// import 'dart:developer';

// import 'package:flutter/foundation.dart';
// import 'package:omni_exam_tech/features/register/models/user_registration_model.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class AuthSession {
//   static Future<void> setJwtToken(String token) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setString('JWTKey', token);
//   }

//   static Future<String?> getJwtToken() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     final token = prefs.getString('JWTKey');

//     return token;
//   }

// static Future<void> setUserData(UserRegistrationModel user) async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   await prefs.setString('UserKey', jsonEncode(user.toMap()));
// }

// static Future<UserRegistrationModel?> getUserData() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   final data = prefs.getString('UserKey');
//   if (data != null) {
//     log("under shared prefrences");
//     debugPrint(data);
//     // Map<String, dynamic> jsonData = json.decode(data);
//     UserRegistrationModel user = UserRegistrationModel.fromJson(data);
//     return user;
//   }

//   return null;
// }

// static Future<bool> clearData() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   return await prefs.clear();
// }
// }
