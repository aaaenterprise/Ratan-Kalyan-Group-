import 'package:get/get.dart';

import '../controllers/star_line_controller.dart';

class StarLineBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StarLineController>(
      () => StarLineController(),
    );
  }
}
