import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold/app/core/app_color.dart';
import 'package:gold/app/core/app_color.dart';
import '../controllers/gali_chart_controller.dart';

class GaliChartView extends GetView<GaliChartController> {
  const GaliChartView({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: const  AppColors.primary , // Purple color from screenshot
        title: const Text(
          'Chart Result',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        centerTitle: false,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        elevation: 0,
      ),
      body: Column(
        children: [
          // Table Header
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Center(
                    child: Text(
                      'Date',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Center(
                    child: Text(
                      'Open',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Center(
                    child: Text(
                      'Close',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Results List
          Expanded(
            child: GetBuilder(
              init: controller,
              builder: (context) {
                return Visibility(
                  replacement: const Center(
                    child: Text("No Result found"),
                  ),
                  visible: controller.marketList.isNotEmpty,
                  child: ListView.builder(
                    itemCount: controller.marketList.length,
                    itemBuilder: (BuildContext context, int index) {
                      var chart = controller.marketList[index];
                      final isEvenRow = index % 2 == 0;
                      
                      // Extract open and close digits
                      String openDigit = chart.digit?.split("").first ?? "*";
                      String closeDigit = chart.digit?.split("").last ?? "*";
                      
                      // Format date to DD/MM/YYYY
                      String formattedDate = '';
                      if (chart.timestamp != null) {
                        final date = chart.timestamp!;
                        formattedDate = '${date.day.toString().padLeft(2, '0')}/'
                                      '${date.month.toString().padLeft(2, '0')}/'
                                      '${date.year}';
                      }
                      
                      return Container(
                        color: isEvenRow ? AppColors.border : Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Center(
                                child: Text(
                                  formattedDate,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Center(
                                child: Text(
                                  openDigit,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Center(
                                child: Text(
                                  closeDigit,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              }
            ),
          ),
        ],
      ),
    );
  }
}