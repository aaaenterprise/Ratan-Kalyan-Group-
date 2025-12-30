import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold/app/core/url.dart';
import 'package:gold/app/core/widgets/widgets.dart';
import 'package:gold/app/data/constant/assets_constant.dart';
import 'package:gold/app/data/constant/color_constant.dart';
import 'package:gold/app/modules/home/views/game_option_page.dart';
import 'package:gold/app/modules/home/widgets/Marquee_text_widget.dart';
import 'package:gold/app/modules/home/widgets/custome_crousel_widget.dart';
import 'package:gold/app/modules/home/widgets/custome_drawer_widget.dart';
import 'package:gold/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  Future<void> refresh() async {
    controller.loadGames();
    controller.userController.getUserProfile();
    controller.userController.getSettings();
    controller.loadImageSlider();
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => refresh(),
      color: ColorConstant.goldColor,
      backgroundColor: Colors.white,
      child: Scaffold(
        drawer: const CustomeDrawerWidget(),
        appBar: AppBar(
          title: const Text(
            "Kalki Matka",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          centerTitle: false,
          elevation: 0,
          backgroundColor: const Color(0xFF6B1C5C), // Purple background
          iconTheme: const IconThemeData(color: Colors.white),
          actions: [
            // Wallet display
            GetBuilder(
              init: controller.userController,
              builder: (_) {
                return controller.userController.userModel!.verify!
                    ? Container(
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.account_balance_wallet,
                            color: Colors.white,
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            controller.userController.userModel?.wallet
                                    ?.toInt()
                                    .toString() ??
                                "0",
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    )
                    : const SizedBox.shrink();
              },
            ),
            // Profile icon
            // Container(
            //   margin: const EdgeInsets.only(right: 12),
            //   decoration: const BoxDecoration(
            //     color: Colors.white,
            //     shape: BoxShape.circle,
            //   ),
            //   child: IconButton(
            //     onPressed: () {
            //       // Profile action
            //     },
            //     icon: const Icon(Icons.notifications, color: Color(0xFF6B1C5C)),
            //     iconSize: 30
            //   ),
            // ),
          ],
        ),
        body: Container(
          color: Colors.grey[100],
          child: Column(
            children: [
              // Banner/Advertisement Section
              GetBuilder(
                init: controller.userController,
                builder: (context) {
                  return Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      // border: Border.all(color: Colors.grey),
                      // borderRadius: BorderRadius.circular(8),
                      color: Colors.grey[400],
                    ),
                    child: MarqueeText(
                      text:
                          controller.userController.setting?.notice ??
                          "Welcome to Kalki Matka",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      duration: const Duration(seconds: 6),
                      gap: 100,
                    ),
                  );
                },
              ),

              // Action Buttons Grid
              GetBuilder(
                init: controller,
                builder: (context) {
                  return Visibility(
                    visible: controller.userController.userModel!.verify!,
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 12),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildCircularButton(
                            icon: Icons.add,
                            label: "Add Money",
                            color: const Color(0xFF6B1C5C),
                            onPressed: () => Get.offAllNamed(Routes.ADD_POINT),
                          ),
                          _buildCircularButton(
                            icon: Icons.account_balance_wallet,
                            label: "Withdraw",
                            color: const Color(0xFF6B1C5C),
                            onPressed:
                                () => Get.offAllNamed(Routes.WITHDRAW_POINT),
                          ),
                          _buildCircularButton(
                            icon: Icons.games,
                            label: "Gali Disawar",
                            color: const Color(0xFF6B1C5C),
                            onPressed: () => Get.toNamed(Routes.GALI_HOME),
                          ),
                          _buildCircularButton(
                            icon: Icons.trending_up,
                            label: "Game Rate",
                            color: const Color(0xFF6B1C5C),
                            onPressed: () {
                              // Game rate action
                              Get.toNamed(Routes.GAME_RATE);
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 16),

              // Games List
              Expanded(
                child: GetBuilder(
                  init: controller,
                  builder: (context) {
                    if (controller.isLoadingGames) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: ColorConstant.goldColor,
                        ),
                      );
                    }

                    if (controller.games.isEmpty) {
                      return Center(
                        child: Text(
                          "There are no active games",
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 16,
                          ),
                        ),
                      );
                    }

                    return ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      separatorBuilder:
                          (context, index) => const SizedBox(height: 12),
                      itemCount: controller.games.length,
                      itemBuilder: (BuildContext context, int index) {
                        final game = controller.games[index];
                        final bool isMarketRunning =
                            !game.todayResultDeclared! &&
                            game.active! &&
                            game.isCurrentTimeLessThan(true);

                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: const Color(0xFF6B1C5C),
                              width: 2,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Chart Icon
                                Column(
                                  children: [
                                    // Game timing
                                    Text(
                                      "${game.getOpeningTimeToday() ?? ""}\n${game.getClosingTimeToday() ?? ""}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey[600],
                                        height: 1.2,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF6B1C5C),
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      child: IconButton(
                                        onPressed: () {
                                          Get.toNamed(
                                            Routes.CHART,
                                            parameters: {
                                              "gameName": game.gameName ?? "",
                                            },
                                          );
                                        },
                                        icon: const Icon(
                                          Icons.bar_chart,
                                          color: Colors.white,
                                          size: 24,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                // const SizedBox(width: 16),

                                // Game Info
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    // Game name
                                    Text(
                                      game.gameName ?? "",
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(height: 8),

                                    // Result display
                                    Text(
                                      game.todayResultDeclared!
                                          ? "${(game.todayResult?.openPana != null && game.todayResult?.openPana != '') ? game.todayResult?.openPana : '***'}-${game.todayResult?.calculateAnk() ?? '**'}-${(game.todayResult?.closePana != null && game.todayResult?.closePana != '') ? game.todayResult?.closePana : '***'}"
                                          : "***-**-***",
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black54,
                                      ),
                                    ),
                                    const SizedBox(height: 4),

                                    // Market status
                                    Text(
                                      isMarketRunning
                                          ? "Market open"
                                          : "Market closed",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color:
                                            isMarketRunning
                                                ? Colors.green
                                                : Colors.red,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),

                                // Play Button
                                GetBuilder(
                                  init: controller.userController,
                                  builder: (context) {
                                    if (!controller
                                        .userController
                                        .userModel!
                                        .verify!) {
                                      return const SizedBox.shrink();
                                    }

                                    final bool canPlay =
                                        (game.todayResult?.closePana == null ||
                                            game.todayResult?.closePana ==
                                                '') &&
                                        game.active! &&
                                        game.isCurrentTimeLessThan(true);

                                    return Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF6B1C5C),
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      child: IconButton(
                                        onPressed: () {
                                          if (canPlay) {
                                            Get.offAll(
                                              () => GameOptionPage(
                                                game: game,
                                                user:
                                                    controller
                                                        .userController
                                                        .userModel!,
                                              ),
                                            );
                                          } else {
                                            CustomWidget.showSnackBar(
                                              "Bidding Closed",
                                            );
                                          }
                                        },
                                        icon: Icon(
                                          canPlay
                                              ? Icons.play_arrow
                                              : Icons.close,
                                          color: Colors.white,
                                          size: 28,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),

        // Bottom Navigation Bar
        bottomNavigationBar: Container(
          height: 80,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 4,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () => Get.toNamed(Routes.BID_HISTORY),
                child: _buildBottomNavItem(Icons.history, "My Bids"),
              ),
              InkWell(
                onTap: () => Get.toNamed(Routes.TRANSACTION),
                child: _buildBottomNavItem(Icons.book, "Passbook"),
              ),
              Container(
                width: 60,
                height: 60,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: const Color(0xFF6B1C5C),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: _buildBottomNavItem(
                  Icons.home_outlined,
                  "Home",
                  isSelected: true,
                ),
              ),
              InkWell(
                onTap: () => Get.toNamed(Routes.FUND),
                child: _buildBottomNavItem(Icons.account_balance, "Funds"),
              ),
              InkWell(
                onTap: () {
                  String url =
                      "whatsapp://send?phone=${controller.userController.setting?.whatsappSupport}&text=";
                  UrlLauncher.launchUrl(url);
                },
                child: _buildBottomNavItem(Icons.support_agent, "Support"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCircularButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return InkWell(
      onTap: onPressed,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(icon, color: Colors.white, size: 28),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavItem(
    IconData icon,
    String label, {
    bool isSelected = false,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: isSelected ? Colors.white : Colors.grey[600],
          size: isSelected ? 38 : 28,
        ),
        const SizedBox(height: 4),
        Visibility(
          visible: !isSelected,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: isSelected ? const Color(0xFF6B1C5C) : Colors.grey[600],
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ),
      ],
    );
  }
}
