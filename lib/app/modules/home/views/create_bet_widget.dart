// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold/app/core/models/user_model.dart';
import 'package:gold/app/data/constant/assets_constant.dart';
import 'package:gold/app/data/constant/color_constant.dart';
import 'package:gold/app/modules/home/models/game_model.dart';
import 'package:gold/app/modules/home/widgets/jodi_digit.dart';
import 'package:gold/app/modules/home/widgets/motors_widget.dart';
import 'package:gold/app/modules/home/widgets/sangam_widget.dart';
import 'package:gold/app/modules/home/widgets/single_digit_and_pana.dart';
import 'package:gold/app/routes/app_pages.dart';

/// Constants defining the different types of single digit and pana betting options
/// These are used to determine which betting interface to display
const singleDigitAndPanaArray = [
  "Single Digit",  // Single number betting (0-9)
  "Single Pana",   // Single pana betting format
  "Double Pana",   // Double pana betting format
  "Triple Pana",   // Triple pana betting format
];

/// Constants defining motor betting types
/// Motor betting is a specific type of gambling format
const motorsArray = [
  "SP Motor",  // Single Pana Motor betting
  "DP Motor"   // Double Pana Motor betting
];

/// A widget that creates and displays different betting interfaces based on game type
/// 
/// This is the main betting creation screen that dynamically renders different
/// betting forms depending on the type of game selected by the user.
/// 
/// Supported betting types:
/// - Single Digit & Pana betting (Single Digit, Single Pana, Double Pana, Triple Pana)
/// - Jodi Digit betting (pair number betting)
/// - Sangam betting (combination betting)
/// - Motor betting (SP Motor, DP Motor)
class CreateBetWidget extends StatefulWidget {
  /// The game model containing game details like name, timing, rates etc.
  final GameModel game;
  
  /// The type of betting game (e.g., "Single Digit", "Jodi Digit", "Sangam", etc.)
  final String gameType;
  
  /// The current user's information for validation and bet placement
  final UserModel user;

  /// Creates a new CreateBetWidget
  /// 
  /// All parameters are required:
  /// - [game]: Contains the game information
  /// - [gameType]: Determines which betting interface to show
  /// - [user]: Current user's data for betting operations
  const CreateBetWidget({
    super.key,
    required this.game,
    required this.gameType,
    required this.user,
  });

  @override
  State<CreateBetWidget> createState() => _CreateBetWidgetState();
}

class _CreateBetWidgetState extends State<CreateBetWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Custom app bar with game information
      appBar: _buildAppBar(),
      
      // Scrollable body containing the betting interface
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: _renderBettingWidget(),
        ),
      ),
    );
  }

  /// Builds the custom app bar with game name and type information
  /// 
  /// Features:
  /// - Purple gradient background
  /// - Back navigation to home screen
  /// - Game name and type in uppercase
  /// - White text and icons
  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.primary, // Purple theme color
      elevation: 0, // Flat design
      
      // Custom back button that navigates to home screen
      leading: IconButton(
        onPressed: () {
          // Using GetX navigation to clear all routes and go to home
          // Get.offAllNamed(Routes.HOME);
          Get.back();
        },
        icon: const Icon(
          Icons.arrow_back, 
          color: Colors.white, 
          size: 24
        ),
      ),
      
      // Display game name and type in uppercase
      title: Text(
        "${widget.game.gameName?.toUpperCase()} , ${widget.gameType.toUpperCase()}",
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      centerTitle: false, // Left-aligned title
    );
  }

  /// Renders the appropriate betting widget based on game type
  /// 
  /// This method implements a conditional rendering system that shows different
  /// betting interfaces based on the game type. It uses nested Visibility widgets
  /// to efficiently manage widget rendering.
  /// 
  /// Logic flow:
  /// 1. Check if it's a single digit/pana game type
  /// 2. Check if it's a jodi digit game type
  /// 3. Check if it's a sangam game type
  /// 4. Check if it's a motor game type
  /// 5. Show error if no valid type is found
  /// 
  /// Returns: Widget - The appropriate betting interface
  Widget _renderBettingWidget() {
    // Debug log to track game type selection
    log('Selected game type: ${widget.gameType}');
    
    // Determine which betting interface to show based on game type
    bool isSingleDigitOrPana = singleDigitAndPanaArray.contains(widget.gameType);
    bool isMotorBetting = motorsArray.contains(widget.gameType);
    bool isJodiDigit = (widget.gameType == 'Jodi Digit');
    bool isSangamBetting = widget.gameType.contains("Sangam");

    return Container(
      // Styled container with border and background
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05), // Semi-transparent white background
        borderRadius: BorderRadius.circular(15), // Rounded corners
        border: Border.all(
          color: AppColors.secondary.withOpacity(0.2), // Gold border
          width: 1,
        ),
      ),
      
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            // Nested visibility widgets for conditional rendering
            // This creates a fallback chain: SingleDigit -> JodiDigit -> Sangam -> Motors -> Error
            
            Visibility(
              visible: isSingleDigitOrPana,
              replacement: Visibility(
                visible: isJodiDigit,
                replacement: Visibility(
                  visible: isSangamBetting,
                  replacement: Visibility(
                    visible: isMotorBetting,
                    
                    // Error state when no valid game type is found
                    replacement: _buildErrorState(),
                    
                    // Motor betting interface
                    child: Motors(
                      gameType: widget.gameType,
                      game: widget.game,
                      user: widget.user,
                    ),
                  ),
                  
                  // Sangam betting interface
                  child: SangamWidget(
                    gameType: widget.gameType,
                    game: widget.game,
                    user: widget.user,
                  ),
                ),
                
                // Jodi digit betting interface
                child: JodiDigit(
                  gameType: widget.gameType,
                  game: widget.game,
                  user: widget.user,
                ),
              ),
              
              // Single digit and pana betting interface
              child: SingleDigitAndPana(
                gameType: widget.gameType,
                game: widget.game,
                user: widget.user,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds an error state widget when no valid game type is found
  /// 
  /// This widget displays:
  /// - Error icon in app's error color
  /// - "Something went wrong" message
  /// - Centered layout for better UX
  /// 
  /// Returns: Widget - Error state UI
  Widget _buildErrorState() {
    return Center(
      child: Column(
        children: [
          // Error icon
          Icon(
            Icons.error_outline,
            size: 48,
            color: AppColors.error,
          ),
          
          const SizedBox(height: 15), // Spacing between icon and text
          
          // Error message
          const Text(
            "Something went wrong",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

/*
 * CODE DOCUMENTATION SUMMARY
 * ==========================
 * 
 * This widget serves as a dynamic betting interface controller for a gambling/gaming app.
 * 
 * KEY FEATURES:
 * - Dynamic widget rendering based on game type
 * - Support for multiple betting formats (Single Digit, Pana, Jodi, Sangam, Motors)
 * - Clean error handling for unsupported game types
 * - Responsive UI with consistent theming
 * - Navigation integration with GetX
 * 
 * ARCHITECTURE PATTERN:
 * - Uses Factory pattern through conditional rendering
 * - Separation of concerns with dedicated widgets for each betting type
 * - Stateful widget for potential future state management needs
 * 
 * BETTING TYPES SUPPORTED:
 * 1. Single Digit & Pana: Basic number and pattern betting
 * 2. Jodi Digit: Pair number betting
 * 3. Sangam: Combination betting (any game type containing "Sangam")
 * 4. Motors: SP Motor and DP Motor betting
 * 
 * ERROR HANDLING:
 * - Graceful fallback to error state for unsupported game types
 * - User-friendly error message with visual indicators
 * 
 * NAVIGATION:
 * - Custom back button behavior (clears navigation stack)
 * - Integration with app's routing system
 * 
 * UI/UX CONSIDERATIONS:
 * - Consistent color scheme with purple theme
 * - Semi-transparent overlays for modern look
 * - Proper spacing and typography hierarchy
 * - Responsive design with scrollable content
 */