part of app_theme;

class AppIconsTheme {
  static Color get primaryColor => AppColors.midGrey;
  static Color get hintColor => AppColors.shuttleGray;

  static const String _basePath = 'assets/icons/';
  static const String _navigationPath = 'assets/navigation/';

  /// Bottom Navigation bar
  static const String _dashboardActiveKey = '${_navigationPath}dashboard_active.png';
  static const String _dashboardInactiveKey = '${_navigationPath}dashboard_inactive.png';
  static const String _addActiveKey = '${_navigationPath}add_active.png';
  static const String _addInactiveKey = '${_navigationPath}add_inactive.png';
  static const String _tacksActiveKey = '${_navigationPath}tacks_active.png';
  static const String _tacksInactiveKey = '${_navigationPath}tacks_inactive.png';
  ///

  static const String _chevronLeftKey = '${_basePath}chevron_left.png';

  static const String _chatKey = '${_basePath}chat.png';
  static const String _notificationKey = '${_basePath}notification.png';
  static const String _menuKey = '${_basePath}menu.png';

  static const String _searchKey = '${_basePath}search.png';
  static const String _editKey = '${_basePath}edit.png';
  static const String _personKey = '${_basePath}person.png';
  static const String _starKey = '${_basePath}star.png';
  static const String _messageKey = '${_basePath}message.png';
  static const String _taskCompleteKey = '${_basePath}task_complete.png';
  static const String _cameraKey = '${_basePath}camera.png';
  static const String _trashKey = '${_basePath}trash.png';

  /// Bottom Navigation bar
  static AppIcon get dashboardsActive => AppIcon(_dashboardActiveKey);
  static AppIcon get dashboardInactive => AppIcon(_dashboardInactiveKey);
  static AppIcon get addActive => AppIcon(_addActiveKey);
  static AppIcon get addInactive => AppIcon(_addInactiveKey);
  static AppIcon get tacksActive => AppIcon(_tacksActiveKey);
  static AppIcon get tacksInactive => AppIcon(_tacksInactiveKey);
  ///

  static AppIcon get chevronLeft => AppIcon(_chevronLeftKey);

  static AppIcon get chat => AppIcon(_chatKey);
  static AppIcon get notification => AppIcon(_notificationKey);
  static AppIcon get menu => AppIcon(_menuKey);

  static AppIcon get search => AppIcon(_searchKey);
  static AppIcon get edit => AppIcon(_editKey);
  static AppIcon get person => AppIcon(_personKey);
  static AppIcon get star => AppIcon(_starKey);
  static AppIcon get message => AppIcon(_messageKey);
  static AppIcon get taskComplete => AppIcon(_taskCompleteKey);
  static AppIcon get camera => AppIcon(_cameraKey);
  static AppIcon get trash => AppIcon(_trashKey);
}
