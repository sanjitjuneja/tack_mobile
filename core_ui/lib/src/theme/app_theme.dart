import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  static Color get transparentColor => AppColors.transparent;
  static Color get primaryColor => AppColors.white;
  /// System colors
  static Color get successColor => AppColors.fern;
  static Color get errorColor => AppColors.harleyDavidsonOrange;

  static Color get dividerColor => AppColors.solitude;
  static Color get drawerAccessoryColor => AppColors.athensGrey;
  static Color get barrierColor => AppColors.blackPearl31;

  ///
  static const positiveColor = AppColors.white;
  static const accentColor = AppColors.black;

  static const grassColor = AppColors.fern;
  static const backgroundColor = AppColors.gin;
  static const hintColor = AppColors.shuttleGray;

  static const secondaryTextColor = AppColors.comet;
  static const shadowColor = AppColors.nevada;
  static const descriptionTextColor = AppColors.midGrey;
  static const buttonTextSecondaryColor = AppColors.waterloo;
  static const lightButtonBorder = AppColors.gallery;

  /// Text
  static Color get textPrimaryColor => AppColors.black;

  static Color get selectedListItemColor => AppColors.fern;
  static Color get unselectedListItemColor => AppColors.blackRussian;

  /// Button
  // Primary
  static Color get buttonPrimaryColor => AppColors.fern;
  static Color get buttonBorderPrimaryColor => AppColors.white;
  static Color get buttonInterfacePrimaryColor => AppColors.white;
  // Secondary
  static Color get buttonSecondaryColor => AppColors.transparent;
  static Color get buttonBorderSecondaryColor => AppColors.fern;
  static Color get buttonInterfaceSecondaryColor => AppColors.fern;
}
