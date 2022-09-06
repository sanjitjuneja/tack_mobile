library app_theme;

import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

part 'app_colors.dart';
part 'app_icon.dart';
part 'app_icons_theme.dart';
part 'app_image_theme.dart';
part 'app_text_theme.dart';

class AppTheme {
  /// Common
  static Color get grassColor => AppColors.fern;
  static Color get accentColor => AppColors.black;
  static Color get primaryColor => AppColors.white;
  static Color get transparentColor => AppColors.transparent;

  /// Page Indicator
  static Color get pageIndicatorActiveColor => AppColors.fern;
  static Color get pageIndicatorInactiveColor => AppColors.athensGrey;

  /// Background
  static Color get backgroundColor => AppColors.gin;
  static Color get secondaryBackgroundColor => AppColors.white;
  static Color get primaryBackgroundColor => AppColors.tranquil;
  static Color get textFieldBackgroundColor => AppColors.athensGray;
  static Color get ratingBackgroundColor => AppColors.nero;

  /// System colors
  static Color get successColor => AppColors.fern;
  static Color get errorColor => AppColors.harleyDavidsonOrange;
  static Color get warningColor => AppColors.gamboge;

  static Color get dividerColor => AppColors.solitude;
  static Color get dividerSecondaryColor => AppColors.osloGray;
  static Color get drawerAccessoryColor => AppColors.athensGrey;
  static Color get barrierColor => AppColors.blackPearl31;
  static Color get shadowColor => AppColors.black25;
  static Color get lightShadowColor => AppColors.black09;

  /// Top Navigation Bar
  static Color get topNavBarInterfaceColor => AppColors.black;

  /// Navigation Bar
  static Color get navBarBackgroundColor => AppColors.white;
  static Color get navBarActiveIconColor => AppColors.fern;
  static Color get navBarInactiveIconColor => AppColors.aluminium;

  /// Progress Dialog
  static Color get progressBarrierColor => AppColors.midnightExpress68;
  static Color get progressInterfaceLightColor => AppColors.white;
  static Color get progressInterfaceDarkColor => AppColors.athensGrey;

  /// Segment Controller
  static Color get segmentBackgroundColor => AppColors.white;
  static Color get segmentActiveBackgroundColor => AppColors.fern;
  static Color get segmentBorderColor => AppColors.fern;
  static Color get segmentActiveTabTextColor => AppColors.white;
  static Color get segmentInactiveTabTextColor => AppColors.fern;

  /// Text Field
  static Color get textFieldDividerColor => AppColors.osloGray;
  static Color get textFieldPrimaryBackgroundColor => AppColors.white;
  static Color get textFieldSecondaryBackgroundColor => AppColors.solitude;

  /// Text
  static Color get textPrimaryColor => AppColors.black;
  static Color get textSecondaryColor => AppColors.fern;
  static Color get textBrightColor => AppColors.white;
  static Color get textHintColor => AppColors.waterloo;
  static Color get textHeavyHintColor => AppColors.shuttleGray;
  static Color get textDescriptionColor => AppColors.midGrey;
  static Color get textDisabledColor => AppColors.athensGrey;

  static Color get selectedListItemColor => AppColors.fern;
  static Color get unselectedListItemColor => AppColors.blackRussian;

  /// Button
  static Color get buttonDisabledColor => AppColors.athensGrey;
  static Color get buttonLightBorderColor => AppColors.gallery;
  // Primary
  static Color get buttonPrimaryColor => AppColors.fern;
  static Color get buttonBorderPrimaryColor => AppColors.white;
  static Color get buttonInterfacePrimaryColor => AppColors.white;
  // Secondary
  static Color get buttonSecondaryColor => AppColors.transparent;
  static Color get buttonBorderSecondaryColor => AppColors.fern;
  static Color get buttonInterfaceSecondaryColor => AppColors.fern;

  /// Icons
  static Color get bottomSheetLift => AppColors.ghost;
  static Color get errorIconColor => AppColors.cinnabar;
  static Color get iconPrimaryColor => AppColors.midGrey;
  static Color get iconSecondaryColor => AppColors.fern;
  static Color get iconHintColor => AppColors.shuttleGray;

  /// Toast
  static Color get toastBackgroundColor => AppColors.aluminium;

  /// Rating
  static Color get ratingFilledColor => AppColors.gamboge;
  static Color get ratingEmptyColor => AppColors.brightGrey;
}
