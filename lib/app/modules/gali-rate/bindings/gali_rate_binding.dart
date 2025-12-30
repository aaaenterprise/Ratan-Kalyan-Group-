import 'package:get/get.dart';

import '../controllers/gali_rate_controller.dart';

class GaliRateBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GaliRateController>(
      () => GaliRateController(),
    );
  }
}
