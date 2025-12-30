import 'package:get/get.dart';

import '../controllers/star_line_chart_controller.dart';

class StarLineChartBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StarLineChartController>(
      () => StarLineChartController(),
    );
  }
}
