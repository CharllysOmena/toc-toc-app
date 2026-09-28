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
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.chipOff,
        selectedColor: AppColors.confirmBg,
        checkmarkColor: AppColors.confirm,
        side: const BorderSide(color: AppColors.line),
        labelStyle: const TextStyle(color: AppColors.inkSoft, fontWeight: FontWeight.w500),
        secondaryLabelStyle: const TextStyle(color: AppColors.deep, fontWeight: FontWeight.w600),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        showCheckmark: false,
      ),
      dividerTheme: const DividerThemeData(color: AppColors.line, thickness: 1, space: 0),
      listTileTheme: const ListTileThemeData(
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        minLeadingWidth: 44,
        horizontalTitleGap: 12,
      ),
    );
  }
}
