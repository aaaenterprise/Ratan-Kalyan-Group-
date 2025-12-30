import 'package:get/get.dart';

import '../controllers/winning_history_controller.dart';

class WinningHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WinningHistoryController>(
      () => WinningHistoryController(),
    );
  }
}
