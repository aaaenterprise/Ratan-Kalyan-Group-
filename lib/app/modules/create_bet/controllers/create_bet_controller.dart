import 'package:get/get.dart';
import 'package:gold/app/core/models/user_model.dart';
import 'package:gold/app/modules/home/models/game_model.dart';

class CreateBetController extends GetxController {
 late GameModel game;
  late UserModel user;
String gameType='';
  @override
  void onInit() {

    super.onInit();

    game = Get.arguments['game'];
    user = Get.arguments['user'];
    gameType = Get.arguments['type'];
  }
}
