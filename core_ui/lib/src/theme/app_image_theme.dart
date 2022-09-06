part of app_theme;

class AppImagesTheme {
  static const String packageCoreUI = 'core_ui';

  static const String _basePath = 'assets/images/';

  static const String _keyAppLogo = '${_basePath}app_logo.png';

  static const String _keyAmericanFlag = '${_basePath}american_flag.png';
  static const String _keyVisibilityOn = '${_basePath}visibility_on.png';

  static const String _keyVisibilityOff = '${_basePath}visibility_off.png';
  static const String _keyAlertBack = '${_basePath}alert_back.png';
  static const String _keyAlertSuccess = '${_basePath}alert_success.png';
  static const String _keyAlertRequest = '${_basePath}alert_request.png';
  static const String _keyAlertError = '${_basePath}alert_error.png';


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
