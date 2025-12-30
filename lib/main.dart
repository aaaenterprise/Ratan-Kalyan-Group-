import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:gold/app/core/api/firebase_api.dart';
import 'package:gold/app/core/controllers/user_controller.dart';
import 'package:gold/app/data/constant/color_constant.dart';
import 'package:firebase_core/firebase_core.dart';
import 'app/routes/app_pages.dart';

void main() async {
WidgetsFlutterBinding.ensureInitialized();
    Get.put(UserController());
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: 'AIzaSyAkFzX4qgHIFr5CydxROE4JcUP2vZTZjwQ',
    appId: '1:570098274707:android:4233b6436bb402c4d1d866',
    messagingSenderId: '570098274707',
    projectId: 'gold-kalyan-29917',
    storageBucket: 'gold-kalyan-29917.firebasestorage.app',
  ));
  
  FirebaseApi().initNotifications();
  Get.put(UserController());
  runApp(
    GetMaterialApp(
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            backgroundColor: ColorConstant.primaryColor,
            foregroundColor: Colors.white,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorConstant.primaryColor,
              foregroundColor: Colors.white,
              shape: const BeveledRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                side: BorderSide(
                  width: 2.5,
                ),
              ),
            ),
          ),
          outlinedButtonTheme: OutlinedButtonThemeData(
            style: OutlinedButton.styleFrom(
              // backgroundColor: ColorConstant.primaryColor,
              // foregroundColor: Colors.white,
              shape: BeveledRectangleBorder(
                borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                side: BorderSide(width: 2.5, color: ColorConstant.primaryColor),
              ),
            ),
          ),
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
              borderSide:
                  BorderSide(color: ColorConstant.primaryColor, width: 3.5),
              borderRadius: BorderRadius.circular(10),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: ColorConstant.primaryColor, width: 3.5),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: ColorConstant.primaryColor, width: 3.5),
              borderRadius: BorderRadius.circular(10),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.redAccent, width: 3.5),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        title: "Kalki Matka",
        debugShowCheckedModeBanner: false,
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
        builder: EasyLoading.init(),
      ),
    
  );
  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
}
