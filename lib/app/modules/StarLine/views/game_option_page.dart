// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:gold/app/core/models/user_model.dart';
// import 'package:gold/app/data/constant/assets_constant.dart';
// import 'package:gold/app/modules/StarLine/models/star_line_game_model.dart';
// import 'package:gold/app/modules/StarLine/views/create_bet_widget.dart';
// import 'package:gold/app/routes/app_pages.dart';

// class StarLineGameOptionPage extends StatelessWidget {
//   final StarLineGameModel game;
//   final UserModel user;
//   const StarLineGameOptionPage({super.key, required this.game, required this.user});

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.sizeOf(context);
//     return PopScope(
//       canPop: false,
//       onPopInvoked: (didPop) {
//         Get.offAllNamed(Routes.HOME);
//       },
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text(
//             game.gameName ?? "",
//             style: const TextStyle(fontWeight: FontWeight.w600),
//           ),
//           centerTitle: true,
//           leading: IconButton(
//               onPressed: () {
//                 Get.offAllNamed(Routes.HOME);
//               },
//               icon: const Icon(Icons.arrow_back)),
//         ),
//         body: Padding(
//           padding: const EdgeInsets.only(top: 15),
//           child: SizedBox(
//             height: size.height * 0.88,
//             child: SingleChildScrollView(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       MaterialButton(
//                         onPressed: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => StarLineCreateBetWidget(
//                                   user: user,
//                                   game: game,
//                                   gameType: "Single Digit"),
//                             ),
//                           );
//                         },
//                         child: Image.asset(
//                           AssetsConstant.singleDigit,
//                           width: size.width * 0.40,
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 10),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       MaterialButton(
//                         onPressed: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => StarLineCreateBetWidget(
//                                   user: user,
//                                   game: game,
//                                   gameType: "Single Pana"),
//                             ),
//                           );
//                         },
//                         child: Image.asset(
//                           AssetsConstant.singlePana,
//                           width: size.width * 0.4,
//                         ),
//                       ),
//                       MaterialButton(
//                         onPressed: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => StarLineCreateBetWidget(
//                                   user: user,
//                                   game: game,
//                                   gameType: "Double Pana"),
//                             ),
//                           );
//                         },
//                         child: Image.asset(
//                           AssetsConstant.doublePana,
//                           width: size.width * 0.4,
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 20),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       MaterialButton(
//                         onPressed: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => StarLineCreateBetWidget(
//                                   user: user,
//                                   game: game,
//                                   gameType: "Triple Pana"),
//                             ),
//                           );
//                         },
//                         child: Image.asset(
//                           AssetsConstant.triplePana,
//                           width: size.width * 0.4,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold/app/core/models/user_model.dart';
import 'package:gold/app/core/widgets/widgets.dart';
import 'package:gold/app/data/constant/assets_constant.dart';
import 'package:gold/app/data/constant/color_constant.dart';
import 'package:gold/app/modules/StarLine/models/star_line_game_model.dart';
import 'package:gold/app/modules/StarLine/views/create_bet_widget.dart';
import 'package:gold/app/modules/home/models/game_model.dart';
import 'package:gold/app/modules/home/views/create_bet_widget.dart';
import 'package:gold/app/routes/app_pages.dart';

class StarLineGameOptionPage extends StatelessWidget {
  final StarLineGameModel game;
  final UserModel user;
  const StarLineGameOptionPage({super.key, required this.game, required this.user});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, data) {
        Get.offAllNamed(Routes.STAR_LINE);
      },
      child: Scaffold(
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
                Container(
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
                          onPressed: () {
                            Get.offAllNamed(Routes.HOME);
                          },
                          icon: const Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: Colors.white,
                            size: 20,
                          ),
                          tooltip: "Back to Home",
                        ),
                      ),
                      
                      // Title with Game Name
                      Column(
                        children: [
                          // Gold Kalyan Logo Text
                          Row(
                            children: [
                              Text(
                                "G",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: ColorConstant.goldColor,
                                ),
                              ),
                              Text(
                                "K",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: ColorConstant.redColor,
                                ),
                              ),
                            ],
                          ),
                          
                          // Game Name
                          Text(
                            game.gameName ?? "",
                            style: TextStyle(
                              color: ColorConstant.textSecondary,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      
                      // Wallet Balance
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                            Image.asset(
                              AssetsConstant.wallet,
                              height: 18,
                              width: 18,
                              // color: Colors.white,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              "${user.wallet?.toInt() ?? 0}",
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
                ),
                
                // Page Title
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Text(
                    "SELECT GAME TYPE",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: ColorConstant.goldColor,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
                
                // Game Options
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: ColorConstant.goldColor.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                      child: Column(
                        children: [
                          // Row 1: Single Digit & Jodi Digit
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _buildGameOption(
                                context: context,
                                imagePath: AssetsConstant.singleDigit,
                                title: "Single Digit",
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => StarLineCreateBetWidget(
                                        user: user,
                                        game: game,
                                        gameType: "Single Digit",
                                      ),
                                    ),
                                  );
                                },
                                isEnabled: true,
                              ),
                               _buildGameOption(
                                context: context,
                                imagePath: AssetsConstant.singlePana,
                                title: "Single Pana",
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => StarLineCreateBetWidget(
                                        user: user,
                                        game: game,
                                        gameType: "Single Pana",
                                      ),
                                    ),
                                  );
                                },
                                isEnabled: true,
                              ),
                            ],
                          ),
                          
                          const SizedBox(height: 20),
                          
                          // Row 2: Single Pana & Double Pana
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                             
                              _buildGameOption(
                                context: context,
                                imagePath: AssetsConstant.doublePana,
                                title: "Double Pana",
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => StarLineCreateBetWidget(
                                        user: user,
                                        game: game,
                                        gameType: "Double Pana",
                                      ),
                                    ),
                                  );
                                },
                                isEnabled: true,
                              ),
                               _buildGameOption(
                                context: context,
                                imagePath: AssetsConstant.triplePana,
                                title: "Triple Pana",
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => StarLineCreateBetWidget(
                                        user: user,
                                        game: game,
                                        gameType: "Triple Pana",
                                      ),
                                    ),
                                  );
                                },
                                isEnabled: true,
                              ),
                            ],
                          ),
                          
                          const SizedBox(height: 20),
                          
                        
                       
                          // Row 4: Full Sangam (centered)
                          
                        ],
                      ),
                    ),
                  ),
                ),
                
                // Game Info Footer
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.all(15),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: ColorConstant.goldColor.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildInfoItem(
                            label: "OPEN",
                            value: game.getOpeningTimeToday() ?? "N/A",
                          ),
                          
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        game.todayResultDeclared!
                            ? "Today's Result: ${(game.todayResult?.openPana != null && game.todayResult?.openPana != '') ? game.todayResult?.openPana : '***'}-${game.todayResult?.calculateSingleAnk() ?? '*'}"
                            : "Today's Result: Pending",
                        style: TextStyle(
                          color: ColorConstant.goldColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  // Helper method to build game option buttons
  Widget _buildGameOption({
    required BuildContext context,
    required String imagePath,
    required String title,
    required VoidCallback onTap,
    required bool isEnabled,
  }) {
    final size = MediaQuery.sizeOf(context);
    final width = (size.width - 100) / 2; // Account for margins and padding
    
    return GestureDetector(
      onTap: isEnabled ? onTap : () {
        CustomWidget.showSnackBar(
          "Game is closed for this type",
          bgColor: Colors.white,
          fgColor: Colors.black,
        );
      },
      child: Container(
        width: width,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isEnabled ? Colors.black.withOpacity(0.4) : Colors.grey.withOpacity(0.3),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: isEnabled ? ColorConstant.goldColor.withOpacity(0.5) : Colors.grey.withOpacity(0.5),
            width: 1.5,
          ),
          boxShadow: isEnabled ? [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ] : null,
        ),
        child: Column(
          children: [
            // Game Image
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                imagePath,
                width: width - 20,
                height: width - 20,
                fit: BoxFit.contain,
              ),
            ),
            
            const SizedBox(height: 10),
            
            // Game Title
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                gradient: isEnabled
                    ? LinearGradient(
                        colors: ColorConstant.goldGradient,
                      )
                    : LinearGradient(
                        colors: [Colors.grey.shade600, Colors.grey.shade700],
                      ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            
            // Game Status Indicator (if needed)
            if (!isEnabled)
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.lock,
                      color: Colors.red.shade300,
                      size: 14,
                    ),
                    const SizedBox(width: 3),
                    Text(
                      "CLOSED",
                      style: TextStyle(
                        color: Colors.red.shade300,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
  
  // Helper method for info items in the footer
  Widget _buildInfoItem({required String label, required String value}) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            color: ColorConstant.goldColor,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}