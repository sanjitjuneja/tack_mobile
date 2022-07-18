library app_theme;

import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';

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
  static Color get positiveColor => AppColors.white;
  static Color get hintColor => AppColors.shuttleGray;
  static Color get darkDisabledColor => AppColors.ghostx2;
  static Color get heighlitedColor => AppColors.brightGray;
  static Color get transparentColor => AppColors.transparent;

  ///Background
  static Color get backgroundColor => AppColors.gin;
  static Color get secondaryBackgroundColor => AppColors.white;
  static Color get primaryBackgroundColor => AppColors.tranquil;
  static Color get registrationBackGroundColor => AppColors.gin;
  static Color get textFieldBackgroundColor => AppColors.athensGrayx2;

  /// System colors
  static Color get successColor => AppColors.fern;
  static Color get shadowColor => AppColors.black25;
  static Color get dividerColor => AppColors.solitude;
  static Color get barrierColor => AppColors.blackPearl31;
  static Color get drawerAccessoryColor => AppColors.athensGrey;
  static Color get errorColor => AppColors.harleyDavidsonOrange;

  /// Top Navigation Bar
  static Color get topNavBarInterfaceColor => AppColors.black;

  /// Navigation Bar
  static Color get navBarActiveIconColor => AppColors.fern;
  static Color get navBarBackgroundColor => AppColors.white;
  static Color get navBarInactiveIconColor => AppColors.aluminium;

  /// Progress Dialog
  static Color get progressInterfaceColor => AppColors.white;
  static Color get progressBarrierColor => AppColors.midnightExpress68;

  /// Segment Controller
  static Color get segmentBorderColor => AppColors.fern;
  static Color get segmentBackgroundColor => AppColors.white;
  static Color get segmentActiveTabTextColor => AppColors.white;
  static Color get segmentInactiveTabTextColor => AppColors.fern;
  static Color get segmentActiveBackgroundColor => AppColors.fern;

  /// Text Field
  static Color get textFieldDividerColor => AppColors.osloGray;
  static Color get textFieldPrimaryBackgroundColor => AppColors.white;
  static Color get textFieldSecondaryBackgroundColor => AppColors.solitude;

  /// Text
  static Color get textHintColor => AppColors.waterloo;
  static Color get textPrimaryColor => AppColors.black;
  static Color get hintTextColor => AppColors.osloGray;
  static Color get textSecondaryColor => AppColors.fern;
  static Color get secondaryTextColor => AppColors.comet;
  static Color get selectedListItemColor => AppColors.fern;
  static Color get descriptionTextColor => AppColors.midGrey;
  static Color get textHeavyHintColor => AppColors.shuttleGray;
  static Color get buttonTextSecondaryColor => AppColors.waterloo;
  static Color get unselectedListItemColor => AppColors.blackRussian;

  /// Button
  static Color get buttonDisabledColor => AppColors.athensGrey;
  static Color get buttonDisabledLightColor => AppColors.athensGrey;

  /// Button Border
  static Color get lightButtonBorder => AppColors.gallery;

  /// Primary
  static Color get buttonPrimaryColor => AppColors.fern;
  static Color get buttonBorderPrimaryColor => AppColors.white;
  static Color get buttonInterfacePrimaryColor => AppColors.white;

  /// Secondary
  static Color get buttonBorderSecondaryColor => AppColors.fern;
  static Color get buttonSecondaryColor => AppColors.transparent;
  static Color get buttonInterfaceSecondaryColor => AppColors.fern;

  /// Icons
  static Color get p => AppColors.p;
  static Color get k => AppColors.k;
  static Color get seaColor => AppColors.curiousBlue;
  static Color get bottomSheetLift => AppColors.ghost;
  static Color get errorIconColor => AppColors.cinnabar;
  static Color get iconPrimaryColor => AppColors.midGrey;
  static Color get iconHintColor => AppColors.shuttleGray;
  static Color get thirdPartyDescriptionColor => AppColors.stormGray;

  /// Toast
  static Color get toastBackgroundColor => AppColors.aluminium;
}
