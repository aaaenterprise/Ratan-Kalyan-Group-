import 'package:get/get.dart';

import '../controllers/game_option_controller.dart';

class GameOptionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GameOptionController>(
      () => GameOptionController(),
    );
  }
}
