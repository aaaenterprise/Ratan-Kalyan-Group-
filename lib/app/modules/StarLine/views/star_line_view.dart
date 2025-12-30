import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold/app/core/widgets/widgets.dart';
import 'package:gold/app/data/constant/assets_constant.dart';
import 'package:gold/app/data/constant/color_constant.dart';
import 'package:gold/app/modules/StarLine/views/game_option_page.dart';
import 'package:gold/app/routes/app_pages.dart';

import '../controllers/star_line_controller.dart';

class StarLineView extends GetView<StarLineController> {
  const StarLineView({super.key});
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
              ColorConstant.primaryColor,
              ColorConstant.darkBackground,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Custom App Bar
              _buildAppBar(),
              
              // Action Buttons for verified users
              _buildActionButtons(context),
              
              // Game List
              Expanded(
                child: _buildGameList(),
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
              Row(
                children: [
                  Icon(
                    Icons.star,
                    color: ColorConstant.goldColor,
                    size: 18,
                  ),
                  const SizedBox(width: 5),
                  const Text(
                    "Star Line",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
          
          // Wallet Balance
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: ColorConstant.goldGradient,
              ),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: ColorConstant.goldColor.withOpacity(0.3),
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.account_balance_wallet,
                  color: Colors.white,
                  size: 16,
                ),
                const SizedBox(width: 5),
                Text(
                  "₹${controller.userController.userModel?.wallet?.toInt() ?? 0}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
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
  
  // Action Buttons
  Widget _buildActionButtons(BuildContext context) {
    if (!controller.userController.userModel!.verify!) {
      return const SizedBox.shrink();
    }
    
    return Container(
      padding: const EdgeInsets.fromLTRB(15, 5, 15, 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildActionButton(
            icon: Icons.history,
            label: "BID HISTORY",
            onPressed: () => Get.toNamed(Routes.STAR_LINE_BID_HISTORY),
            gradientColors: [
              Colors.blue.shade600,
              Colors.blue.shade800,
            ],
          ),
          _buildActionButton(
            icon: Icons.monetization_on,
            label: "GAME RATE",
            onPressed: () => Get.toNamed(Routes.STAR_LINE_GAME_RATE),
            gradientColors: ColorConstant.goldGradient,
          ),
          _buildActionButton(
            icon: Icons.emoji_events,
            label: "WIN HISTORY",
            onPressed: () => Get.toNamed(Routes.STAR_LINE_WIN_HISTORY),
            gradientColors: [
              Colors.green.shade600,
              Colors.green.shade800,
            ],
          ),
        ],
      ),
    );
  }
  
  // Single Action Button
  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
    required List<Color> gradientColors,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 110,
        height: 80,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: 24,
            ),
            const SizedBox(height: 5),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
  
  // Game List
  Widget _buildGameList() {
    return GetBuilder(
      init: controller,
      builder: (context) {
        if (controller.isLoadingGames) {
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
                  "Loading games...",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          );
        }
        
        if (controller.games.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.event_busy,
                  size: 60,
                  color: Colors.white.withOpacity(0.5),
                ),
                const SizedBox(height: 20),
                Text(
                  "No Active Games Available",
                  style: TextStyle(
                    color: ColorConstant.goldColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "Check back later for new games",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          );
        }
        
        return ListView.builder(
          padding: const EdgeInsets.all(15),
          itemCount: controller.games.length,
          itemBuilder: (BuildContext context, int index) {
            final game = controller.games[index];
            final isMarketRunning = !game.todayResultDeclared! &&
                game.active! &&
                game.isCurrentTimeLessThan();
            
            return Container(
              margin: const EdgeInsets.only(bottom: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
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
                      border: Border.all(
                                  color: ColorConstant.redColor,
                                  width: 2.5,),
                      gradient: LinearGradient(
                        colors: [
                          ColorConstant.primaryColor,
                          ColorConstant.primaryColor.withOpacity(0.9),
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
                        // Chart Button
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(
                              Routes.STAR_LINE_CHART,
                              parameters: {"gameName": game.gameName ?? ""}
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              shape: BoxShape.circle,
                            ),
                            child: Image.asset(
                              AssetsConstant.marketButton,
                              width: 42,
                              // color: Colors.white,
                            ),
                          ),
                        ),
                        
                        // Game Name & Result
                        Column(
                          children: [
                            Text(
                              game.gameName ?? "",
                              style: TextStyle(
                                color: ColorConstant.goldColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
                              decoration: BoxDecoration(
                                color: Colors.black38,
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  color: ColorConstant.goldColor.withOpacity(0.3),
                                  width: 1,
                                ),
                              ),
                              child: Text(
                                game.todayResultDeclared!
                                  ? "${(game.todayResult?.openPana != null && game.todayResult?.openPana != '') ? game.todayResult?.openPana : '***'}-${game.todayResult?.calculateSingleAnk() ?? '*'}"
                                  : "***-*",
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        
                        // Play/Close Button
                        GetBuilder(
                          init: controller.userController,
                          builder: (context) {
                            if (!controller.userController.userModel!.verify!) {
                              return const SizedBox(width: 35);
                            }
                            
                            return GestureDetector(
                              onTap: () {
                                if (isMarketRunning) {
                                  Get.offAll(() => StarLineGameOptionPage(
                                    game: game,
                                    user: controller.userController.userModel!,
                                  ));
                                } else {
                                  CustomWidget.showSnackBar("Bidding Closed");
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: isMarketRunning
                                    ? Colors.green.withOpacity(0.2)
                                    : Colors.red.withOpacity(0.2),
                                  shape: BoxShape.circle,
                                ),
                                child: Image.asset(
                                  isMarketRunning
                                    ? AssetsConstant.playButton
                                    : AssetsConstant.closeButton,
                                  width: 42,
                                  // color: isMarketRunning
                                  //   ? Colors.green
                                  //   : Colors.red,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  
                  // Game Times & Status
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      children: [
                        // Open Time
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                "OPEN TIME",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                game.getOpeningTimeToday() ?? "N/A",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: ColorConstant.primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        // Status Badge
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                          decoration: BoxDecoration(
                            color: isMarketRunning
                              ? Colors.green.withOpacity(0.1)
                              : Colors.red.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: isMarketRunning
                                ? Colors.green.withOpacity(0.5)
                                : Colors.red.withOpacity(0.5),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                isMarketRunning
                                  ? Icons.play_circle_outline
                                  : Icons.pause_circle_outline,
                                size: 18,
                                color: isMarketRunning
                                  ? Colors.green
                                  : Colors.red,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                isMarketRunning
                                  ? "Market Running"
                                  : "Market Closed",
                                style: TextStyle(
                                  color: isMarketRunning
                                    ? Colors.green
                                    : Colors.red,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
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
          },
        );
      },
    );
  }
}