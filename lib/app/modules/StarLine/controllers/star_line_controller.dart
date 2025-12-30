import 'package:get/get.dart';
import 'package:gold/app/core/controllers/user_controller.dart';
import 'package:gold/app/core/models/generic_response_model.dart';
import 'package:gold/app/core/services/api_services.dart';
import 'package:gold/app/core/services/urls_and_endpoints.dart';
import 'package:gold/app/core/widgets/widgets.dart';
import 'package:gold/app/modules/StarLine/models/bet_model.dart';
import 'package:gold/app/modules/StarLine/models/star_line_game_model.dart';

class StarLineController extends GetxController {
   UserController userController = Get.find<UserController>();
  List<StarLineGameModel> games = [];

  bool isLoadingGames = false;

  @override
  void onInit() {
    super.onInit();

    loadGames();

  }

  loadGames() async {
    // CustomWidget.showLoader("Loggin User");
    isLoadingGames = true;
    update();
    GenericResponse response = await ApiServices().getRequest(
      endpoint: AllEndPoints.startLineGames,
    );

    if (response.success) {
      //Map<String, dynamic> map = jsonDecode(<myJSONString>);
      //var myRootNode = Root.fromJson(map);
      games = (response.data['data'] as List<dynamic>)
          .map((e) => StarLineGameModel.fromJson(e))
          .toList();
    } else {
      CustomWidget.showSnackBar(response.message);
    }

    isLoadingGames = false;
    update();
  }

  void addBett(List<StarLineBetModel> bettingList) async {
    CustomWidget.showLoader("Creating bet");
    isLoadingGames = true;
    GenericResponse response = await ApiServices().postRequest(
        endpoint: AllEndPoints.starLineBet,
        bodyParameters: bettingList.map((e) => e.toMap()).toList());

    if (response.success) {
      CustomWidget.showSnackBar("Betting Created");
      loadGames();
      userController.getUserProfile();
      // Get.toNamed(Routes.HOME);
    } else {
      CustomWidget.showSnackBar(response.message);
    }
    CustomWidget.hideLoader();
    isLoadingGames = false;
    update();
  }


}
