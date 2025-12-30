import 'package:get/get.dart';

import '../controllers/gali_win_controller.dart';

class GaliWinBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GaliWinController>(
      () => GaliWinController(),
    );
  }
}
