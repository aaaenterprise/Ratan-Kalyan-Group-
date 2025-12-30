import 'package:get/get.dart';
import 'package:gold/app/core/controllers/user_controller.dart';
import 'package:gold/app/core/models/generic_response_model.dart';
import 'package:gold/app/core/services/api_services.dart';
import 'package:gold/app/core/services/urls_and_endpoints.dart';
import 'package:gold/app/core/widgets/widgets.dart';
import 'package:gold/app/modules/home/models/betting_history_model.dart';
import 'package:gold/app/modules/home/models/game_model.dart';
import 'package:gold/app/modules/home/models/image_slide_model.dart';

class HomeController extends GetxController {
  UserController userController = Get.find<UserController>();
  List<GameModel> games = [];
  List<ImageSlideModel> imageList = [];
  bool isLoadingGames = false;

  @override
  void onInit() {
    super.onInit();

    loadGames();
    userController.getUserProfile();
    userController.getSettings();
    loadImageSlider();
  }

  loadGames() async {
    // CustomWidget.showLoader("Loggin User");
    isLoadingGames = true;
    update();
    GenericResponse response = await ApiServices().getRequest(
      endpoint: AllEndPoints.games,
    );

    if (response.success) {
      //Map<String, dynamic> map = jsonDecode(<myJSONString>);
      //var myRootNode = Root.fromJson(map);
      games = (response.data['data'] as List<dynamic>)
          .map((e) => GameModel.fromJson(e))
          .toList();
    } else {
      CustomWidget.showSnackBar(response.message);
    }

    isLoadingGames = false;
    update();
  }

  void addBett(List<BettingHistoryModel> bettingList) async {
    CustomWidget.showLoader("Creating bet");
    isLoadingGames = true;
    try{

   
    GenericResponse response = await ApiServices().postRequest(
        endpoint: AllEndPoints.bet,
        bodyParameters: bettingList.map((e) => e.toMap()).toList());

    if (response.success) {
      CustomWidget.showSnackBar("Betting Created");
      loadGames();
      userController.getUserProfile();
      // Get.toNamed(Routes.HOME);
    } else {
      CustomWidget.showSnackBar(response.message);
    }
    }catch(error){
      CustomWidget.showSnackBar(error.toString());
    }
    CustomWidget.hideLoader();
    isLoadingGames = false;
    update();
  }

  loadImageSlider() async {
    try {
      GenericResponse response = await ApiServices().getRequest(
        endpoint: AllEndPoints.image,
      );

      if (response.success) {
        imageList = (response.data['data'] as List<dynamic>)
            .map((e) => ImageSlideModel.fromMap(e))
            .toList();
      } else {
        CustomWidget.showSnackBar(response.message);
      }
    } catch (error) {
      CustomWidget.showSnackBar(error.toString());
    }
    update();
  }
}
