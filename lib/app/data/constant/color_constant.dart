import 'package:flutter/material.dart';

class ColorConstant {
  // Primary Colors
  static Color primaryColor = const Color.fromARGB(255, 23, 6, 55); // Dark purple background
  static Color goldColor = const Color(0xFFD4AF37); // Gold for "G" and text
  static Color redColor = const Color(0xFFE63E31); // Red for "K"
  
  // Background Colors
  static Color darkBackground = const Color(0xFF0A0A0A); // Black background
  static Color lightBackground = const Color(0xFFF8F8F8); // Light background for content areas
  
  // Text Colors
  static Color textPrimary = const Color(0xFFD4AF37); // Gold text
  static Color textSecondary = const Color(0xFFFFFFFF); // White text
  static Color textDark = const Color(0xFF333333); // Dark text
  
  // Accent Colors
  static Color accentColor = const Color(0xFFBA8B02); // Darker gold for accents
  static Color successColor = const Color(0xFF4CAF50); // Green for success messages
  static Color errorColor = const Color(0xFFF44336); // Red for error messages
  
  // Gradient Colors
  static List<Color> goldGradient = [
    const Color(0xFFD4AF37),
    const Color(0xFFBA8B02),
  ];
}