import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold/app/core/widgets/widgets.dart';
import 'package:gold/app/data/constant/assets_constant.dart';
import 'package:gold/app/data/constant/color_constant.dart';
import 'package:gold/app/modules/gali-home/views/game_option_page.dart';
import 'package:gold/app/routes/app_pages.dart' show Routes;
import '../controllers/gali_home_controller.dart';

class GaliHomeView extends GetView<GaliHomeController> {
  const GaliHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: const Color(
          0xFF6B1C5C,
        ), // Purple color from screenshot
        title: const Text(
          'Gali Deshwar',
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
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
          // Rates section
          Container(
            width: double.infinity,
            color: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: GetBuilder(
              init: controller.galiRateController,
              builder: (context) {
                return Column(
                  children: [
                    Text(
                      'Single Digit  10/${controller.galiRateController.gameRate?.singleDigit ?? "--"}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[800],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Jodi  10/${controller.galiRateController.gameRate?.jodiDigit ?? "--"}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[800],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),

          // const SizedBox(height: 20),

          // History buttons
          if (controller.userController.userModel!.verify!)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () => Get.toNamed(Routes.GALI_BID),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        child: const Text(
                          'BID\nHISTORY',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () => Get.toNamed(Routes.GALI_WIN),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        child: const Text(
                          'RESULT\nHISTORY',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

          const SizedBox(height: 30),

          // Games list
          Expanded(
            child: GetBuilder(
              init: controller,
              builder: (context) {
                return Visibility(
                  replacement: const Center(child: CircularProgressIndicator()),
                  visible: !controller.isLoadingGames,
                  child: Visibility(
                    replacement: const Center(
                      child: Text("There is not any active game"),
                    ),
                    visible: controller.games.isNotEmpty,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: ListView.separated(
                        separatorBuilder:
                            (context, index) => const SizedBox(height: 15),
                        itemCount: controller.games.length,
                        itemBuilder: (BuildContext context, int index) {
                          final game = controller.games[index];
                          final isActive =
                              (!game.todayResultDeclared!) &&
                              game.active! &&
                              game.isCurrentTimeLessThan();
                          log(
                            "todayResultDeclared: ${game.todayResultDeclared}, active: ${game.active}, isCurrentTimeLessThan: ${game.isCurrentTimeLessThan()}",
                          );
                          log(
                            "game name: ${game.gameName}, isActive: $isActive",
                          );
                          return _buildGameCard(
                            game.gameName ?? "",
                            isActive
                                ? 'Betting is Running'
                                : 'Betting is CLOSED',
                            'Open Bids\n${game.getOpeningTimeToday() ?? ""}',
                            isActive,
                            context,
                            index,
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGameCard(
    String gameName,
    String status,
    String timing,
    bool isActive,
    BuildContext context,
    int index,
  ) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: const Border(
          left: BorderSide(color: Color(0xFF6B1C5C), width: 4),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  gameName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  status,
                  style: TextStyle(
                    fontSize: 14,
                    color: isActive ? Colors.green : Colors.red,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (timing.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    timing,
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                ],
              ],
            ),
          ),
          GetBuilder(
            init: controller.userController,
            builder: (context) {
              return controller.userController.userModel!.verify!
                  ? Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xFF6B1C5C),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildActionButton(Icons.bar_chart, 'Chart', () {
                          Get.toNamed(
                            Routes.GALI_CHART,
                            parameters: {
                              "gameName":
                                  controller.games[index].gameName ?? "",
                            },
                          );
                        }),
                        Container(
                          width: 1,
                          height: 40,
                          color: const Color(0xFF6B1C5C),
                        ),

                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: const Color(0xFF6B1C5C),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: IconButton(
                            onPressed: () {
                              isActive
                                  ? Get.offAll(
                                    () => GaliGameOptionPage(
                                      game: controller.games[index],
                                      user:
                                          controller.userController.userModel!,
                                    ),
                                  )
                                  : CustomWidget.showSnackBar("Biding Closed");
                            },
                            icon: Icon(
                              isActive ? Icons.play_arrow : Icons.close,
                              color: Colors.white,
                              size: 25,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                  : const SizedBox(width: 35);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
    IconData icon,
    String label,
    VoidCallback? onPressed,
  ) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color:
                    onPressed != null ? const Color(0xFF6B1C5C) : Colors.grey,
                size: 20,
              ),
              const SizedBox(height: 2),
              Text(
                label,
                style: TextStyle(
                  fontSize: 10,
                  color:
                      onPressed != null ? const Color(0xFF6B1C5C) : Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
