import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utilis/app_colors.dart';

class DarkTheme {
  static final ThemeData theme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.darkPrimary,
    scaffoldBackgroundColor: AppColors.darkBackground,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.darkPrimary,
      secondary: AppColors.secondary,
      surface: AppColors.darkSurface,
      error: AppColors.error,
      onPrimary: AppColors.onDarkPrimary,
      onSecondary: AppColors.onSecondary,
      onSurface: AppColors.onDarkSurface,
      onError: AppColors.onError,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.darkPrimary,
      foregroundColor: AppColors.onDarkPrimary,
      elevation: 0,
      titleTextStyle: GoogleFonts.montserrat(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: AppColors.onDarkPrimary,
      ),
      iconTheme: const IconThemeData(color: AppColors.onDarkPrimary),
    ),
    textTheme: GoogleFonts.montserratTextTheme().apply(
      bodyColor: AppColors.onDarkBackground,
      displayColor: AppColors.onDarkBackground,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.darkPrimary,
        foregroundColor: AppColors.onDarkPrimary,
        textStyle: GoogleFonts.montserrat(fontWeight: FontWeight.w600),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.darkSurface,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
    ),
  );
}
