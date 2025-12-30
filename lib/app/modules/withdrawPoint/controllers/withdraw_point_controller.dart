import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:gold/app/core/controllers/user_controller.dart';
import 'package:gold/app/core/models/generic_response_model.dart';
import 'package:gold/app/core/services/api_services.dart';
import 'package:gold/app/core/services/urls_and_endpoints.dart';
import 'package:gold/app/core/widgets/widgets.dart';
import 'package:gold/app/routes/app_pages.dart';

class WithdrawPointController extends GetxController {
 UserController userController = Get.find<UserController>();
  final formKey = GlobalKey<FormState>();

  TextEditingController amountEditingController = TextEditingController();
  TextEditingController upiNumberEditingController = TextEditingController();

  String selectedPayment = "Paytm";
  void withdrawPoint() async {
    CustomWidget.showLoader("Making Request Of Withdraw Points");
    GenericResponse response = await ApiServices()
        .postRequest(endpoint: AllEndPoints.withdraw, bodyParameters: {
      "userId": userController.userModel?.id,
      "amount": amountEditingController.text,
      "upiNumber": upiNumberEditingController.text,
      "paymentMethod": selectedPayment
    });
    CustomWidget.hideLoader();
    selectedPayment = "PayTm";
    amountEditingController.clear();
    upiNumberEditingController.clear();
    if (response.success) {
      CustomWidget.showSnackBar(
          "Your request has been submited you will recieve, payment Once its Approved");
      Get.toNamed(Routes.HOME);
      update();
    } else {
      CustomWidget.showSnackBar(response.message);
    }
  }



  @override
  void onClose() {
    selectedPayment = "PayTm";
    amountEditingController.dispose();
    upiNumberEditingController.dispose();
    super.onClose();
  }
}
