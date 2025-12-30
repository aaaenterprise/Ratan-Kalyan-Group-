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

class RegisterController extends GetxController {
  UserController userController = Get.find<UserController>();
  final signupFormKey = GlobalKey<FormState>();
  TextEditingController nameEditingController = TextEditingController();
  TextEditingController mobileEditingController = TextEditingController();
  TextEditingController mPinEditingController = TextEditingController();

  void userRegister() async {
    CustomWidget.showLoader("Creating User");
    try {
      GenericResponse response = await AuthApiServices()
          .signupRequest(endpoint: AllEndPoints.userRegister, bodyParameters: {
        "name": nameEditingController.text,
        "phone": mobileEditingController.text,
        "password": mPinEditingController.text,
        "role": "user"
      });


      if (response.success) {
        UserModel user = UserModel.fromMap(response.data['data']);
      try {
        userController.userModel = user;
        await LocalStorage.setUserData(user);
        CustomWidget.showSnackBar(response.message);
        Get.offAllNamed(Routes.HOME);
      } catch (e) {
   
        CustomWidget.showSnackBar("Some thing went wrong");
      }
      } else {
        CustomWidget.showSnackBar(response.message);
      }
    } catch (err) {

      CustomWidget.showSnackBar(err.toString());
    }
    CustomWidget.hideLoader();
  }
}
