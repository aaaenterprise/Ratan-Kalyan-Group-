import 'package:get/get.dart';

import '../controllers/gali_chart_controller.dart';

class GaliChartBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GaliChartController>(
      () => GaliChartController(),
    );
  }
}
