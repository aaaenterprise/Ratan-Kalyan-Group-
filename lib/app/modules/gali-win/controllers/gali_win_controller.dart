import 'package:get/get.dart';
import 'package:gold/app/core/controllers/user_controller.dart';
import 'package:gold/app/core/models/generic_response_model.dart';
import 'package:gold/app/core/services/api_services.dart';
import 'package:gold/app/core/services/urls_and_endpoints.dart';
import 'package:gold/app/core/widgets/widgets.dart';
import 'package:gold/app/modules/StarLineWinHistory/models/winning_history_model.dart';

class GaliWinController extends GetxController {
   List<StarLineWinningHistoryModel> winningDataList = [];
  UserController userController = Get.find<UserController>();

  @override
  void onInit() {
    super.onInit();
    fetchWinningHistoryHistory();
  }

  void fetchWinningHistoryHistory() async {
    CustomWidget.showLoader("Loading Winning History");
    GenericResponse response = await ApiServices().getRequest(
      endpoint: "${AllEndPoints.winningHistoryGali}${userController.userModel?.id}",
    );
    CustomWidget.hideLoader();
    if (response.success) {
      winningDataList = (response.data['data'] as List<dynamic>)
          .map((e) => StarLineWinningHistoryModel.fromMap(e))
          .toList();
      winningDataList.sort((a, b) => b.timestamp!.compareTo(a.timestamp!));
      update();
    } else {
      CustomWidget.showSnackBar(response.message);
    }
  }
}
