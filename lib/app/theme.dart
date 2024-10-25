import 'package:flutter/material.dart';
import 'package:rickandmorty/app/colors.dart';

final appTheme = ThemeData(
  primaryColor: AppColors.primaryColor,
  scaffoldBackgroundColor: AppColors.black900,
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.black600,
  ),
  actionIconTheme: ActionIconThemeData(
    backButtonIconBuilder: (BuildContext context) => const Icon(
      Icons.arrow_back_ios,
      color: AppColors.white,
    ),
  ),
  colorScheme: ColorScheme.fromSeed(
    seedColor: AppColors.primaryColor,
    secondary: AppColors.secondaryColor,
  ),
  cardTheme: const CardTheme(
    color: AppColors.black800,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(
      fontFamily: 'Nunito',
      fontSize: 40,
      fontWeight: FontWeight.w500, // Medium
    ),
    displayMedium: TextStyle(
      fontFamily: 'Nunito',
      fontSize: 32,
      fontWeight: FontWeight.w700, // Bold
    ),
    displaySmall: TextStyle(
      fontFamily: 'Nunito',
      fontSize: 28,
      fontWeight: FontWeight.w600, // SemiBold
      color: AppColors.white,
    ),
    bodyLarge: TextStyle(
      fontFamily: 'Nunito',
      fontSize: 16,
      fontWeight: FontWeight.w400, // Regular
    ),
    bodyMedium: TextStyle(
      fontFamily: 'Nunito',
      fontSize: 14,
      fontWeight: FontWeight.w400, // Regular
    ),
  ),
);
