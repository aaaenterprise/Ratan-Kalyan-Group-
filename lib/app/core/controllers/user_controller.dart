import 'dart:developer';

import 'package:get/get.dart';
import 'package:gold/app/core/models/generic_response_model.dart';
import 'package:gold/app/core/models/setting_model.dart';
import 'package:gold/app/core/models/user_model.dart';
import 'package:gold/app/core/services/api_services.dart';
import 'package:gold/app/core/services/shared_prefrences.dart';
import 'package:gold/app/core/services/urls_and_endpoints.dart';
import 'package:gold/app/core/widgets/widgets.dart';
import 'package:gold/app/routes/app_pages.dart';

class UserController extends GetxController {
  String? jwtToken;

  UserModel? userModel;
  SettingModel? setting;
  @override
  void onInit() async {
    super.onInit();
    userModel = await LocalStorage.getUserData();
    if (userModel?.token != null) {
      await Future.delayed(const Duration(seconds: 1));
      jwtToken = userModel?.token;
      getUserProfile();
      getSettings();
      Get.offAllNamed(Routes.HOME);
    } else {
      getSettings();
      await Future.delayed(const Duration(seconds: 1));
      Get.offAllNamed(Routes.REGISTER);
    }
  }

  getUserProfile() async {
    GenericResponse response = await ApiServices().getRequest(
      endpoint: AllEndPoints.profile,
    );

    if (response.success) {
      UserModel user = UserModel.fromMap(response.data['data']);

      user.token = userModel?.token!;
      try {
        log("Jwt token ----> $jwtToken");
        userModel = user;
        log("User ---> $userModel");
        await LocalStorage.setUserData(user);
      } catch (e) {
        log(e.toString());
        CustomWidget.showSnackBar("Some thing went wrong");
      }
    } else {
      CustomWidget.showSnackBar(response.message);
    }

    update();
  }

  void logout() {
    CustomWidget.showLoader("Loggingout");
    LocalStorage.clearData();
    CustomWidget.hideLoader();
    CustomWidget.showSnackBar("User Loggedout");
    Get.offAllNamed(Routes.LOGIN);
    update();
  }

  void getSettings() async {
    GenericResponse response = await ApiServices().getRequest(
      endpoint: AllEndPoints.setting,
    );

    if (response.success) {
      setting = SettingModel.fromMap(response.data['data']);
    } else {
      CustomWidget.showSnackBar(response.message);
    }

    update();
  }
}
