import 'package:get/get.dart';

import '../controllers/game_rate_controller.dart';

class GameRateBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GameRateController>(
      () => GameRateController(),
    );
  }
}
