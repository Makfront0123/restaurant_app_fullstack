import 'package:flutter/material.dart';

import 'package:restaurant_bloc_frontend/core/theme/app_colors.dart';

class AppTheme {
  static ThemeData lightTheme() {
    return ThemeData(
      brightness: Brightness.light,
      primaryColorLight: AppColors.secondaryColor,
      textTheme: const TextTheme(
          headlineSmall: TextStyle(
            color: AppColors.textColorLight,
            fontSize: 20.0,
          ),
          headlineMedium: TextStyle(
            color: AppColors.textColorLight,
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
          headlineLarge: TextStyle(
            color: AppColors.textColorLight,
            fontSize: 28.0,
            fontWeight: FontWeight.bold,
          ),
          bodyLarge: TextStyle(
            color: AppColors.textColorLight,
            fontSize: 16.0,
          ),
          bodyMedium: TextStyle(
            color: AppColors.textColorLight,
            fontSize: 14.0,
          ),
          bodySmall: TextStyle(
            color: AppColors.textColorLight,
            fontSize: 12.0,
          ),
          labelLarge: TextStyle(
            color: AppColors.textTertiary,
            fontSize: 18.0,
            fontWeight: FontWeight.w400,
          ),
          labelMedium: TextStyle(
            color: AppColors.textTertiary,
            fontSize: 16.0,
            fontWeight: FontWeight.w400,
          ),
          labelSmall: TextStyle(
            color: AppColors.secondaryColor,
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
          )),
      scaffoldBackgroundColor: AppColors.backgroundLight,
      primaryColor: AppColors.backgroundSecondary,
    );
  }

  static ThemeData darkTheme() {
    return ThemeData(
      scaffoldBackgroundColor: AppColors.backgroundDark,
      primaryColor: AppColors.backgroundSecondary,
      textTheme: const TextTheme(
          bodyLarge: TextStyle(
            color: AppColors.textColorDark,
            fontSize: 16.0,
          ),
          bodyMedium: TextStyle(
            color: AppColors.textColorDark,
            fontSize: 14.0,
          ),
          bodySmall: TextStyle(
            color: AppColors.textColorDark,
            fontSize: 12.0,
          ),
          labelMedium: TextStyle(
            color: AppColors.textTertiary,
            fontSize: 14.0,
          )),
      brightness: Brightness.dark,
    );
  }
}


/*context.read<ThemeBlocZ().add(ToogleThemeEvent()) */