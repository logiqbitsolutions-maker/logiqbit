import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../values/app_colors.dart';

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: AppColors.primaryOrange,
      scaffoldBackgroundColor: AppColors.backgroundBlack,
      textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme).apply(
        bodyColor: AppColors.textWhite,
        displayColor: AppColors.textWhite,
      ),
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primaryOrange,
        secondary: AppColors.accentOrange,
        surface: AppColors.cardBlack,
        onPrimary: AppColors.textWhite,
        onSurface: AppColors.textWhite,
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.dividerGrey,
        thickness: 1,
      ),
    );
  }
}
