import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:gold/app/core/app_color.dart';
import 'package:gold/app/core/app_color.dart';

import '../controllers/star_line_win_history_controller.dart';
import 'package:intl/intl.dart';
class StarLineWinHistoryView extends GetView<StarLineWinHistoryController> {
  const StarLineWinHistoryView({Key? key}) : super(key: key);
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
                    if (controller.winningDataList.isEmpty) {
                      return _buildEmptyState();
                    }
                    
                    return _buildWinningList();
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
              const Text(
                "Winning History",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          
          // Filter Button (Optional - just for balance)
          Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: IconButton(
              onPressed: () {
                // Filter action can be added here if needed
              },
              icon: Icon(
                Icons.filter_list,
                color: AppColors.secondary,
                size: 22,
              ),
              tooltip: "Filter winnings",
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
              Icons.emoji_events_outlined,
              size: 80,
              color: AppColors.secondary.withOpacity(0.7),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            "No Winnings Yet",
            style: TextStyle(
              color: AppColors.secondary,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "Your winning bets will appear here",
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
                "Go to Games",
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
  
  // Winning List
  Widget _buildWinningList() {
    return ListView.builder(
      padding: const EdgeInsets.all(15),
      itemCount: controller.winningDataList.length,
      itemBuilder: (BuildContext context, int index) {
        var winHistory = controller.winningDataList[index];
        
        // Format the timestamp
        String formattedDate = "";
        try {
          if (winHistory.timestamp != null) {
            final timestamp = winHistory.timestamp.toString().split(".").first;
            final DateTime dateTime = DateTime.parse(timestamp);
            formattedDate = DateFormat('dd MMM yyyy, hh:mm a').format(dateTime);
          }
        } catch (e) {
          formattedDate = winHistory.timestamp?.toString().split(".").first ?? "N/A";
        }
        
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
              // Header
              Container(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.successDark,
                      AppColors.successDark,
                    ],
                  ),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            winHistory.gameName ?? "Game",
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 3),
                          Row(
                            children: [
                              Icon(
                                Icons.access_time,
                                color: AppColors.secondary,
                                size: 14,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                formattedDate,
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.9),
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: AppColors.secondary.withOpacity(0.5),
                          width: 1,
                        ),
                      ),
                      child: Text(
                        winHistory.betType ?? "Bet Type",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              // Content
              Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    // Trophy Icon
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.secondary.withOpacity(0.1),
                      ),
                      child: Icon(
                        Icons.emoji_events,
                        color: AppColors.secondary,
                        size: 30,
                      ),
                    ),
                    
                    const SizedBox(height: 15),
                    
                    // Winning Amount
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
                      decoration: BoxDecoration(
                        color: AppColors.success.shade50,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: AppColors.success.shade200,
                          width: 1,
                        ),
                      ),
                      child: Column(
                        children: [
                          Text(
                            "WINNING AMOUNT",
                            style: TextStyle(
                              color: AppColors.successDark,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            "₹${winHistory.winningAmount ?? 0}",
                            style: TextStyle(
                              color: AppColors.successDark,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 15),
                    
                    // Bid Details
                    Row(
                      children: [
                        Expanded(
                          child: _buildInfoItem(
                            label: "BID AMOUNT",
                            value: "₹${winHistory.betAmount ?? 0}",
                            valueStyle: TextStyle(
                              color: AppColors.primary,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          child: _buildInfoItem(
                            label: "PROFIT",
                            value: "₹${(winHistory.winningAmount ?? 0) - (winHistory.betAmount ?? 0)}",
                            valueStyle: TextStyle(
                              color: AppColors.successDark,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
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
  
  // Helper method for info items
  Widget _buildInfoItem({
    required String label,
    required String value,
    required TextStyle valueStyle,
    bool isFullWidth = false,
  }) {
    return Container(
      width: isFullWidth ? double.infinity : null,
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: Column(
        crossAxisAlignment: isFullWidth 
            ? CrossAxisAlignment.center 
            : CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            value,
            style: valueStyle,
            textAlign: isFullWidth ? TextAlign.center : TextAlign.start,
          ),
        ],
      ),
    );
  }
}
