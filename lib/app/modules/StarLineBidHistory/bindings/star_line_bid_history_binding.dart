import 'package:get/get.dart';

import '../controllers/star_line_bid_history_controller.dart';

class StarLineBidHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StarLineBidHistoryController>(
      () => StarLineBidHistoryController(),
    );
  }
}
