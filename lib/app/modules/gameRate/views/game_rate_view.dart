import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold/app/core/app_color.dart';
import 'package:gold/app/core/app_color.dart';

import '../controllers/game_rate_controller.dart';

class GameRateView extends GetView<GameRateController> {
  const GameRateView({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F3F0), // Light cream background
      appBar: AppBar(
        backgroundColor: const Color(0xFF6B2C91), // Purple color
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
          'Game Rate',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: false,
      ),
      body: GetBuilder(
        init: controller,
        builder: (_) {
          if (controller.isLoading) {
            return _buildLoadingState();
          }
          
          if (controller.gameRate == null) {
            return _buildErrorState();
          }
          
          return _buildRateList();
        }
      ),
    );
  }
  
  Widget _buildLoadingState() {
    return const Center(
      child: CircularProgressIndicator(
        color: Color(0xFF6B2C91),
      ),
    );
  }
  
  Widget _buildErrorState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Something went wrong",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          const Text("Unable to load game rates"),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => controller.fetchGameRate(),
            child: const Text("Try Again"),
          ),
        ],
      ),
    );
  }
  
  Widget _buildRateList() {
    final List<Map<String, dynamic>> gameRates = [
      {
        'title': 'Single',
        'rate': controller.gameRate?.singleDigit ?? 100,
      },
      {
        'title': 'Double',
        'rate': controller.gameRate?.jodiDigit ?? 1000,
      },
      {
        'title': 'Single Panna',
        'rate': controller.gameRate?.singlePana ?? 1600,
      },
      {
        'title': 'Double Panna',
        'rate': controller.gameRate?.doublePana ?? 3200,
      },
      {
        'title': 'Triple Panna',
        'rate': controller.gameRate?.triplePana ?? 10000,
      },
      {
        'title': 'Half Sangam',
        'rate': controller.gameRate?.halfSangam ?? 10000,
      },
      {
        'title': 'Full Sangam',
        'rate': controller.gameRate?.fullSangam ?? 100000,
      },
    ];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: gameRates.map((item) => _buildRateItem(
          title: item['title'],
          rate: item['rate'],
        )).toList(),
      ),
    );
  }
  
  Widget _buildRateItem({
    required String title,
    required int rate,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: const Color(0xFF6B2C91),
          width: 2,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFFF5F3F0),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '10/$rate',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}