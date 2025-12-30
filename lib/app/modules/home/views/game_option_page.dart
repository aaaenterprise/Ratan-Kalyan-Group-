import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math' show cos, sin, pi;
import 'package:gold/app/core/models/user_model.dart';
import 'package:gold/app/core/widgets/widgets.dart';
import 'package:gold/app/data/constant/assets_constant.dart';
import 'package:gold/app/modules/home/models/game_model.dart';
import 'package:gold/app/modules/home/views/create_bet_widget.dart';
import 'package:gold/app/routes/app_pages.dart';
// import '/home/claude/app_colors.dart'; // Import the new color theme
import '../../../core/app_color.dart';

class GameOptionPage extends StatelessWidget {
  final GameModel game;
  final UserModel user;
  const GameOptionPage({super.key, required this.game, required this.user});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, data) {
        Get.offAllNamed(Routes.HOME);
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.primary,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Get.offAllNamed(Routes.HOME);
            },
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: AppColors.textOnPrimary,
              size: 24,
            ),
          ),
          title: Text(
            game.gameName?.toUpperCase() ?? "",
            style: const TextStyle(
              color: AppColors.textOnPrimary,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
          centerTitle: false,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: AppColors.primaryGradient,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1,
            children: [
              _buildGameCard(
                context: context,
                title: "SINGLE\nDIGIT",
                icon: Icons.filter_1_outlined,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => CreateBetWidget(
                            user: user,
                            game: game,
                            gameType: "Single Digit",
                          ),
                    ),
                  );
                },
                isEnabled: true,
              ),
              _buildGameCard(
                context: context,
                title: "JODI\nDIGIT",
                icon: Icons.filter_2_outlined,
                onTap: () {
                  if (!game.todayResultDeclared! &&
                      game.isCurrentTimeLessThan(false)) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => CreateBetWidget(
                              user: user,
                              game: game,
                              gameType: "Jodi Digit",
                            ),
                      ),
                    );
                  } else {
                    CustomWidget.showSnackBar(
                      "Game is closed for this type",
                      bgColor: AppColors.cardBackground,
                      fgColor: AppColors.textPrimary,
                    );
                  }
                },
                isEnabled:
                    !game.todayResultDeclared! &&
                    game.isCurrentTimeLessThan(false),
              ),
              _buildGameCard(
                context: context,
                title: "SINGLE\nPANA",
                icon: Icons.looks_one_outlined,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => CreateBetWidget(
                            user: user,
                            game: game,
                            gameType: "Single Pana",
                          ),
                    ),
                  );
                },
                isEnabled: true,
              ),
              _buildGameCard(
                context: context,
                title: "DOUBLE\nPANA",
                icon: Icons.looks_two_outlined,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => CreateBetWidget(
                            user: user,
                            game: game,
                            gameType: "Double Pana",
                          ),
                    ),
                  );
                },
                isEnabled: true,
              ),
              _buildGameCard(
                context: context,
                title: "TRIPLE\nPANA",
                icon: Icons.looks_3_outlined,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => CreateBetWidget(
                            user: user,
                            game: game,
                            gameType: "Triple Pana",
                          ),
                    ),
                  );
                },
                isEnabled: true,
              ),
              _buildGameCard(
                context: context,
                title: "HALF\nSANGAM",
                icon: Icons.brightness_5_outlined,
                onTap: () {
                  if (!game.todayResultDeclared! &&
                      game.isCurrentTimeLessThan(false)) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => CreateBetWidget(
                              user: user,
                              game: game,
                              gameType: "Half Sangam",
                            ),
                      ),
                    );
                  } else {
                    CustomWidget.showSnackBar(
                      "Game is closed for this type",
                      bgColor: AppColors.cardBackground,
                      fgColor: AppColors.textPrimary,
                    );
                  }
                },
                isEnabled:
                    !game.todayResultDeclared! &&
                    game.isCurrentTimeLessThan(false),
              ),
              _buildGameCard(
                context: context,
                title: "FULL\nSANGAM",
                icon: Icons.brightness_7_outlined,
                onTap: () {
                  if (!game.todayResultDeclared! &&
                      game.isCurrentTimeLessThan(false)) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => CreateBetWidget(
                              user: user,
                              game: game,
                              gameType: "Full Sangam",
                            ),
                      ),
                    );
                  } else {
                    CustomWidget.showSnackBar(
                      "Game is closed for this type",
                      bgColor: AppColors.cardBackground,
                      fgColor: AppColors.textPrimary,
                    );
                  }
                },
                isEnabled:
                    !game.todayResultDeclared! &&
                    game.isCurrentTimeLessThan(false),
              ),
              _buildGameCard(
                context: context,
                title: "SP\nMOTOR",
                icon: Icons.electric_scooter_outlined,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => CreateBetWidget(
                            user: user,
                            game: game,
                            gameType: "SP Motor",
                          ),
                    ),
                  );
                },
                isEnabled: true,
              ),
              _buildGameCard(
                context: context,
                title: "DP\nMOTOR",
                icon: Icons.electric_bike_outlined,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => CreateBetWidget(
                            user: user,
                            game: game,
                            gameType: "DP Motor",
                          ),
                    ),
                  );
                },
                isEnabled: true,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGameCard({
    required BuildContext context,
    required String title,
    required IconData icon,
    required VoidCallback onTap,
    required bool isEnabled,
  }) {
    return GestureDetector(
      onTap:
          isEnabled
              ? onTap
              : () {
                CustomWidget.showSnackBar(
                  "Game is closed for this type",
                  bgColor: AppColors.cardBackground,
                  fgColor: AppColors.textPrimary,
                );
              },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient:
              isEnabled
                  ? AppColors.accentGradient
                  : LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.textTertiary.withOpacity(0.5),
                      AppColors.textSecondary.withOpacity(0.5),
                    ],
                  ),
          boxShadow: [
            BoxShadow(
              color:
                  isEnabled
                      ? AppColors.accent.withOpacity(0.3)
                      : AppColors.shadowLight,
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Decorative circles in background
            Positioned(
              top: -20,
              right: -20,
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.withOpacity(AppColors.textOnPrimary, 0.1),
                ),
              ),
            ),
            Positioned(
              bottom: -30,
              left: -30,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.withOpacity(AppColors.textOnPrimary, 0.08),
                ),
              ),
            ),

            // Main content
            Center(
              child: Container(
                width: 130,
                height: 130,
                decoration: BoxDecoration(
                  color: AppColors.cardBackground,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color:
                        isEnabled
                            ? AppColors.accent.withOpacity(0.3)
                            : AppColors.border,
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.shadowMedium,
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        gradient:
                            isEnabled
                                ? AppColors.accentGradient
                                : const LinearGradient(
                                  colors: [
                                    AppColors.textTertiary,
                                    AppColors.textSecondary,
                                  ],
                                ),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color:
                                isEnabled
                                    ? AppColors.accent.withOpacity(0.3)
                                    : AppColors.shadowLight,
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Icon(
                        icon,
                        size: 32,
                        color: AppColors.textOnPrimary,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color:
                              isEnabled
                                  ? AppColors.textPrimary
                                  : AppColors.textSecondary,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          height: 1.2,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Disabled overlay
            if (!isEnabled)
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: AppColors.overlay.withOpacity(0.1),
                  ),
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.error,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        "CLOSED",
                        style: TextStyle(
                          color: AppColors.textOnPrimary,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class HexagonBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;

  HexagonBorderPainter({required this.color, required this.strokeWidth});

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = color
          ..strokeWidth = strokeWidth
          ..style = PaintingStyle.stroke;

    final path = Path();
    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final radius = size.width * 0.35;

    // Create hexagon path
    for (int i = 0; i < 6; i++) {
      final angle = (i * 60) * (pi / 180);
      final x = centerX + radius * cos(angle);
      final y = centerY + radius * sin(angle);

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
