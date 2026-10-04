import 'package:flutter/material.dart';

/// Design System Color Palette based on the project moodboard:
/// - Deep Blush: #530F0E
/// - Cashmere: #F3A0AA
/// - Rich Wood: #30150E
/// - Silk Beach: #F8E5D7
/// - Black: #000000
/// - Brown: #6B4E3A
class AppColors {
  AppColors._();

  // Core Brand Palette
  static const Color deepBlush = Color(0xFF530F0E);
  static const Color cashmere = Color(0xFFF3A0AA);
  static const Color richWood = Color(0xFF30150E);
  static const Color silkBeach = Color(0xFFF8E5D7);
  static const Color black = Color(0xFF000000);
  static const Color brown = Color(0xFF6B4E3A);

  // Backgrounds & Surfaces
  static const Color background = Color(0xFFFBF8F5);
  static const Color backgroundWarm = Color(0xFFF7EFE9);
  static const Color surface = Colors.white;
  static const Color surfaceSecondary = Color(0xFFF8F1EB);

  // Text Colors
  static const Color textPrimary = Color(0xFF30150E);
  static const Color textSecondary = Color(0xFF6B4E3A);
  static const Color textMuted = Color(0xFF9E8A81);

  // Borders & Dividers
  static const Color border = Color(0xFFEEDCD0);
  static const Color divider = Color(0xFFF2E7DF);

  // Component Specific
  static const Color navBarBackground = Colors.white;
  static const Color activeTabBackground = Color(0xFFF5DEE3); // soft cashmere highlight
  static const Color activeTabIcon = Color(0xFF530F0E);
  static const Color inactiveTabIcon = Color(0xFF8A7770);

  // Shadows
  static const Color shadow = Color(0x1430150E);
}
