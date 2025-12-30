import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CustomWidget {
  static void showLoader(String message) {
    EasyLoading.show(
      status: message,
    );
  }

  static void hideLoader() {
    EasyLoading.dismiss();
  }

  static void showSnackBar(String message, {Color? bgColor, Color? fgColor}) {
    Fluttertoast.showToast(
      toastLength: Toast.LENGTH_LONG,
        msg: message, backgroundColor: bgColor, textColor: fgColor, );
  }
}
