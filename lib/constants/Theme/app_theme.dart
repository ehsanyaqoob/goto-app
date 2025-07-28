import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  // Font sizes
  static const double _fontSizeExtraSmall = 12.0;
  static const double _fontSizeSmall = 14.0;
  static const double _fontSizeMedium = 16.0;
  static const double _fontSizeLarge = 20.0;
  static const double _fontSizeExtraLarge = 24.0;

  // Text styles
  static TextStyle extraSmallTextStyle =  TextStyle(
    fontSize: _fontSizeExtraSmall,
    fontWeight: FontWeight.normal,
    color: AppColors.textGrey,
  );

  static TextStyle smallTextStyle =  TextStyle(
    fontSize: _fontSizeSmall,
    fontWeight: FontWeight.normal,
    color: AppColors.appBlack,
  );

  static TextStyle mediumTextStyle =  TextStyle(
    fontSize: _fontSizeMedium,
    fontWeight: FontWeight.w500,
    color: AppColors.appBlack,
  );

  static TextStyle largeTextStyle = TextStyle(
    fontSize: _fontSizeLarge,
    fontWeight: FontWeight.w600,
    color: AppColors.appBlack,
  );

  static TextStyle extraLargeTextStyle =  TextStyle(
    fontSize: _fontSizeExtraLarge,
    fontWeight: FontWeight.bold,
    color: AppColors.appBlack,
  );

  // Theme data
  static ThemeData lightTheme = ThemeData(
    primaryColor: AppColors.primary,
    colorScheme: ColorScheme.light(
      primary: AppColors.primary,
      secondary: AppColors.appSecondary,
      surface: AppColors.appWhite,
      background: AppColors.lightGrey,
    ),
    scaffoldBackgroundColor: AppColors.lightGrey,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.appWhite,
      elevation: 0,
      titleTextStyle: largeTextStyle.copyWith(color: AppColors.appBlack),
      iconTheme:  IconThemeData(color: AppColors.appBlack),
    ),
    textTheme: TextTheme(
      displayLarge: extraLargeTextStyle,
      displayMedium: largeTextStyle,
      displaySmall: mediumTextStyle,
      bodyLarge: mediumTextStyle,
      bodyMedium: smallTextStyle,
      bodySmall: extraSmallTextStyle,
      labelLarge: mediumTextStyle.copyWith(color: AppColors.appWhite),
      labelMedium: smallTextStyle.copyWith(color: AppColors.textGrey),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    primaryColor: AppColors.appSecondary,
    colorScheme: ColorScheme.dark(
      primary: AppColors.appSecondary,
      secondary: AppColors.primary,
      surface: const Color(0xFF121212),
      background: const Color(0xFF121212),
    ),
    scaffoldBackgroundColor: const Color(0xFF121212),
    appBarTheme: AppBarTheme(
      backgroundColor: const Color(0xFF1E1E1E),
      elevation: 0,
      titleTextStyle: largeTextStyle.copyWith(color: AppColors.appWhite),
      iconTheme:  IconThemeData(color: AppColors.appWhite),
    ),
    textTheme: TextTheme(
      displayLarge: extraLargeTextStyle.copyWith(color: AppColors.appWhite),
      displayMedium: largeTextStyle.copyWith(color: AppColors.appWhite),
      displaySmall: mediumTextStyle.copyWith(color: AppColors.appWhite),
      bodyLarge: mediumTextStyle.copyWith(color: AppColors.appWhite),
      bodyMedium: smallTextStyle.copyWith(color: AppColors.appWhite),
      bodySmall: extraSmallTextStyle.copyWith(color: AppColors.darkGrey),
      labelLarge: mediumTextStyle.copyWith(color: AppColors.appWhite),
      labelMedium: smallTextStyle.copyWith(color: AppColors.darkGrey),
    ),
  );
}