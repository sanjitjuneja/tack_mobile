part of app_theme;

class AppImagesTheme {
  static const String packageCoreUI = 'core_ui';

  static const String _basePath = 'assets/images/';
  static const String _imageNoResizePath = 'assets/images_no_resize/';

  static const String _keyAppLogo = '${_basePath}app_logo.png';

  static const String _keyAmericanFlag = '${_basePath}american_flag.png';
  static const String _keyVisibilityOn = '${_basePath}visibility_on.png';

  static const String _keyVisibilityOff = '${_basePath}visibility_off.png';
  static const String _keyAlertBack = '${_basePath}alert_back.png';
  static const String _keyAlertSuccess = '${_basePath}alert_success.png';
  static const String _keyAlertRequest = '${_basePath}alert_request.png';
  static const String _keyAlertError = '${_basePath}alert_error.png';

  /// Only 1x size.
  static const String _onboardingFirstKey = '${_imageNoResizePath}onboarding_first.png';
  static const String _onboardingSecondKey = '${_imageNoResizePath}onboarding_second.png';
  static const String _onboardingThirdKey = '${_imageNoResizePath}onboarding_third.png';
  ///

  /// TODO: think about location for big SVG
  static Widget get onboardingFirst => Image.asset(
        _onboardingFirstKey,
        package: packageCoreUI,
      );

  static Widget get onboardingSecond => Image.asset(
        _onboardingSecondKey,
        package: packageCoreUI,
      );

  static Widget get onboardingThird => Image.asset(
        _onboardingThirdKey,
        package: packageCoreUI,
      );

  static Image get alertBack => Image.asset(
        _keyAlertBack,
        package: packageCoreUI,
      );

  static Image get alertSuccess => Image.asset(
        _keyAlertSuccess,
        package: packageCoreUI,
      );

  static Image get alertRequest => Image.asset(
        _keyAlertRequest,
        package: packageCoreUI,
      );

  static Image get alertError => Image.asset(
        _keyAlertError,
        package: packageCoreUI,
      );

  static Image get appLogo => Image.asset(
        _keyAppLogo,
        package: packageCoreUI,
      );

  static Image get visibilityOff => Image.asset(
        _keyVisibilityOff,
        height: 20,
        width: 20,
        package: packageCoreUI,
      );

  static Image get visibilityOn => Image.asset(
        _keyVisibilityOn,
        height: 20,
        width: 20,
        package: packageCoreUI,
      );

  static Image get americanFlag => Image.asset(
        _keyAmericanFlag,
        height: 20,
        width: 20,
        package: packageCoreUI,
      );
}
