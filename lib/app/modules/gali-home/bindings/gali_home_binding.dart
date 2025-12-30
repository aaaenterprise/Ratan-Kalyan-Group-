import 'package:get/get.dart';

import '../controllers/gali_home_controller.dart';

class GaliHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GaliHomeController>(
      () => GaliHomeController(),
    );
  }
}
