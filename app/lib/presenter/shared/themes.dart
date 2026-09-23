import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

abstract class AppThemes {
  static ThemeData get light {
    final inter = GoogleFonts.interTextTheme();
    final fraunces = GoogleFonts.frauncesTextTheme();

    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.bg,
      colorScheme: const ColorScheme.light(
        primary: AppColors.deep,
        secondary: AppColors.confirm,
        surface: AppColors.panel,
        error: AppColors.alert,
        onSurface: AppColors.ink,
        onSecondaryContainer: AppColors.confirm,
      ),
      textTheme: inter.copyWith(
        displayLarge: fraunces.displayLarge?.copyWith(color: AppColors.ink),
        headlineLarge: fraunces.headlineLarge?.copyWith(color: AppColors.ink),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.panel,
        foregroundColor: AppColors.ink,
        elevation: 0,
        centerTitle: true,
        scrolledUnderElevation: 0,
      ),
      cardTheme: const CardThemeData(
        color: AppColors.panel,
        elevation: 0,
      ),
    );
  }
}
