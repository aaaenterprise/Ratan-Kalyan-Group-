import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:gold/app/core/app_color.dart';
import 'package:gold/app/core/app_color.dart';

import '../controllers/gali_rate_controller.dart';

class GaliRateView extends GetView<GaliRateController> {
  const GaliRateView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gali Rate'),
        centerTitle: true,
      ),
      body:Padding(
        padding: const EdgeInsets.all(18.0),
        child: GetBuilder(
            init: controller,
            builder: (_) {
              return Visibility(
                replacement: Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primary,
                  ),
                ),
                visible: !controller.isLoading,
                child: Visibility(
                  replacement:
                      const Center(child: Text("Something went wrong")),
                  visible: controller.gameRate != null,
                  child: ListView(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(25.0)),
                        child: ListTile(
                          title: const Text(
                            "Single Digit ",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                          trailing: Text(
                            "10 --> ${controller.gameRate?.singleDigit.toString()}",
                            style: const TextStyle(
                                fontSize: 23, color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),

                      Container(
                        decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(25.0)),
                        child: ListTile(
                          title: const Text(
                            "Jodi Digit ",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                          trailing: Text(
                            "10 --> ${controller.gameRate?.jodiDigit.toString()}",
                            style: const TextStyle(
                                fontSize: 23, color: Colors.white),
                          ),
                        ),
                      ),
                      


                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
