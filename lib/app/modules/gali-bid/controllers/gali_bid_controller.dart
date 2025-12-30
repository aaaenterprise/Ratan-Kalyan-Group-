import 'package:get/get.dart';
import 'package:gold/app/core/controllers/user_controller.dart';
import 'package:gold/app/core/models/generic_response_model.dart';
import 'package:gold/app/core/services/api_services.dart';
import 'package:gold/app/core/services/urls_and_endpoints.dart';
import 'package:gold/app/core/widgets/widgets.dart';
import 'package:gold/app/modules/gali-bid/model/gali_bet_model.dart';

class GaliBidController extends GetxController {
 UserController userController = Get.find<UserController>();
  List<GaliBetModel> bets = [];
  bool isLoading = false;
  @override
  void onInit() {
    super.onInit();
    fetchBiddingHistory();
  }

  void fetchBiddingHistory() async {
    isLoading = true;
    CustomWidget.showLoader("Loading Bids");
    GenericResponse response = await ApiServices().getRequest(
      endpoint: "${AllEndPoints.betGali}${userController.userModel?.id}",
    );
   
    if (response.success) {
      bets = (response.data['data'] as List<dynamic>)
          .map((e) => GaliBetModel.fromMap(e))
          .toList();
      bets.sort((a, b) => b.timestamp!.compareTo(a.timestamp!));
    } else {
      CustomWidget.showSnackBar(response.message);
    }
    isLoading = false;
     CustomWidget.hideLoader();
      update();
  }
}
