import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold/app/core/controllers/user_controller.dart';
import 'package:gold/app/core/models/generic_response_model.dart';
import 'package:gold/app/core/services/api_services.dart';
import 'package:gold/app/core/services/urls_and_endpoints.dart';
import 'package:gold/app/core/widgets/widgets.dart';
import 'package:flutter_upi_india/flutter_upi_india.dart';


class AddPointController extends GetxController {
  UserController userController = Get.find<UserController>();
  final formKey = GlobalKey<FormState>();
  TextEditingController amountEditingController = TextEditingController();
 List<ApplicationMeta> apps = [];
   String selectedPaymentMethod = 'googlepay'; // Add this line

  @override
  void onInit()async {
    // upiIndia.getAllUpiApps(mandatoryTransactionId: false).then((value) {
    //   apps = value;
    // }).catchError((e) {
    //   apps = [];
    // });
    apps = await UpiPay.getInstalledUpiApplications(
          statusType: UpiApplicationDiscoveryAppStatusType.all);
    update();
    super.onInit();
  }

  

  startPaymentSession(ApplicationMeta app,
      ) async {
    try {
      String transactionId = DateTime.now().toIso8601String();

      // var data = await UpiIndia().startTransaction(
      //   app: app,
      //   receiverUpiId: userController.setting!.paytmUpi ?? "",
      //   receiverName: 'Gaurav Soni',
      //   transactionRefId: transactionId,
      //   transactionNote: 'Add Points',
      //   amount: double.parse(amountEditingController.text),
      // );
    

      

      final  UpiTransactionResponse data = await UpiPay.initiateTransaction(
          amount: amountEditingController.text,
          app: app.upiApplication,
          receiverName: 'Buy Clothes',
          receiverUpiAddress: userController.setting!.paytmUpi ?? "",
          transactionRef: transactionId,
          transactionNote: 'Buy Clothes',
          // merchantCode: '7372',
        );
        debugPrint("response ----->");
        debugPrint(data.toString());
        debugPrint(data.responseCode ?? " ");
        debugPrint(data.status?.name ?? " ");
        debugPrint(data.approvalRefNo ?? " ");
        debugPrint(data.txnId ?? " ");
        debugPrint(data.txnRef ?? " ");

        if (data.status == UpiTransactionStatus.success ) {
          CustomWidget.showLoader("Adding money");
          GenericResponse response = await ApiServices().postRequest(
              endpoint: "${AllEndPoints.addMoney}${userController.userModel?.id}",
              bodyParameters: {
                "userId": userController.userModel?.id,
                "amount": amountEditingController.text,
                "description": "You have added this money $transactionId",
                "transectionId": transactionId
              });

          if (response.success) {
            
            CustomWidget.showSnackBar(response.message);
          } else {
            
            CustomWidget.showSnackBar(response.message);
          }
        
      } else {
        CustomWidget.showSnackBar(data.status?.name ?? "Something went wrong");
      }
    } catch (err) {
      log(err.toString());
    }
    Get.back();
    CustomWidget.hideLoader();
  }
}
