import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:gold/app/core/controllers/user_controller.dart';
import 'package:gold/app/core/models/generic_response_model.dart';
import 'package:gold/app/core/models/user_model.dart';
import 'package:gold/app/core/services/auth_api_services.dart';
import 'package:gold/app/core/services/shared_prefrences.dart';
import 'package:gold/app/core/services/urls_and_endpoints.dart';
import 'package:gold/app/core/widgets/widgets.dart';
import 'package:gold/app/routes/app_pages.dart';

class LoginController extends GetxController {
  UserController userController = Get.find<UserController>();
  final loginFormKey = GlobalKey<FormState>();

  TextEditingController mobileEditingController = TextEditingController();
  TextEditingController mPinEditingController = TextEditingController();
bool isPasswordVisible = false;

void togglePasswordVisibility() {
  isPasswordVisible = !isPasswordVisible;
  update();
}
  void userLogin() async {
    CustomWidget.showLoader("Loggin User");
    try{


    GenericResponse response = await AuthApiServices()
        .loginRequest(endpoint: AllEndPoints.userLogin, bodyParameters: {
      "phone": mobileEditingController.text,
      "password": mPinEditingController.text,
    });

    if (response.success) {
      UserModel user = UserModel.fromMap(response.data['data']);
      try {
        userController.userModel = user;
        await LocalStorage.setUserData(user);
        CustomWidget.showSnackBar(response.message);
        Get.offAllNamed(Routes.HOME);
      } catch (e) {
        log(e.toString());
        CustomWidget.showSnackBar("Some thing went wrong");
      }
    } else {
      CustomWidget.showSnackBar(response.message);
    }
    }
    catch(err){
      CustomWidget.showSnackBar(err.toString());

    }
     CustomWidget.hideLoader();
  }
}
