import 'package:get/get.dart';

import '../controllers/withdraw_point_controller.dart';

class WithdrawPointBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WithdrawPointController>(
      () => WithdrawPointController(),
    );
  }
}
