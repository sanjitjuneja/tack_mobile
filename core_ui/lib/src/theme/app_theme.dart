library app_theme;

import 'package:flutter/cupertino.dart';

part 'app_colors.dart';
part 'app_icon.dart';
part 'app_icons_theme.dart';
part 'app_image_theme.dart';
part 'app_text_theme.dart';

class AppTheme {
  static Color get transparentColor => AppColors.transparent;
  static Color get primaryColor => AppColors.white;

  static Color get primaryBackgroundColor => AppColors.tranquil;
  static Color get secondaryBackgroundColor => AppColors.white;

  /// System colors
  static Color get successColor => AppColors.fern;
  static Color get errorColor => AppColors.harleyDavidsonOrange;

  static Color get dividerColor => AppColors.solitude;
  static Color get drawerAccessoryColor => AppColors.athensGrey;
  static Color get barrierColor => AppColors.blackPearl31;
  static const Color shadowColor = AppColors.black25;

  /// Top Navigation Bar
  static Color get topNavBarInterfaceColor => AppColors.black;
  ///

  /// Navigation Bar
  static Color get navBarBackgroundColor => AppColors.white;
  static Color get navBarInactiveIconColor => AppColors.aluminium;
  static Color get navBarActiveIconColor => AppColors.fern;
  ///

  /// Progress Dialog
  static Color get progressBarrierColor => AppColors.midnightExpress68;
  static Color get progressInterfaceColor => AppColors.white;
  ///

  /// Segment Controller
  static Color get segmentBackgroundColor => AppColors.white;
  static Color get segmentActiveBackgroundColor => AppColors.fern;
  static Color get segmentBorderColor => AppColors.fern;
  static Color get segmentActiveTabTextColor => AppColors.white;
  static Color get segmentInactiveTabTextColor => AppColors.fern;
  ///

  /// Text Field
  static Color get textFieldPrimaryBackgroundColor => AppColors.white;
  static Color get textFieldSecondaryBackgroundColor => AppColors.solitude;
  ///

  static const positiveColor = AppColors.white;
  static const accentColor = AppColors.black;

  static const grassColor = AppColors.fern;
  static const backgroundColor = AppColors.gin;
  static const hintColor = AppColors.shuttleGray;

  static const secondaryTextColor = AppColors.comet;
  static const descriptionTextColor = AppColors.midGrey;
  static const buttonTextSecondaryColor = AppColors.waterloo;
  static const lightButtonBorder = AppColors.gallery;

  /// Text
  static Color get textPrimaryColor => AppColors.black;
  static Color get textSecondaryColor => AppColors.fern;
  static Color get textHintColor => AppColors.waterloo;
  static Color get textHeavyHintColor => AppColors.shuttleGray;

  static Color get selectedListItemColor => AppColors.fern;
  static Color get unselectedListItemColor => AppColors.blackRussian;

  /// Button
  static Color get buttonDisabledColor => AppColors.athensGrey;
  // Primary
  static Color get buttonPrimaryColor => AppColors.fern;
  static Color get buttonBorderPrimaryColor => AppColors.white;
  static Color get buttonInterfacePrimaryColor => AppColors.white;
  // Secondary
  static Color get buttonSecondaryColor => AppColors.transparent;
  static Color get buttonBorderSecondaryColor => AppColors.fern;
  static Color get buttonInterfaceSecondaryColor => AppColors.fern;

  /// Icons
  static Color get iconPrimaryColor => AppColors.midGrey;
  static Color get iconHintColor => AppColors.shuttleGray;
}
