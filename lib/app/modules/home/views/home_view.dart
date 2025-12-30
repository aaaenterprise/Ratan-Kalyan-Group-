import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold/app/core/url.dart';
import 'package:gold/app/core/widgets/widgets.dart';
import 'package:gold/app/data/constant/assets_constant.dart';
import 'package:gold/app/modules/home/views/game_option_page.dart';
import 'package:gold/app/modules/home/widgets/Marquee_text_widget.dart';
import 'package:gold/app/modules/home/widgets/custome_crousel_widget.dart';
import 'package:gold/app/modules/home/widgets/custome_drawer_widget.dart';
import 'package:gold/app/routes/app_pages.dart';
import '../../../core/app_color.dart';

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
      color: AppColors.accent,
      backgroundColor: AppColors.cardBackground,
      child: Scaffold(
        drawer: const CustomeDrawerWidget(),
        appBar: AppBar(
          title: const Text(
            "Kalki Matka",
            style: TextStyle(
              color: AppColors.textOnPrimary,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          centerTitle: false,
          elevation: 0,
          backgroundColor: AppColors.primary,
          iconTheme: const IconThemeData(color: AppColors.textOnPrimary),
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
                        gradient: AppColors.secondaryGradient,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.secondary.withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.account_balance_wallet,
                            color: AppColors.textOnPrimary,
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            controller.userController.userModel?.wallet
                                    ?.toInt()
                                    .toString() ??
                                "0",
                            style: const TextStyle(
                              color: AppColors.textOnPrimary,
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
          ],
        ),
        body: Container(
          color: AppColors.background,
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
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          AppColors.accentLight.withOpacity(0.2),
                          AppColors.accent.withOpacity(0.2),
                          AppColors.accentLight.withOpacity(0.2),
                        ],
                      ),
                    ),
                    child: MarqueeText(
                      text:
                          controller.userController.setting?.notice ??
                          "Welcome to Kalki Matka",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                      duration: const Duration(seconds: 6),
                      gap: 100,
                    ),
                  );
                },
              ),

              const SizedBox(height: 16),

              // Action Buttons Grid
              GetBuilder(
                init: controller,
                builder: (context) {
                  return Visibility(
                    visible: controller.userController.userModel!.verify!,
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: AppColors.cardBackground,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: AppColors.borderSubtle,
                          width: 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.shadowMedium,
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildCircularButton(
                            icon: Icons.add_circle_outline,
                            label: "Add Money",
                            gradient: AppColors.successGradient,
                            onPressed: () => Get.offAllNamed(Routes.ADD_POINT),
                          ),
                          _buildCircularButton(
                            icon: Icons.account_balance_wallet_outlined,
                            label: "Withdraw",
                            gradient: AppColors.secondaryGradient,
                            onPressed:
                                () => Get.offAllNamed(Routes.WITHDRAW_POINT),
                          ),
                          _buildCircularButton(
                            icon: Icons.sports_esports_outlined,
                            label: "Gali Disawar",
                            gradient: AppColors.accentGradient,
                            onPressed: () => Get.toNamed(Routes.GALI_HOME),
                          ),
                          _buildCircularButton(
                            icon: Icons.trending_up,
                            label: "Game Rate",
                            gradient: AppColors.primaryGradient,
                            onPressed: () {
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
                      return const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.accent,
                          strokeWidth: 3,
                        ),
                      );
                    }

                    if (controller.games.isEmpty) {
                      return const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.sports_esports_outlined,
                              size: 64,
                              color: AppColors.textTertiary,
                            ),
                            SizedBox(height: 16),
                            Text(
                              "No active games available",
                              style: TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    return ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
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
                            color: AppColors.cardBackground,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color:
                                  isMarketRunning
                                      ? AppColors.accent
                                      : AppColors.border,
                              width: 2,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color:
                                    isMarketRunning
                                        ? AppColors.accent.withOpacity(0.15)
                                        : AppColors.shadowLight,
                                blurRadius: 8,
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
                                      style: const TextStyle(
                                        fontSize: 11,
                                        color: AppColors.textSecondary,
                                        height: 1.3,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 8),
                                    Container(
                                      width: 52,
                                      height: 52,
                                      decoration: BoxDecoration(
                                        gradient: AppColors.primaryGradient,
                                        borderRadius: BorderRadius.circular(26),
                                        boxShadow: [
                                          BoxShadow(
                                            color: AppColors.primary
                                                .withOpacity(0.3),
                                            blurRadius: 8,
                                            offset: const Offset(0, 4),
                                          ),
                                        ],
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
                                          Icons.bar_chart_rounded,
                                          color: AppColors.textOnPrimary,
                                          size: 24,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                // Game Info
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        // Game name
                                        Text(
                                          game.gameName ?? "",
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.textPrimary,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        const SizedBox(height: 8),

                                        // Result display
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 16,
                                            vertical: 8,
                                          ),
                                          decoration: BoxDecoration(
                                            color: AppColors.backgroundSubtle,
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                          ),
                                          child: Text(
                                            game.todayResultDeclared!
                                                ? "${(game.todayResult?.openPana != null && game.todayResult?.openPana != '') ? game.todayResult?.openPana : '***'}-${game.todayResult?.calculateAnk() ?? '**'}-${(game.todayResult?.closePana != null && game.todayResult?.closePana != '') ? game.todayResult?.closePana : '***'}"
                                                : "***-**-***",
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.textPrimary,
                                              letterSpacing: 1.5,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 8),

                                        // Market status
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 12,
                                            vertical: 4,
                                          ),
                                          decoration: BoxDecoration(
                                            color:
                                                isMarketRunning
                                                    ? AppColors.success
                                                        .withOpacity(0.1)
                                                    : AppColors.error
                                                        .withOpacity(0.1),
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                            border: Border.all(
                                              color:
                                                  isMarketRunning
                                                      ? AppColors.success
                                                      : AppColors.error,
                                              width: 1,
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Container(
                                                width: 6,
                                                height: 6,
                                                decoration: BoxDecoration(
                                                  color:
                                                      isMarketRunning
                                                          ? AppColors.success
                                                          : AppColors.error,
                                                  shape: BoxShape.circle,
                                                ),
                                              ),
                                              const SizedBox(width: 6),
                                              Text(
                                                isMarketRunning
                                                    ? "Market Open"
                                                    : "Market Closed",
                                                style: TextStyle(
                                                  fontSize: 11,
                                                  color:
                                                      isMarketRunning
                                                          ? AppColors.success
                                                          : AppColors.error,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
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
                                      width: 52,
                                      height: 52,
                                      decoration: BoxDecoration(
                                        gradient:
                                            canPlay
                                                ? AppColors.accentGradient
                                                : const LinearGradient(
                                                  colors: [
                                                    AppColors.textPrimary,
                                                    AppColors.primary,
                                                  ],
                                                ),
                                        borderRadius: BorderRadius.circular(26),
                                        boxShadow:
                                            canPlay
                                                ? [
                                                  BoxShadow(
                                                    color: AppColors.accent
                                                        .withOpacity(0.4),
                                                    blurRadius: 8,
                                                    offset: const Offset(0, 4),
                                                  ),
                                                ]
                                                : [],
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
                                              ? Icons.play_arrow_rounded
                                              : Icons.close_rounded,
                                          color: AppColors.textOnPrimary,
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
            color: AppColors.cardBackground,
            border: const Border(
              top: BorderSide(color: AppColors.borderSubtle, width: 1),
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.shadowMedium,
                blurRadius: 8,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () => Get.toNamed(Routes.BID_HISTORY),
                borderRadius: BorderRadius.circular(12),
                child: _buildBottomNavItem(Icons.history_rounded, "My Bids"),
              ),
              InkWell(
                onTap: () => Get.toNamed(Routes.TRANSACTION),
                borderRadius: BorderRadius.circular(12),
                child: _buildBottomNavItem(Icons.book_outlined, "Passbook"),
              ),
              Container(
                width: 64,
                height: 64,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(32),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.4),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: _buildBottomNavItem(
                  Icons.home_rounded,
                  "Home",
                  isSelected: true,
                ),
              ),
              InkWell(
                onTap: () => Get.toNamed(Routes.FUND),
                borderRadius: BorderRadius.circular(12),
                child: _buildBottomNavItem(
                  Icons.account_balance_outlined,
                  "Funds",
                ),
              ),
              InkWell(
                onTap: () {
                  String url =
                      "whatsapp://send?phone=${controller.userController.setting?.whatsappSupport}&text=";
                  UrlLauncher.launchUrl(url);
                },
                borderRadius: BorderRadius.circular(12),
                child: _buildBottomNavItem(
                  Icons.support_agent_outlined,
                  "Support",
                ),
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
    required LinearGradient gradient,
    required VoidCallback onPressed,
  }) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              gradient: gradient,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: gradient.colors.first.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(icon, color: AppColors.textOnPrimary, size: 26),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color:
                isSelected ? AppColors.textOnPrimary : AppColors.textSecondary,
            size: isSelected ? 32 : 26,
          ),
          const SizedBox(height: 4),
          Visibility(
            visible: !isSelected,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 10,
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:gold/app/core/url.dart';
// import 'package:gold/app/core/widgets/widgets.dart';
// import 'package:gold/app/data/constant/assets_constant.dart';
// import 'package:gold/app/data/constant/color_constant.dart';
// import 'package:gold/app/modules/home/views/game_option_page.dart';
// import 'package:gold/app/modules/home/widgets/Marquee_text_widget.dart';
// import 'package:gold/app/modules/home/widgets/custome_crousel_widget.dart';
// import 'package:gold/app/modules/home/widgets/custome_drawer_widget.dart';
// import 'package:gold/app/routes/app_pages.dart';

// import '../controllers/home_controller.dart';

// class HomeView extends GetView<HomeController> {
//   const HomeView({super.key});

//   Future<void> refresh() async {
//     controller.loadGames();
//     controller.userController.getUserProfile();
//     controller.userController.getSettings();
//     controller.loadImageSlider();
//     await Future.delayed(const Duration(seconds: 1));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return RefreshIndicator(
//       onRefresh: () => refresh(),
//       color: ColorConstant.goldColor,
//       backgroundColor: Colors.white,
//       child: Scaffold(
//         drawer: const CustomeDrawerWidget(),
//         appBar: AppBar(
//           title: const Text(
//             "Kalki Matka",
//             style: TextStyle(
//               color: Colors.white,
//               fontWeight: FontWeight.bold,
//               fontSize: 20,
//             ),
//           ),
//           centerTitle: false,
//           elevation: 0,
//           backgroundColor: const Color(0xFF6B1C5C), // Purple background
//           iconTheme: const IconThemeData(color: Colors.white),
//           actions: [
//             // Wallet display
//             GetBuilder(
//               init: controller.userController,
//               builder: (_) {
//                 return controller.userController.userModel!.verify!
//                     ? Container(
//                       margin: const EdgeInsets.only(right: 8),
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 12,
//                         vertical: 6,
//                       ),
//                       decoration: BoxDecoration(
//                         color: Colors.white.withOpacity(0.2),
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                       child: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           const Icon(
//                             Icons.account_balance_wallet,
//                             color: Colors.white,
//                             size: 16,
//                           ),
//                           const SizedBox(width: 4),
//                           Text(
//                             controller.userController.userModel?.wallet
//                                     ?.toInt()
//                                     .toString() ??
//                                 "0",
//                             style: const TextStyle(
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 14,
//                             ),
//                           ),
//                         ],
//                       ),
//                     )
//                     : const SizedBox.shrink();
//               },
//             ),
//             // Profile icon
//             // Container(
//             //   margin: const EdgeInsets.only(right: 12),
//             //   decoration: const BoxDecoration(
//             //     color: Colors.white,
//             //     shape: BoxShape.circle,
//             //   ),
//             //   child: IconButton(
//             //     onPressed: () {
//             //       // Profile action
//             //     },
//             //     icon: const Icon(Icons.notifications, color: Color(0xFF6B1C5C)),
//             //     iconSize: 30
//             //   ),
//             // ),
//           ],
//         ),
//         body: Container(
//           color: Colors.grey[100],
//           child: Column(
//             children: [
//               // Banner/Advertisement Section
//               GetBuilder(
//                 init: controller.userController,
//                 builder: (context) {
//                   return Container(
//                     width: double.infinity,
//                     height: 50,
//                     decoration: BoxDecoration(
//                       // border: Border.all(color: Colors.grey),
//                       // borderRadius: BorderRadius.circular(8),
//                       color: Colors.grey[400],
//                     ),
//                     child: MarqueeText(
//                       text:
//                           controller.userController.setting?.notice ??
//                           "Welcome to Kalki Matka",
//                       style: const TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                       ),
//                       duration: const Duration(seconds: 6),
//                       gap: 100,
//                     ),
//                   );
//                 },
//               ),

//               // Action Buttons Grid
//               GetBuilder(
//                 init: controller,
//                 builder: (context) {
//                   return Visibility(
//                     visible: controller.userController.userModel!.verify!,
//                     child: Container(
//                       margin: const EdgeInsets.symmetric(horizontal: 12),
//                       padding: const EdgeInsets.all(20),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(12),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.05),
//                             blurRadius: 4,
//                             offset: const Offset(0, 2),
//                           ),
//                         ],
//                       ),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           _buildCircularButton(
//                             icon: Icons.add,
//                             label: "Add Money",
//                             color: const Color(0xFF6B1C5C),
//                             onPressed: () => Get.offAllNamed(Routes.ADD_POINT),
//                           ),
//                           _buildCircularButton(
//                             icon: Icons.account_balance_wallet,
//                             label: "Withdraw",
//                             color: const Color(0xFF6B1C5C),
//                             onPressed:
//                                 () => Get.offAllNamed(Routes.WITHDRAW_POINT),
//                           ),
//                           _buildCircularButton(
//                             icon: Icons.games,
//                             label: "Gali Disawar",
//                             color: const Color(0xFF6B1C5C),
//                             onPressed: () => Get.toNamed(Routes.GALI_HOME),
//                           ),
//                           _buildCircularButton(
//                             icon: Icons.trending_up,
//                             label: "Game Rate",
//                             color: const Color(0xFF6B1C5C),
//                             onPressed: () {
//                               // Game rate action
//                               Get.toNamed(Routes.GAME_RATE);
//                             },
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               ),

//               const SizedBox(height: 16),

//               // Games List
//               Expanded(
//                 child: GetBuilder(
//                   init: controller,
//                   builder: (context) {
//                     if (controller.isLoadingGames) {
//                       return Center(
//                         child: CircularProgressIndicator(
//                           color: ColorConstant.goldColor,
//                         ),
//                       );
//                     }

//                     if (controller.games.isEmpty) {
//                       return Center(
//                         child: Text(
//                           "There are no active games",
//                           style: TextStyle(
//                             color: Colors.grey[600],
//                             fontSize: 16,
//                           ),
//                         ),
//                       );
//                     }

//                     return ListView.separated(
//                       padding: const EdgeInsets.symmetric(horizontal: 12),
//                       separatorBuilder:
//                           (context, index) => const SizedBox(height: 12),
//                       itemCount: controller.games.length,
//                       itemBuilder: (BuildContext context, int index) {
//                         final game = controller.games[index];
//                         final bool isMarketRunning =
//                             !game.todayResultDeclared! &&
//                             game.active! &&
//                             game.isCurrentTimeLessThan(true);

//                         return Container(
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(12),
//                             border: Border.all(
//                               color: const Color(0xFF6B1C5C),
//                               width: 2,
//                             ),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.black.withOpacity(0.05),
//                                 blurRadius: 4,
//                                 offset: const Offset(0, 2),
//                               ),
//                             ],
//                           ),
//                           child: Padding(
//                             padding: const EdgeInsets.all(16),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 // Chart Icon
//                                 Column(
//                                   children: [
//                                     // Game timing
//                                     Text(
//                                       "${game.getOpeningTimeToday() ?? ""}\n${game.getClosingTimeToday() ?? ""}",
//                                       style: TextStyle(
//                                         fontSize: 12,
//                                         color: Colors.grey[600],
//                                         height: 1.2,
//                                       ),
//                                     ),
//                                     const SizedBox(height: 4),
//                                     Container(
//                                       width: 50,
//                                       height: 50,
//                                       decoration: BoxDecoration(
//                                         color: const Color(0xFF6B1C5C),
//                                         borderRadius: BorderRadius.circular(25),
//                                       ),
//                                       child: IconButton(
//                                         onPressed: () {
//                                           Get.toNamed(
//                                             Routes.CHART,
//                                             parameters: {
//                                               "gameName": game.gameName ?? "",
//                                             },
//                                           );
//                                         },
//                                         icon: const Icon(
//                                           Icons.bar_chart,
//                                           color: Colors.white,
//                                           size: 24,
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),

//                                 // const SizedBox(width: 16),

//                                 // Game Info
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.center,
//                                   children: [
//                                     // Game name
//                                     Text(
//                                       game.gameName ?? "",
//                                       style: const TextStyle(
//                                         fontSize: 18,
//                                         fontWeight: FontWeight.bold,
//                                         color: Colors.black,
//                                       ),
//                                     ),
//                                     const SizedBox(height: 8),

//                                     // Result display
//                                     Text(
//                                       game.todayResultDeclared!
//                                           ? "${(game.todayResult?.openPana != null && game.todayResult?.openPana != '') ? game.todayResult?.openPana : '***'}-${game.todayResult?.calculateAnk() ?? '**'}-${(game.todayResult?.closePana != null && game.todayResult?.closePana != '') ? game.todayResult?.closePana : '***'}"
//                                           : "***-**-***",
//                                       style: const TextStyle(
//                                         fontSize: 16,
//                                         fontWeight: FontWeight.w600,
//                                         color: Colors.black54,
//                                       ),
//                                     ),
//                                     const SizedBox(height: 4),

//                                     // Market status
//                                     Text(
//                                       isMarketRunning
//                                           ? "Market open"
//                                           : "Market closed",
//                                       style: TextStyle(
//                                         fontSize: 12,
//                                         color:
//                                             isMarketRunning
//                                                 ? Colors.green
//                                                 : Colors.red,
//                                         fontWeight: FontWeight.w500,
//                                       ),
//                                     ),
//                                   ],
//                                 ),

//                                 // Play Button
//                                 GetBuilder(
//                                   init: controller.userController,
//                                   builder: (context) {
//                                     if (!controller
//                                         .userController
//                                         .userModel!
//                                         .verify!) {
//                                       return const SizedBox.shrink();
//                                     }

//                                     final bool canPlay =
//                                         (game.todayResult?.closePana == null ||
//                                             game.todayResult?.closePana ==
//                                                 '') &&
//                                         game.active! &&
//                                         game.isCurrentTimeLessThan(true);

//                                     return Container(
//                                       width: 50,
//                                       height: 50,
//                                       decoration: BoxDecoration(
//                                         color: const Color(0xFF6B1C5C),
//                                         borderRadius: BorderRadius.circular(25),
//                                       ),
//                                       child: IconButton(
//                                         onPressed: () {
//                                           if (canPlay) {
//                                             Get.offAll(
//                                               () => GameOptionPage(
//                                                 game: game,
//                                                 user:
//                                                     controller
//                                                         .userController
//                                                         .userModel!,
//                                               ),
//                                             );
//                                           } else {
//                                             CustomWidget.showSnackBar(
//                                               "Bidding Closed",
//                                             );
//                                           }
//                                         },
//                                         icon: Icon(
//                                           canPlay
//                                               ? Icons.play_arrow
//                                               : Icons.close,
//                                           color: Colors.white,
//                                           size: 28,
//                                         ),
//                                       ),
//                                     );
//                                   },
//                                 ),
//                               ],
//                             ),
//                           ),
//                         );
//                       },
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),

//         // Bottom Navigation Bar
//         bottomNavigationBar: Container(
//           height: 80,
//           decoration: BoxDecoration(
//             color: Colors.white,
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.1),
//                 blurRadius: 4,
//                 offset: const Offset(0, -2),
//               ),
//             ],
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               InkWell(
//                 onTap: () => Get.toNamed(Routes.BID_HISTORY),
//                 child: _buildBottomNavItem(Icons.history, "My Bids"),
//               ),
//               InkWell(
//                 onTap: () => Get.toNamed(Routes.TRANSACTION),
//                 child: _buildBottomNavItem(Icons.book, "Passbook"),
//               ),
//               Container(
//                 width: 60,
//                 height: 60,
//                 alignment: Alignment.center,
//                 decoration: BoxDecoration(
//                   color: const Color(0xFF6B1C5C),
//                   borderRadius: BorderRadius.circular(30),
//                 ),
//                 child: _buildBottomNavItem(
//                   Icons.home_outlined,
//                   "Home",
//                   isSelected: true,
//                 ),
//               ),
//               InkWell(
//                 onTap: () => Get.toNamed(Routes.FUND),
//                 child: _buildBottomNavItem(Icons.account_balance, "Funds"),
//               ),
//               InkWell(
//                 onTap: () {
//                   String url =
//                       "whatsapp://send?phone=${controller.userController.setting?.whatsappSupport}&text=";
//                   UrlLauncher.launchUrl(url);
//                 },
//                 child: _buildBottomNavItem(Icons.support_agent, "Support"),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildCircularButton({
//     required IconData icon,
//     required String label,
//     required Color color,
//     required VoidCallback onPressed,
//   }) {
//     return InkWell(
//       onTap: onPressed,
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Container(
//             width: 60,
//             height: 60,
//             decoration: BoxDecoration(
//               color: color,
//               shape: BoxShape.circle,
//               boxShadow: [
//                 BoxShadow(
//                   color: color.withOpacity(0.3),
//                   blurRadius: 8,
//                   offset: const Offset(0, 4),
//                 ),
//               ],
//             ),
//             child: Icon(icon, color: Colors.white, size: 28),
//           ),
//           const SizedBox(height: 8),
//           Text(
//             label,
//             style: const TextStyle(
//               fontSize: 12,
//               fontWeight: FontWeight.w500,
//               color: Colors.black87,
//             ),
//             textAlign: TextAlign.center,
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildBottomNavItem(
//     IconData icon,
//     String label, {
//     bool isSelected = false,
//   }) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Icon(
//           icon,
//           color: isSelected ? Colors.white : Colors.grey[600],
//           size: isSelected ? 38 : 28,
//         ),
//         const SizedBox(height: 4),
//         Visibility(
//           visible: !isSelected,
//           child: Text(
//             label,
//             style: TextStyle(
//               fontSize: 10,
//               color: isSelected ? const Color(0xFF6B1C5C) : Colors.grey[600],
//               fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
