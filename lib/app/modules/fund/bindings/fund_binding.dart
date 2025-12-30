import 'package:get/get.dart';

import '../controllers/fund_controller.dart';

class FundBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FundController>(
      () => FundController(),
    );
  }
}
