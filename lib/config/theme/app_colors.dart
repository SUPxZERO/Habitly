import 'package:flutter/material.dart';

/// Habitly Color Palette - Minimalist, Pastel, Modern Design
class AppColors {
  // Primary & Brand
  static const Color primary = Color(0xFF5C6BC0); // Indigo/Purple
  static const Color primaryLight = Color(0xFFEAE7F5); // Light purple background
  static const Color primaryDark = Color(0xFF3F4B8F); // Darker purple

  // Secondary & Action
  static const Color secondary = Color(0xFF2ECC71); // Emerald Green
  static const Color secondaryLight = Color(0xFFD5F4E6); // Light green (pastel)
  static const Color secondaryDark = Color(0xFF27AE60); // Darker green

  // Text
  static const Color textDark = Color(0xFF2D3436); // Dark slate
  static const Color textMedium = Color(0xFF636E72); // Medium grey
  static const Color textLight = Color(0xFF95A5A6); // Light grey

  // Background
  static const Color bgWhite = Color(0xFFFFFFFF); // Pure white
  static const Color bgLight = Color(0xFFF5F7FA); // Light grey background

  // Status Colors
  static const Color success = Color(0xFF2ECC71); // Green (Complete)
  static const Color warning = Color(0xFFF39C12); // Orange (Partial)
  static const Color error = Color(0xFFE74C3C); // Red (Missed)
  static const Color info = Color(0xFF3498DB); // Blue (Info)

  // Accent Pastel Colors (for icon backgrounds)
  static const Color accentPurple = Color(0xFFE8E5F5); // Light purple
  static const Color accentGreen = Color(0xFFD5F4E6); // Light green
  static const Color accentOrange = Color(0xFFFDEADB); // Light orange
  static const Color accentBlue = Color(0xFFD6EAF8); // Light blue
  static const Color accentPink = Color(0xFFFEDEE8); // Light pink
  static const Color accentYellow = Color(0xFFFEF5E7); // Light yellow

  // Neutral
  static const Color border = Color(0xFFEBEBEB); // Border color
  static const Color divider = Color(0xFFE8E8E8); // Divider color
  static const Color shadow = Color(0x1A000000); // Shadow color (10% black)

  // Gradient Colors
  static const List<Color> gradientPrimary = [
    Color(0xFF5C6BC0),
    Color(0xFF7B68EE),
  ];

  static const List<Color> gradientSuccess = [
    Color(0xFF2ECC71),
    Color(0xFF27AE60),
  ];

  // Transparency helpers
  static Color withOpacity(Color color, double opacity) {
    return color.withOpacity(opacity);
  }
}
