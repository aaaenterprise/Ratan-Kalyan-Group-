import 'package:get/get.dart';
import 'package:gold/app/core/models/generic_response_model.dart';
import 'package:gold/app/core/services/api_services.dart';
import 'package:gold/app/core/services/urls_and_endpoints.dart';
import 'package:gold/app/core/widgets/widgets.dart';
import 'package:gold/app/modules/StarLineGameRate/models/game_rate_model.dart';

class StarLineGameRateController extends GetxController {
  StarLineGameRateModel? gameRate;
  bool isLoading = false;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchGameRate();
  }

  fetchGameRate() async {
    isLoading = true;
    GenericResponse response = await ApiServices().getRequest(
      endpoint: AllEndPoints.starLineGameRate,
    );

    if (response.success) {
      gameRate = StarLineGameRateModel.fromMap(response.data['data']);
    } else {
      CustomWidget.showSnackBar(response.message);
    }
    isLoading = false;
    update();
  }
}
