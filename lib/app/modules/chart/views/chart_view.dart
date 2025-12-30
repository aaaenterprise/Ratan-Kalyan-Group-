import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold/app/core/app_color.dart';
import 'package:gold/app/core/app_color.dart';
import 'package:gold/app/modules/chart/models/market_result_model.dart' show MarketResultModel;

import '../controllers/chart_controller.dart';

class ChartView extends GetView<ChartController> {
  const ChartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const AppColors.primary,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 24,
          ),
        ),
        title: const Text(
          "Chart Result",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: false,
      ),
      body: GetBuilder(
        init: controller,
        builder: (context) {
          if (controller.marketList.isEmpty) {
            return _buildEmptyState();
          }

          return Column(
            children: [
              // Table Header
              Container(
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                decoration: BoxDecoration(
                  color: AppColors.background,
                  border: Border(
                    bottom: BorderSide(color: AppColors.border!, width: 1),
                  ),
                ),
                child: const Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Text(
                        "Date",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        "Open",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        "Jodi",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        "Close",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),

              // Table Data
              Expanded(
                child: ListView.builder(
                  itemCount: controller.marketList.length,
                  itemBuilder: (BuildContext context, int index) {
                    var chart = controller.marketList[index];
                    
                    return Container(
                      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                      decoration: BoxDecoration(
                        color: index % 2 == 0 ? Colors.white : AppColors.surface,
                        border: Border(
                          bottom: BorderSide(color: AppColors.border!, width: 0.5),
                        ),
                      ),
                      child: Row(
                        children: [
                          // Date
                          Expanded(
                            flex: 3,
                            child: Text(
                              _formatDateForTable(chart),
                              style: const TextStyle(
                                fontSize: 14,
                                color: AppColors.textPrimary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          
                          // Open
                          Expanded(
                            flex: 2,
                            child: Text(
                              (chart.openPana != null && chart.openPana != '') 
                                  ? chart.openPana ?? '' 
                                  : '***',
                              style: const TextStyle(
                                fontSize: 14,
                                color: AppColors.textPrimary,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          
                          // Jodi
                          Expanded(
                            flex: 2,
                            child: Text(
                              chart.calculateAnk() ?? '**',
                              style: const TextStyle(
                                fontSize: 14,
                                color: AppColors.textPrimary,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          
                          // Close
                          Expanded(
                            flex: 2,
                            child: Text(
                              (chart.closePana != null && chart.closePana != '') 
                                  ? chart.closePana ?? '' 
                                  : '***',
                              style: const TextStyle(
                                fontSize: 14,
                                color: AppColors.textPrimary,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  String _formatDateForTable(MarketResultModel  chart) {
    // Format date as DD/MM/YYYY to match the screenshot
    try {
      var formattedDate = chart.timestamp;
      return formattedDate.toString().split(' ').first.split('-').reversed.join('/');
      // return "${formattedDate.dayOfMonth.toString().padLeft(2, '0')}/${formattedDate.monthOfYear.toString().padLeft(2, '0')}/${formattedDate.year}";
    } catch (e) {
      return "N/A";
    }
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.insert_chart_outlined,
            size: 80,
            color: AppColors.textSecondary,
          ),
          const SizedBox(height: 20),
          Text(
            "No Results Found",
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "Check back later for game results",
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}