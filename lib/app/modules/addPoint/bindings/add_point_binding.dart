import 'package:get/get.dart';

import '../controllers/add_point_controller.dart';

class AddPointBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddPointController>(
      () => AddPointController(),
    );
  }
}
