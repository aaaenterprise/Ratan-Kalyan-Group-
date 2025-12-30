import 'package:get/get.dart';
import 'package:gold/app/core/models/user_model.dart';
import 'package:gold/app/modules/home/models/game_model.dart';

class GameOptionController extends GetxController {
  late GameModel game;
  late UserModel user;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    game = Get.arguments['game'];
    user = Get.arguments['user'];
  }
}
