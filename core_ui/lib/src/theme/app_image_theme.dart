import 'package:flutter/material.dart';

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
  static const String _keyFilter = '${_basePath}filter_icon.png';
  static const String _keyBurger = '${_basePath}burger_icon.png';
  static const String _keyDashboard = '${_basePath}home_tab.png';
  static const String _keyProfileAvatar = '${_basePath}profile_avatar.png';
  static const String _keyTemporaryAvatar = '${_basePath}temporary_avatar.png';

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
}
