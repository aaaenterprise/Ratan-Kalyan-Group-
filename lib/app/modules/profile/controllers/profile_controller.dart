import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold/app/core/controllers/user_controller.dart';
import 'package:gold/app/core/models/generic_response_model.dart';
import 'package:gold/app/core/services/api_services.dart';
import 'package:gold/app/core/services/urls_and_endpoints.dart';
import 'package:gold/app/core/widgets/widgets.dart';

class ProfileController extends GetxController {
   UserController userController = Get.find<UserController>();
  final formKey = GlobalKey<FormState>();
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();

  void changePassword() async {
    CustomWidget.showLoader("Updating Password");
    GenericResponse response = await ApiServices()
        .putRequest(endpoint: AllEndPoints.changePassword, bodyParameters: {
      "oldPassword": oldPasswordController.text,
      "newPassword": newPasswordController.text
    });
    CustomWidget.hideLoader();
    if (response.success) {
      CustomWidget.showSnackBar("Password Updated Successfully");
    } else {
      CustomWidget.showSnackBar(response.message);
    }
    update();
  }
}
