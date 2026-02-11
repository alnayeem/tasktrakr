import 'package:flutter/material.dart';

/// TaskTrakr app color palette - Blueish tint theme matching Visily designs
class AppColors {
  AppColors._();

  // Primary colors
  static const Color primary = Color(0xFF2196F3);
  static const Color primaryLight = Color(0xFF64B5F6);
  static const Color primaryDark = Color(0xFF1976D2);
  static const Color primarySurface = Color(0xFFE3F2FD); // Light blue tint for cards/sections

  // Status colors
  static const Color success = Color(0xFF4CAF50);
  static const Color successLight = Color(0xFFE8F5E9); // Light mint green for completed items
  static const Color successSurface = Color(0xFFE8F5E9);
  static const Color warning = Color(0xFFFF9800);
  static const Color warningLight = Color(0xFFFFB74D);
  static const Color error = Color(0xFFF44336);

  // Ramadan / Islamic theme
  static const Color ramadan = Color(0xFF1B5E20);
  static const Color ramadanLight = Color(0xFF4CAF50);
  static const Color ramadanGold = Color(0xFFFFD700);

  // Backgrounds - Blueish tint
  static const Color backgroundLight = Color(0xFFF5F9FC); // Subtle blue-gray tint
  static const Color backgroundDark = Color(0xFF121212);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color surfaceDark = Color(0xFF1E1E1E);

  // Card colors
  static const Color cardLight = Color(0xFFFFFFFF);
  static const Color cardDark = Color(0xFF2C2C2C);
  static const Color cardTintBlue = Color(0xFFF0F7FF); // Soft blue tint for task sections
  static const Color cardTintGreen = Color(0xFFE8F5E9); // Soft green for completed tasks

  // Text colors
  static const Color textPrimaryLight = Color(0xFF212121);
  static const Color textSecondaryLight = Color(0xFF757575);
  static const Color textPrimaryDark = Color(0xFFFFFFFF);
  static const Color textSecondaryDark = Color(0xFFB0B0B0);

  // Dividers
  static const Color dividerLight = Color(0xFFE8EEF2); // Blueish divider
  static const Color dividerDark = Color(0xFF424242);

  // Accent colors for UI elements
  static const Color accentCyan = Color(0xFF00BCD4);
  static const Color accentTeal = Color(0xFF26A69A);

  // Category colors
  static const Color categoryFitness = Color(0xFFE91E63);
  static const Color categoryLearning = Color(0xFF9C27B0);
  static const Color categoryCreative = Color(0xFFFF5722);
  static const Color categoryWellness = Color(0xFF00BCD4);
  static const Color categoryFinancial = Color(0xFF8BC34A);
  static const Color categoryRamadan = Color(0xFF1B5E20);
  static const Color categoryOther = Color(0xFF607D8B);

  // Privacy/info card (mint green from Settings screen)
  static const Color privacyCard = Color(0xFFE8F5E9);
}
