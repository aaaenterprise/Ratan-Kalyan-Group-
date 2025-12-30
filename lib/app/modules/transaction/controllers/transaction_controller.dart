import 'package:get/get.dart';
import 'package:gold/app/core/controllers/user_controller.dart';
import 'package:gold/app/core/models/generic_response_model.dart';
import 'package:gold/app/core/services/api_services.dart';
import 'package:gold/app/core/services/urls_and_endpoints.dart';
import 'package:gold/app/core/widgets/widgets.dart';
import 'package:gold/app/modules/transaction/models/transaction_model.dart';

class TransactionController extends GetxController {
   List<TransactionModel> transections = [];

  UserController userController = Get.find<UserController>();
  bool isLoading = false;

  @override
  void onInit() {
    super.onInit();
    fetchTransactionHistory();
  }

  void fetchTransactionHistory() async {

    CustomWidget.showLoader("Loading Transaction");
    GenericResponse response = await ApiServices().getRequest(
      endpoint: "${AllEndPoints.transaction}${userController.userModel?.id}",
    );
    CustomWidget.hideLoader();
    if (response.success) {
      transections = (response.data['data'] as List<dynamic>)
          .map((e) => TransactionModel.fromMap(e))
          .toList();

      transections.sort((a, b) => b.timestamp!.compareTo(a.timestamp!));
      update();
    } else {
      CustomWidget.showSnackBar(response.message);
    }
  }
}
