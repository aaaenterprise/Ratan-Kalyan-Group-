import 'package:flutter/material.dart';

class AppColors {
  // ==================== PRIMARY COLORS ====================
  /// Main brand color - Deep Navy Blue
  static const Color primary = Color(0xFF1A2B4A);

  /// Lighter shade of primary for hover/pressed states
  static const Color primaryLight = Color(0xFF2C3E5F);

  /// Darker shade of primary
  static const Color primaryDark = Color(0xFF0F1829);

  // ==================== ACCENT COLORS ====================
  /// Main accent color - Vibrant Teal
  static const Color accent = Color(0xFF00BCD4);

  /// Light accent for backgrounds and highlights
  static const Color accentLight = Color(0xFF4DD0E1);

  /// Dark accent for borders and emphasis
  static const Color accentDark = Color(0xFF0097A7);

  // ==================== SECONDARY COLORS ====================
  /// Secondary color - Warm Gold for important actions
  static const Color secondary = Color(0xFFFFB300);

  /// Light secondary
  static const Color secondaryLight = Color(0xFFFFCA28);

  /// Dark secondary
  static const Color secondaryDark = Color(0xFFFF8F00);

  // ==================== BACKGROUND COLORS ====================
  /// Main background color
  static const Color background = Color(0xFFF5F7FA);

  /// Card background color
  static const Color cardBackground = Color(0xFFFFFFFF);

  /// Surface color for elevated components
  static const Color surface = Color(0xFFFAFBFC);

  /// Subtle background for sections
  static const Color backgroundSubtle = Color(0xFFE8EDF2);

  // ==================== TEXT COLORS ====================
  /// Primary text color
  static const Color textPrimary = Color(0xFF1A2B4A);

  /// Secondary text color for less emphasis
  static const Color textSecondary = Color(0xFF6B7684);

  /// Tertiary text color for hints and labels
  static const Color textTertiary = Color(0xFF9BA3AF);

  /// Text on primary color backgrounds
  static const Color textOnPrimary = Color(0xFFFFFFFF);

  /// Text on accent color backgrounds
  static const Color textOnAccent = Color(0xFFFFFFFF);

  // ==================== STATUS COLORS ====================
  /// Success color - Green
  static const Color success = Color(0xFF10B981);
  static const Color successLight = Color(0xFF34D399);
  static const Color successDark = Color(0xFF059669);

  /// Error/Danger color - Red
  static const Color error = Color(0xFFEF4444);
  static const Color errorLight = Color(0xFFF87171);
  static const Color errorDark = Color(0xFFDC2626);

  /// Warning color - Amber
  static const Color warning = Color(0xFFF59E0B);
  static const Color warningLight = Color(0xFFFBBF24);
  static const Color warningDark = Color(0xFFD97706);

  /// Info color - Blue
  static const Color info = Color(0xFF3B82F6);
  static const Color infoLight = Color(0xFF60A5FA);
  static const Color infoDark = Color(0xFF2563EB);

  // ==================== BORDER COLORS ====================
  /// Default border color
  static const Color border = Color(0xFFE2E8F0);

  /// Focused/Active border color
  static const Color borderActive = Color(0xFF00BCD4);

  /// Subtle border for minimal separation
  static const Color borderSubtle = Color(0xFFF1F5F9);

  // ==================== SPECIAL COLORS ====================
  /// Market open status
  static const Color marketOpen = Color(0xFF10B981);

  /// Market closed status
  static const Color marketClosed = Color(0xFFEF4444);

  /// Wallet/Money indicator
  static const Color wallet = Color(0xFFFFB300);

  /// Chart/Analytics color
  static const Color chart = Color(0xFF6366F1);

  // ==================== GRADIENT COLORS ====================
  /// Primary gradient for buttons and cards
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF1A2B4A), Color(0xFF2C3E5F)],
  );

  /// Accent gradient for highlights
  static const LinearGradient accentGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF00BCD4), Color(0xFF0097A7)],
  );

  /// Secondary gradient for special actions
  static const LinearGradient secondaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFFFB300), Color(0xFFFF8F00)],
  );

  /// Success gradient
  static const LinearGradient successGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF10B981), Color(0xFF059669)],
  );

  /// Game card gradient
  static const LinearGradient gameCardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF00BCD4), Color(0xFF0097A7)],
  );

  // ==================== SHADOW COLORS ====================
  /// Light shadow for cards
  static Color shadowLight = Colors.black.withOpacity(0.05);

  /// Medium shadow for elevated components
  static Color shadowMedium = Colors.black.withOpacity(0.10);

  /// Strong shadow for modals and popups
  static Color shadowStrong = Colors.black.withOpacity(0.15);

  // ==================== OVERLAY COLORS ====================
  /// Semi-transparent overlay
  static Color overlay = Colors.black.withOpacity(0.4);

  /// Light overlay for hover states
  static Color overlayLight = Colors.black.withOpacity(0.05);

  // ==================== HELPER METHODS ====================
  /// Get color with opacity
  static Color withOpacity(Color color, double opacity) {
    return color.withOpacity(opacity);
  }

  /// Get lighter shade of a color
  static Color lighten(Color color, [double amount = 0.1]) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(color);
    final hslLight = hsl.withLightness(
      (hsl.lightness + amount).clamp(0.0, 1.0),
    );
    return hslLight.toColor();
  }

  /// Get darker shade of a color
  static Color darken(Color color, [double amount = 0.1]) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(color);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));
    return hslDark.toColor();
  }
}

// ==================== COLOR EXTENSIONS ====================
extension ColorExtension on Color {
  /// Convert color to MaterialColor
  MaterialColor toMaterialColor() {
    final Map<int, Color> shades = {
      50: AppColors.lighten(this, 0.5),
      100: AppColors.lighten(this, 0.4),
      200: AppColors.lighten(this, 0.3),
      300: AppColors.lighten(this, 0.2),
      400: AppColors.lighten(this, 0.1),
      500: this,
      600: AppColors.darken(this, 0.1),
      700: AppColors.darken(this, 0.2),
      800: AppColors.darken(this, 0.3),
      900: AppColors.darken(this, 0.4),
    };
    return MaterialColor(value, shades);
  }
}
