import 'package:flutter/material.dart';
import 'package:get/get.dart';
// Add this import at the top if not present
import 'dart:math' show cos, sin;
import 'package:gold/app/core/models/user_model.dart';
import 'package:gold/app/core/widgets/widgets.dart';
import 'package:gold/app/data/constant/assets_constant.dart';
import 'package:gold/app/data/constant/color_constant.dart';
import 'package:gold/app/modules/home/models/game_model.dart';
import 'package:gold/app/modules/home/views/create_bet_widget.dart';
import 'package:gold/app/routes/app_pages.dart';

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
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          backgroundColor: const Color(0xFF6B1C5C),
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Get.offAllNamed(Routes.HOME);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 24,
            ),
          ),
          title: Text(
            game.gameName?.toUpperCase() ?? "",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: false,
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
                icon: Icons.casino,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreateBetWidget(
                        user: user,
                        game: game,
                        gameType: "Single Digit",
                      ),
                    ),
                  );
                },
                isEnabled: true,
              ),
              // _buildGameCard(
              //   context: context,
              //   title: "ODD DIGITS",
              //   icon: Icons.filter_1,
              //   onTap: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //         builder: (context) => CreateBetWidget(
              //           user: user,
              //           game: game,
              //           gameType: "Odd Digits",
              //         ),
              //       ),
              //     );
              //   },
              //   isEnabled: true,
              // ),
              _buildGameCard(
                context: context,
                title: "JODI\nDIGIT",
                icon: Icons.casino,
                onTap: () {
                  if (!game.todayResultDeclared! && game.isCurrentTimeLessThan(false)) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CreateBetWidget(
                          user: user,
                          game: game,
                          gameType: "Jodi Digit",
                        ),
                      ),
                    );
                  } else {
                    CustomWidget.showSnackBar(
                      "Game is closed for this type",
                      bgColor: Colors.white,
                      fgColor: Colors.black,
                    );
                  }
                },
                isEnabled: !game.todayResultDeclared! && game.isCurrentTimeLessThan(false),
              ),
              // _buildGameCard(
              //   context: context,
              //   title: "RED BRACKET",
              //   icon: Icons.style,
              //   onTap: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //         builder: (context) => CreateBetWidget(
              //           user: user,
              //           game: game,
              //           gameType: "Red Bracket",
              //         ),
              //       ),
              //     );
              //   },
              //   isEnabled: true,
              // ),
              _buildGameCard(
                context: context,
                title: "SINGLE\nPANA",
                icon: Icons.looks_one,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreateBetWidget(
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
                icon: Icons.looks_two,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreateBetWidget(
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
                icon: Icons.looks_3,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreateBetWidget(
                        user: user,
                        game: game,
                        gameType: "Triple Pana",
                      ),
                    ),
                  );
                },
                isEnabled: true,
              ),
              // _buildGameCard(
              //   context: context,
              //   title: "SP DP TP\nMOTOR",
              //   icon: Icons.settings,
              //   onTap: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //         builder: (context) => CreateBetWidget(
              //           user: user,
              //           game: game,
              //           gameType: "SP DP TP Motor",
              //         ),
              //       ),
              //     );
              //   },
              //   isEnabled: true,
              // ),
              _buildGameCard(
                context: context,
                title: "HALF\nSANGAM",
                icon: Icons.brightness_5,
                onTap: () {
                  if (!game.todayResultDeclared! && game.isCurrentTimeLessThan(false)) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CreateBetWidget(
                          user: user,
                          game: game,
                          gameType: "Half Sangam",
                        ),
                      ),
                    );
                  } else {
                    CustomWidget.showSnackBar(
                      "Game is closed for this type",
                      bgColor: Colors.white,
                      fgColor: Colors.black,
                    );
                  }
                },
                isEnabled: !game.todayResultDeclared! && game.isCurrentTimeLessThan(false),
              ),
              _buildGameCard(
                context: context,
                title: "FULL\nSANGAM",
                icon: Icons.brightness_7,
                onTap: () {
                  if (!game.todayResultDeclared! && game.isCurrentTimeLessThan(false)) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CreateBetWidget(
                          user: user,
                          game: game,
                          gameType: "Full Sangam",
                        ),
                      ),
                    );
                  } else {
                    CustomWidget.showSnackBar(
                      "Game is closed for this type",
                      bgColor: Colors.white,
                      fgColor: Colors.black,
                    );
                  }
                },
                isEnabled: !game.todayResultDeclared! && game.isCurrentTimeLessThan(false),
              ),
              _buildGameCard(
                context: context,
                title: "SP\nMOTOR",
                icon: Icons.motorcycle,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreateBetWidget(
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
                icon: Icons.electric_bike,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreateBetWidget(
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
      onTap: isEnabled ? onTap : () {
        CustomWidget.showSnackBar(
          "Game is closed for this type",
          bgColor: Colors.white,
          fgColor: Colors.black,
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isEnabled
                ? [
                    const Color(0xFF5B8DB8),
                    const Color(0xFF4A7BA7),
                  ]
                : [
                    Colors.grey[400]!,
                    Colors.grey[500]!,
                  ],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Hexagonal border design
            Center(
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: Colors.white,
                    width: 3,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      icon,
                      size: 40,
                      color: const Color(0xFF5B8DB8),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Color(0xFF5B8DB8),
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        height: 1.1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Hexagonal border effect
            // CustomPaint(
            //   painter: HexagonBorderPainter(
            //     color: Colors.red,
            //     strokeWidth: 4,
            //   ),
            //   size: const Size(150, 150),
            // ),
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
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final path = Path();
    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final radius = size.width * 0.35;

    // Create hexagon path
    for (int i = 0; i < 6; i++) {
      final angle = (i * 60) * (3.14159 / 180);
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

