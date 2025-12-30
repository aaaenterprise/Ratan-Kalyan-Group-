import 'package:get/get.dart';

import '../controllers/star_line_win_history_controller.dart';

class StarLineWinHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StarLineWinHistoryController>(
      () => StarLineWinHistoryController(),
    );
  }
}
