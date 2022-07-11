part of app_theme;

class AppImagesTheme {
  static const String packageCoreUI = 'core_ui';

  static const String _basePath = 'assets/images/';

  static const String _keyStar = '${_basePath}star.png';
  static const String _keySearch = '${_basePath}search.png';
  static const String _keyEdit = '${_basePath}edit_icon.png';
  static const String _keyBell = '${_basePath}bell_icon.png';
  static const String _keyChat = '${_basePath}chat_icon.png';
  static const String _keyMessage = '${_basePath}message.png';
  static const String _keyFilter = '${_basePath}filter_icon.png';
  static const String _keyBurger = '${_basePath}burger_icon.png';
  static const String _keyProfileAvatar = '${_basePath}profile_avatar.png';
  static const String _keyTemporaryAvatar = '${_basePath}temporary_avatar.png';

  static const String _keyAlertBack = '${_basePath}alert_back.png';
  static const String _keyAlertSuccess = '${_basePath}alert_success.png';
  static const String _keyAlertRequest = '${_basePath}alert_request.png';
  static const String _keyAlertError = '${_basePath}alert_error.png';

  static const String _keyCheckMarkRounded = '${_basePath}check_mark_rounded.png';

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
}
