import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,

    // 🎯 COLOR SCHEME
    colorScheme: const ColorScheme.light(
      primary: AppColors.primary,
      onPrimary: AppColors.textInverse,
      primaryContainer: AppColors.primaryLight,
      secondary: AppColors.secondary,
      onSecondary: AppColors.textInverse,
      surface: AppColors.surface,
      onSurface: AppColors.textPrimary,
      background: AppColors.background,
      onBackground: AppColors.textPrimary,
      error: AppColors.error,
      onError: AppColors.textInverse,
    ),

    // 🎯 SCAFFOLD & LAYOUT
    scaffoldBackgroundColor: AppColors.background,
    canvasColor: AppColors.surface,

    // 🎯 TYPOGRAPHY
    textTheme: TextTheme(
      // Headlines
      displayLarge: GoogleFonts.poppins(
        fontSize: 32.sp,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
      ),
      displayMedium: GoogleFonts.poppins(
        fontSize: 24.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
      displaySmall: GoogleFonts.poppins(
        fontSize: 20.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),

      // Titles
      titleLarge: GoogleFonts.poppins(
        fontSize: 18.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
      titleMedium: GoogleFonts.poppins(
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.textPrimary,
      ),
      titleSmall: GoogleFonts.poppins(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.textPrimary,
      ),

      // Body
      bodyLarge: GoogleFonts.poppins(
        fontSize: 16.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.textPrimary,
      ),
      bodyMedium: GoogleFonts.poppins(
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.textSecondary,
      ),
      bodySmall: GoogleFonts.poppins(
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.textTertiary,
      ),

      // Labels
      labelLarge: GoogleFonts.poppins(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.textInverse,
      ),
      labelMedium: GoogleFonts.poppins(
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.textSecondary,
      ),
      labelSmall: GoogleFonts.poppins(
        fontSize: 10.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.textTertiary,
      ),
    ),

    // 🎯 BUTTON THEMES
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textInverse,
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 14.h),
        textStyle: GoogleFonts.poppins(
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        elevation: 0,
        shadowColor: Colors.transparent,
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primary,
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 14.h),
        textStyle: GoogleFonts.poppins(
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
        ),
        side: const BorderSide(color: AppColors.primary),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primary,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        textStyle: GoogleFonts.poppins(
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),

    // 🎯 INPUT DECORATION
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.surface,
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: const BorderSide(color: AppColors.border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: const BorderSide(color: AppColors.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: const BorderSide(color: AppColors.primary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: const BorderSide(color: AppColors.error),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: const BorderSide(color: AppColors.error, width: 2),
      ),
      labelStyle: GoogleFonts.poppins(
        color: AppColors.textSecondary,
        fontSize: 14.sp,
      ),
      hintStyle: GoogleFonts.poppins(
        color: AppColors.textTertiary,
        fontSize: 14.sp,
      ),
    ),

    // 🎯 CARD THEME
    cardTheme: CardThemeData(
      color: AppColors.surface,
      elevation: 2,
      shadowColor: AppColors.shadow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      margin: EdgeInsets.zero,
    ),

    // 🎯 APP BAR THEME
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.surface,
      foregroundColor: AppColors.textPrimary,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: GoogleFonts.poppins(
        fontSize: 18.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
    ),

    // 🎯 BOTTOM NAVIGATION BAR THEME
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.surface,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.textTertiary,
      elevation: 8,
    ),

    // 🎯 DIVIDER THEME
    dividerTheme: const DividerThemeData(
      color: AppColors.divider,
      thickness: 1,
      space: 0,
    ),
  );
}
