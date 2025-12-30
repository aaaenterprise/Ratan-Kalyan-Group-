import 'package:get/get.dart';

import '../controllers/create_bet_controller.dart';

class CreateBetBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateBetController>(
      () => CreateBetController(),
    );
  }
}
