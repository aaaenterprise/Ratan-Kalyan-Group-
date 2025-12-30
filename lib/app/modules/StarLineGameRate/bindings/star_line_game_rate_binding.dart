import 'package:get/get.dart';

import '../controllers/star_line_game_rate_controller.dart';

class StarLineGameRateBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StarLineGameRateController>(
      () => StarLineGameRateController(),
    );
  }
}
