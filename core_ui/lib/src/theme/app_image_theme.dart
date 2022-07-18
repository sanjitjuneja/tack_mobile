part of app_theme;

class AppImagesTheme {
  static const String packageCoreUI = 'core_ui';

  static const String _basePath = 'assets/images/';

  static const String _keyStar = '${_basePath}star.png';

  static const String _keySearch = '${_basePath}search.png';
  static const String _keyEdit = '${_basePath}edit_icon.png';
  static const String _keyAddTab = '${_basePath}add_tab.png';
  static const String _keyBell = '${_basePath}bell_icon.png';
  static const String _keyChat = '${_basePath}chat_icon.png';

  static const String _keyMessage = '${_basePath}message.png';
  static const String _keyAppLogo = '${_basePath}app_logo.png';

  static const String _keyFilter = '${_basePath}filter_icon.png';
  static const String _keyVemoLogo = '${_basePath}vemo_logo.png';
  static const String _keyBurger = '${_basePath}burger_icon.png';
  static const String _keyDashboard = '${_basePath}home_tab.png';

  static const String _keyBackArrow = '${_basePath}back_arrow.png';
  static const String _successIcon = '${_basePath}success_lable.png';
  static const String _keyAmericanFlag = '${_basePath}american_flag.png';
  static const String _keyVisibilityOn = '${_basePath}visibility_on.png';

  static const String _keyRadioFalse = '${_basePath}radio_check_box.png';
  static const String _keyVisibilityOff = '${_basePath}visibility_off.png';
  static const String _keyAlertBack = '${_basePath}alert_back.png';
  static const String _keyAlertSuccess = '${_basePath}alert_success.png';
  static const String _keyAlertRequest = '${_basePath}alert_request.png';
  static const String _keyAlertError = '${_basePath}alert_error.png';

  static const String _keyCheckMarkRounded =
      '${_basePath}check_mark_rounded.png';

  static const String _keyRadioTrue = '${_basePath}radio_check_box_true.png';
  static const String _keyProfileAvatar = '${_basePath}profile_avatar.png';
  static const String _keyTemporaryAvatar = '${_basePath}temporary_avatar.png';
  static const String _fieldValidationSuccessIcon =
      '${_basePath}field_success.png';

  static ImageIcon get dashboard => const ImageIcon(
        AssetImage(
          _keyDashboard,
          package: packageCoreUI,
        ),
      );

  static ImageIcon get addTab => const ImageIcon(
        AssetImage(
          _keyAddTab,
          package: packageCoreUI,
        ),
      );

  static ImageIcon get backArrow => ImageIcon(
        const AssetImage(
          _keyBackArrow,
          package: packageCoreUI,
        ),
        color: AppTheme.accentColor,
      );

  static Image get temporaryAvatar => Image.asset(
        _keyTemporaryAvatar,
        package: packageCoreUI,
      );

  static Image get star => Image.asset(
        _keyStar,
        package: packageCoreUI,
      );

  static Image get message => Image.asset(
        _keyMessage,
        package: packageCoreUI,
      );

  static Image get avatar => Image.asset(
        _keyProfileAvatar,
        package: packageCoreUI,
      );

  static Image get chat => Image.asset(
        _keyChat,
        package: packageCoreUI,
      );

  static Image get bell => Image.asset(
        _keyBell,
        package: packageCoreUI,
      );

  static Image get burger => Image.asset(
        _keyBurger,
        package: packageCoreUI,
      );

  static Image get edit => Image.asset(
        _keyEdit,
        package: packageCoreUI,
      );

  static Image get filter => Image.asset(
        _keyFilter,
        package: packageCoreUI,
      );

  static Image get search => Image.asset(
        _keySearch,
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

  static Image get checkMarkRounded => Image.asset(
        _keyCheckMarkRounded,
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

  static Image get radioCheckBoxTrue => Image.asset(
        _keyRadioTrue,
        package: packageCoreUI,
      );

  static Image get radioCheckBoxFalse => Image.asset(
        _keyRadioFalse,
        package: packageCoreUI,
      );

  static Image get vemoLogo => Image.asset(
        _keyVemoLogo,
        package: packageCoreUI,
      );

  static Image get success => Image.asset(
        _successIcon,
        package: packageCoreUI,
      );

  static Image get fieldSuccessIcon => Image.asset(
        _fieldValidationSuccessIcon,
        package: packageCoreUI,
      );
}
