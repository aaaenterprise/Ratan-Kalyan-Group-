import 'package:get/get.dart';
import 'package:gold/app/core/models/generic_response_model.dart';
import 'package:gold/app/core/services/api_services.dart';
import 'package:gold/app/core/services/urls_and_endpoints.dart';
import 'package:gold/app/core/widgets/widgets.dart';
import 'package:gold/app/modules/StarLineChart/models/market_result_model.dart';

class StarLineChartController extends GetxController {
  List<StarLineMarketResultModel> marketList=[];
  String title = "";
  @override
  void onInit() {
    super.onInit();
    title = Get.parameters['gameName'] ?? "";
    getMatrketResult();
  }
getMatrketResult() async {
    CustomWidget.showLoader("Loading Market");
    GenericResponse response = await ApiServices().getRequest(
      endpoint: "${AllEndPoints.starLineResult}$title",
    );
    CustomWidget.hideLoader();
    if (response.success) {
       marketList = (response.data['data'] as List<dynamic>)
          .map((e) => StarLineMarketResultModel.fromMap(e))
          .toList();

      marketList.sort((a, b) => b.timestamp!.compareTo(a.timestamp!));
      update();
    } else {
      CustomWidget.showSnackBar(response.message);
    }
  }
}
