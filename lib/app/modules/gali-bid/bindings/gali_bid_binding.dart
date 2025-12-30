import 'package:get/get.dart';

import '../controllers/gali_bid_controller.dart';

class GaliBidBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GaliBidController>(
      () => GaliBidController(),
    );
  }
}
