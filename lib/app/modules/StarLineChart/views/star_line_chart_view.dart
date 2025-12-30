import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:gold/app/core/app_color.dart';
import 'package:gold/app/core/app_color.dart';

import '../controllers/star_line_chart_controller.dart';

class StarLineChartView extends GetView<StarLineChartController> {
  const StarLineChartView({Key? key}) : super(key: key);
  @override
    Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.primary,
              AppColors.primaryDark,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Custom App Bar
              _buildAppBar(),
              
              // Content
              Expanded(
                child: GetBuilder(
                  init: controller,
                  builder: (context) {
                    if (controller.marketList.isEmpty) {
                      return _buildEmptyState();
                    }
                    
                    return _buildChartList();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  // Custom App Bar
  Widget _buildAppBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Back Button
          Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: IconButton(
              onPressed: () => Get.back(),
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
          
          // Title
          Column(
            children: [
              // Gold Kalyan Logo Text
              Row(
                children: [
                  Text(
                    "K",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.secondary,
                    ),
                  ),
                  Text(
                    "M",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.error,
                    ),
                  ),
                ],
              ),
              
              // Page Title
              Text(
                controller.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          
          // Calendar Button
          Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: IconButton(
              onPressed: () {
                // Calendar action can be added here if needed
              },
              icon: Icon(
                Icons.calendar_month,
                color: AppColors.secondary,
                size: 22,
              ),
              tooltip: "Calendar view",
            ),
          ),
        ],
      ),
    );
  }
  
  // Empty State
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(25),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(0.1),
            ),
            child: Icon(
              Icons.insert_chart_outlined,
              size: 80,
              color: AppColors.secondary.withOpacity(0.7),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            "No Results Found",
            style: TextStyle(
              color: AppColors.secondary,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "Check back later for game results",
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 30),
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                gradient: AppColors.secondaryGradient,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.secondary.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Text(
                "Go Back",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  // Chart List
  Widget _buildChartList() {
    return ListView.builder(
      padding: const EdgeInsets.all(15),
      itemCount: controller.marketList.length,
      itemBuilder: (BuildContext context, int index) {
        var chart = controller.marketList[index];
        bool hasFullResult = chart.openPana != null && chart.openPana != '' ;
        
        return Container(
          margin: const EdgeInsets.only(bottom: 15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: AppColors.shadowMedium,
                blurRadius: 8,
                spreadRadius: 1,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              // Date Header
              Container(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.accent,
                    width: 2.5,),
                  gradient: LinearGradient(
                    colors: [
                      AppColors.primary,
                      AppColors.primary.withOpacity(0.9),
                    ],
                  ),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.calendar_today,
                      color: AppColors.secondary,
                      size: 20,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      "${chart.formatDate().dayName} (${chart.formatDate().monthName} ${chart.formatDate().dayOfMonth})",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              
              // Results Content
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: hasFullResult 
                      ? AppColors.success.withOpacity(0.05) 
                      : Colors.orange.withOpacity(0.05),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // Open Result
                    _buildResultItem(
                      label: "OPEN",
                      value: (chart.openPana != null && chart.openPana != '')
                          ? chart.openPana ?? ''
                          : '***',
                      isAvailable: chart.openPana != null && chart.openPana != '',
                    ),
                    
                    // Center Divider
                    Container(
                      height: 70,
                      width: 1,
                      color: Colors.grey.withOpacity(0.3),
                    ),
                    
                    // Jodi Result
                    _buildResultItem(
                      label: "ANK",
                      value: chart.calculateSingleAnk() ?? '*',
                      isAvailable: true,
                      isCentered: true,
                    ),
                    
                    // Center Divider
                    Container(
                      height: 70,
                      width: 1,
                      color: Colors.grey.withOpacity(0.3),
                    ),
                    
                   
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
  
  // Helper method for result items
  Widget _buildResultItem({
    required String label,
    required String value,
    required bool isAvailable,
    bool isCentered = false,
  }) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            color: AppColors.primary,
            fontSize: 12,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          decoration: BoxDecoration(
            color: isAvailable 
                ? isCentered
                    ? AppColors.secondary.withOpacity(0.1)
                    : AppColors.success.withOpacity(0.1)
                : Colors.orange.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isAvailable 
                  ? isCentered
                      ? AppColors.secondary.withOpacity(0.3)
                      : AppColors.success.withOpacity(0.3)
                  : Colors.orange.withOpacity(0.3),
              width: 1,
            ),
          ),
          child: Text(
            value,
            style: TextStyle(
              color: isAvailable 
                  ? isCentered
                      ? AppColors.secondary
                      : AppColors.successDark
                  : AppColors.warningDark,
              fontSize: isCentered ? 20 : 18,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
        ),
        if (!isAvailable && !isCentered)
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Text(
              "PENDING",
              style: TextStyle(
                color: AppColors.warningDark,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
      ],
    );
  }
}
