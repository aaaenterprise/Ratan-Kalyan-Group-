// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold/app/core/app_color.dart';
import 'package:gold/app/core/models/user_model.dart';
import 'package:gold/app/data/constant/assets_constant.dart';
import 'package:gold/app/modules/StarLine/models/star_line_game_model.dart';
import 'package:gold/app/modules/StarLine/views/game_option_page.dart';
import 'package:gold/app/modules/StarLine/views/single_digit_and_pana.dart';
import 'package:intl/intl.dart';
const singleDigitAndPanaArray = [
  "Single Digit",
  "Single Pana",
  "Double Pana",
  "Triple Pana"
];

class StarLineCreateBetWidget extends StatefulWidget {
  final StarLineGameModel game;
  final String gameType;
  final UserModel user;
  const StarLineCreateBetWidget(
      {super.key,
      required this.game,
      required this.gameType,
      required this.user});

  @override
  State<StarLineCreateBetWidget> createState() => _CreateBetWidgetState();
}

class _CreateBetWidgetState extends State<StarLineCreateBetWidget> {
  @override
    Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: AppColors.primaryGradient,
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Custom App Bar
              _buildAppBar(),
              
              // Content
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      children: [
                        // Game Info Card
                        _buildGameInfoCard(),
                        
                        // Betting Form
                        renderWidget(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  // App Bar
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
              onPressed: () {
              Get.offAll(() => StarLineGameOptionPage(
                                    game: widget.game,
                                    user: widget.user,
                                  ));
              },
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: AppColors.textOnPrimary,
                size: 20,
              ),
              tooltip: "Back to Game Options",
            ),
          ),
          
          // Title
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
                      color: AppColors.secondary,
                    ),
                  ),
                  Text(
                    "K",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.error,
                    ),
                  ),
                ],
              ),
              
              // Game Name
              Text(
                widget.game.gameName ?? "",
                style: TextStyle(
                  color: AppColors.textSecondary,
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
              gradient: AppColors.secondaryGradient,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: AppColors.secondary.withOpacity(0.3),
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
                  "${widget.user.wallet?.toInt() ?? 0}",
                  style: const TextStyle(
                    color: AppColors.textOnPrimary,
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
  
  // Game Info Card
  Widget _buildGameInfoCard() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Stack(
          children: [
            // Background with gradient overlay
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.black.withOpacity(0.8),
                    Colors.black.withOpacity(0.9),
                  ],
                ),
              ),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.secondary.withOpacity(0.3),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    // Game Type and Name
                    Text(
                      widget.gameType,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: AppColors.secondary,
                        letterSpacing: 1,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      height: 1,
                      width: 60,
                      decoration: BoxDecoration(
                        gradient: AppColors.secondaryGradient,
                      ),
                    ),
                    Text(
                      widget.game.gameName ?? "",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textOnPrimary,
                        letterSpacing: 0.5,
                      ),
                    ),
                    
                    const SizedBox(height: 15),
                    
                    // Game Info
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                      decoration: BoxDecoration(
                        color: AppColors.cardBackground.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: AppColors.secondary.withOpacity(0.2),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.calendar_today_rounded,
                            size: 16,
                            color: AppColors.secondary,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            DateFormat('dd MMM yyyy').format(DateTime.now()),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textOnPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 12),
                    
                    // Game Times
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildTimeInfo(
                          label: "OPEN",
                          time: widget.game.getOpeningTimeToday() ?? "N/A",
                          isOpen: true,
                        ),
                      
                      ],
                    ),
                  ],
                ),
              ),
            ),
            
            // Golden Corner Accents
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  gradient: AppColors.secondaryGradient,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  gradient: AppColors.secondaryGradient,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(20),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  // Helper method for time information
  Widget _buildTimeInfo({
    required String label,
    required String time,
    required bool isOpen,
  }) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: (isOpen ? AppColors.success : AppColors.info).withOpacity(0.2),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: (isOpen ? AppColors.success : AppColors.info).withOpacity(0.3),
              width: 1,
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: isOpen ? AppColors.success : AppColors.info,
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          time,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.textOnPrimary,
          ),
        ),
      ],
    );
  }

  // Render appropriate betting widget based on game type
 renderWidget() {

    bool singleDigitAndPanaCondition =
        singleDigitAndPanaArray.contains(widget.gameType);
   
    return Visibility(


      visible: singleDigitAndPanaCondition,
      child: StarLineSingleDigitAndPana(
          gameType: widget.gameType, game: widget.game, user: widget.user),
    );
  }
}


  