import 'package:flutter/material.dart';
import 'package:movies/core/theme/app_colors.dart';

class AppTheme {
  static final ThemeData theme = ThemeData(
    scaffoldBackgroundColor: AppColors.backGroundColor,
    canvasColor: AppColors.black,
    primaryColor: AppColors.gold,
    fontFamily: "Cairo",
    

    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      centerTitle: true,
      elevation: 0,
    ),

    hoverColor: AppColors.gold,

    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      selectedItemColor: AppColors.gold,
      unselectedItemColor: AppColors.gray,
      selectedIconTheme: IconThemeData(size: 26),
      unselectedIconTheme: IconThemeData(size: 22),
    ),

    textTheme: const TextTheme(
       bodyMedium: TextStyle(color: AppColors.white),
      displayLarge: TextStyle(
        color: AppColors.white,
        fontWeight: FontWeight.bold,
        fontSize: 24,
      ),
      displayMedium: TextStyle(
        color: AppColors.white,
        fontWeight: FontWeight.bold,
        fontSize: 22,
      ),
      displaySmall: TextStyle(
        color: AppColors.white,
        fontSize: 18,
      ),
      headlineLarge: TextStyle(
        color: AppColors.white,
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
      headlineMedium: TextStyle(
        color: AppColors.white,
        fontWeight: FontWeight.bold,
        fontSize: 22,
      ),
      headlineSmall: TextStyle(
        color: AppColors.white,
        fontSize: 18,
      ),
      labelSmall: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold,
        color: AppColors.white,
      ),
      labelMedium: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: AppColors.white,
      ),
    ),

    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: AppColors.gold,
        foregroundColor: AppColors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        padding: const EdgeInsets.all(8),
        textStyle: const TextStyle(
          fontSize: 20,
          color: AppColors.white,
        ),
      ),
    ),
    

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        textStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        foregroundColor: AppColors.gold,
        side: const BorderSide(color: AppColors.gold),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      prefixIconColor: AppColors.white,
      suffixIconColor: AppColors.white,
      helperStyle: TextStyle(fontSize: 12, color: AppColors.white),
      labelStyle: const TextStyle(fontSize: 14, color: AppColors.white),
      hintStyle: const TextStyle(fontSize: 14, color: AppColors.white),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: AppColors.gray, width: 1),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: AppColors.white, width: 1),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: AppColors.red, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: AppColors.gold, width: 1.5),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: AppColors.red, width: 1),
      ),
      
    ),
  );
}
