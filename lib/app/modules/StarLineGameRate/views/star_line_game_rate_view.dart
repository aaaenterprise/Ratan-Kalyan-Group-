import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold/app/data/constant/color_constant.dart';

import '../controllers/star_line_game_rate_controller.dart';

class StarLineGameRateView extends GetView<StarLineGameRateController> {
  const StarLineGameRateView({super.key});
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
            colors: [ColorConstant.primaryColor, ColorConstant.darkBackground],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Custom App Bar
              _buildAppBar(),

              // Content
              Expanded(child: _buildContent()),
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
                      color: ColorConstant.goldColor,
                    ),
                  ),
                  Text(
                    "M",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: ColorConstant.redColor,
                    ),
                  ),
                ],
              ),

              // Page Title
              const Text(
                "Game Rates",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),

          // Info Button
          Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: IconButton(
              onPressed: () {
                _showInfoDialog();
              },
              icon: Icon(
                Icons.info_outline,
                color: ColorConstant.goldColor,
                size: 22,
              ),
              tooltip: "Game Rate Information",
            ),
          ),
        ],
      ),
    );
  }

  // Content
  Widget _buildContent() {
    return GetBuilder(
      init: controller,
      builder: (_) {
        if (controller.isLoading) {
          return _buildLoadingState();
        }

        if (controller.gameRate == null) {
          return _buildErrorState();
        }

        return _buildRateList();
      },
    );
  }

  // Loading State
  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: ColorConstant.goldColor,
            strokeWidth: 3,
          ),
          const SizedBox(height: 20),
          Text(
            "Loading game rates...",
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  // Error State
  Widget _buildErrorState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.red.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.error_outline,
              color: Colors.red.shade300,
              size: 60,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            "Something went wrong",
            style: TextStyle(
              color: ColorConstant.goldColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "Unable to load game rates",
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 30),
          GestureDetector(
            onTap: () {
              // Refresh action
              controller.fetchGameRate();
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: ColorConstant.goldGradient),
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: ColorConstant.goldColor.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.refresh, color: Colors.white, size: 18),
                  SizedBox(width: 8),
                  Text(
                    "Try Again",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Rate List
  Widget _buildRateList() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        _buildHeader(),
        const SizedBox(height: 15),
        _buildRateCard(
          title: "Single Digit",
          rate: controller.gameRate?.singleDigit,
          iconPath: "assets/icons/single_digit.png", // Add your icon asset path
          color: Colors.blue.shade700,
        ),

        _buildRateCard(
          title: "Single Pana",
          rate: controller.gameRate?.singlePana,
          iconPath: "assets/icons/single_pana.png", // Add your icon asset path
          color: Colors.green.shade700,
        ),
        _buildRateCard(
          title: "Double Pana",
          rate: controller.gameRate?.doublePana,
          iconPath: "assets/icons/double_pana.png", // Add your icon asset path
          color: Colors.orange.shade700,
        ),
        _buildRateCard(
          title: "Triple Pana",
          rate: controller.gameRate?.triplePana,
          iconPath: "assets/icons/triple_pana.png", // Add your icon asset path
          color: Colors.red.shade700,
        ),
      ],
    );
  }

  // Header
  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: ColorConstant.goldColor.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: ColorConstant.goldColor.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.currency_exchange,
              color: ColorConstant.goldColor,
              size: 24,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "PAYOUT RATES",
                  style: TextStyle(
                    color: ColorConstant.goldColor,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  "For every ₹10 bet, you win the amount shown below",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Rate Card
  Widget _buildRateCard({
    required String title,
    required dynamic rate,
    required String iconPath,
    required Color color,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Left color accent
          Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            child: Container(
              width: 10,
              decoration: BoxDecoration(
                color: color,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  bottomLeft: Radius.circular(15),
                ),
              ),
            ),
          ),

          // Content
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 15, 15, 15),
            child: Row(
              children: [
                // Use Icon instead of Image if you don't have the assets
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    _getIconForGameType(title),
                    color: color,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: ColorConstant.textDark,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: ColorConstant.goldColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: ColorConstant.goldColor.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Text(
                        "₹10",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      Icon(
                        Icons.arrow_right_alt,
                        color: ColorConstant.goldColor,
                        size: 20,
                      ),
                      Text(
                        "₹${rate ?? 0}",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: ColorConstant.goldColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Get icon for game type
  IconData _getIconForGameType(String type) {
    switch (type) {
      case "Single Digit":
        return Icons.filter_1;
     
      case "Single Pana":
        return Icons.filter_2;
      case "Double Pana":
        return Icons.filter_3;
      case "Triple Pana":
        return Icons.filter_4;
   
      default:
        return Icons.filter_none;
    }
  }

  // Info Dialog
  void _showInfoDialog() {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: ColorConstant.goldColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.info_outline,
                  color: ColorConstant.goldColor,
                  size: 30,
                ),
              ),
              const SizedBox(height: 15),
              Text(
                "Game Rate Information",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: ColorConstant.primaryColor,
                ),
              ),
              const SizedBox(height: 15),
              Text(
                "These rates show how much you can win for every ₹10 bet placed on different game types. Higher payouts usually mean lower odds of winning.",
                style: TextStyle(
                  fontSize: 14,
                  color: ColorConstant.textDark,
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () => Get.back(),
                style: TextButton.styleFrom(
                  backgroundColor: ColorConstant.goldColor,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 10,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  "Got it",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
