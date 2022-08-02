part of app_theme;

class AppIconsTheme {
  static Color get primaryColor => AppColors.midGrey;
  static Color get hintColor => AppColors.shuttleGray;

  static const String _basePath = 'assets/icons/';
  static const String _navigationPath = 'assets/navigation/';
  static const String _svgPath = 'assets/svg/';

  /// Bottom Navigation bar
  static const String _dashboardActiveKey = '${_navigationPath}dashboard_active.svg';
  static const String _dashboardInactiveKey = '${_navigationPath}dashboard_inactive.svg';
  static const String _addActiveKey = '${_navigationPath}add_active.svg';
  static const String _addInactiveKey = '${_navigationPath}add_inactive.svg';
  static const String _tacksActiveKey = '${_navigationPath}tacks_active.svg';
  static const String _tacksInactiveKey = '${_navigationPath}tacks_inactive.svg';
  ///

  static const String _chatKey = '${_basePath}chat.png';
  static const String _notificationKey = '${_basePath}notification.png';
  static const String _menuKey = '${_basePath}menu.png';

  static const String _searchKey = '${_basePath}search.png';
  static const String _editKey = '${_basePath}edit.png';
  static const String _personKey = '${_basePath}person.png';
  static const String _messageKey = '${_basePath}message.png';
  static const String _taskCompleteKey = '${_basePath}task_complete.png';
  static const String _cameraKey = '${_basePath}camera.png';
  static const String _trashKey = '${_basePath}trash.png';
  static const String _copyKey = '${_basePath}copy.png';
  static const String _shareKey = '${_basePath}share.png';
  static const String _successKey = '${_basePath}success.png';
  static const String _crossErrorKey = '${_basePath}cross.png';

  /// SVG
  static const String _chevronLeftKey = '${_svgPath}chevron_left.svg';
  static const String _chevronRightKey = '${_svgPath}chevron_right.svg';
  static const String _crossKey = '${_svgPath}cross.svg';
  static const String _logoutKey = '${_svgPath}logout.svg';

  static const String _tacksListKey = '${_svgPath}tacks_list.svg';
  static const String _peopleKey = '${_svgPath}people.svg';
  static const String _phoneKey = '${_svgPath}phone.svg';
  static const String _moreKey = '${_svgPath}more.svg';
  static const String _starKey = '${_svgPath}star.svg';
  static const String _tackKey = '${_svgPath}tack.svg';
  static const String _rateStarKey = '${_svgPath}rate_star.svg';
  static const String _promptKey = '${_svgPath}prompt.svg';
  static const String _editPencilKey = '${_svgPath}edit_pencil.svg';
  static const String _plusKey = '${_svgPath}plus.svg';
  static const String _bankRoundedKey = '${_svgPath}bank_rounded.svg';
  static const String _bankRoundedFilledKey = '${_svgPath}bank_rounded_filled.svg';
  static const String _addKey = '${_svgPath}add.svg';
  static const String _masterCardKey = '${_svgPath}master_card.svg';
  static const String _morganChaseKey = '${_svgPath}morgan_chase.svg';
  static const String _applePayKey = '${_svgPath}apple_pay.svg';
  static const String _bankKey = '${_svgPath}bank.svg';
  static const String _lockKey = '${_svgPath}lock.svg';
  static const String _cardKey = '${_svgPath}card.svg';
  static const String _chevronRightRoundedKey = '${_svgPath}chevron_right_rounded.svg';

  /// Bottom Navigation bar
  static AppIcon get dashboardsActive => AppIcon(_dashboardActiveKey);
  static AppIcon get dashboardInactive => AppIcon(_dashboardInactiveKey);
  static AppIcon get addActive => AppIcon(_addActiveKey);
  static AppIcon get addInactive => AppIcon(_addInactiveKey);
  static AppIcon get tacksActive => AppIcon(_tacksActiveKey);
  static AppIcon get tacksInactive => AppIcon(_tacksInactiveKey);
  ///

  static AppIcon get chat => AppIcon(_chatKey);
  static AppIcon get notification => AppIcon(_notificationKey);
  static AppIcon get menu => AppIcon(_menuKey);

  static AppIcon get search => AppIcon(_searchKey);
  static AppIcon get edit => AppIcon(_editKey);
  static AppIcon get person => AppIcon(_personKey);
  static AppIcon get message => AppIcon(_messageKey);
  static AppIcon get taskComplete => AppIcon(_taskCompleteKey);
  static AppIcon get camera => AppIcon(_cameraKey);
  static AppIcon get trash => AppIcon(_trashKey);
  static AppIcon get copy => AppIcon(_copyKey);
  static AppIcon get share => AppIcon(_shareKey);
  static AppIcon get success => AppIcon(_successKey);
  static AppIcon get crossError => AppIcon(_crossErrorKey);

  /// SVG
  static AppIcon get chevronLeft => AppIcon(_chevronLeftKey);
  static AppIcon get chevronRight => AppIcon(_chevronRightKey);
  static AppIcon get cross => AppIcon(_crossKey);
  static AppIcon get logout => AppIcon(_logoutKey);

  static AppIcon get tacksList => AppIcon(_tacksListKey);
  static AppIcon get people => AppIcon(_peopleKey);
  static AppIcon get phone => AppIcon(_phoneKey);
  static AppIcon get more => AppIcon(_moreKey);
  static AppIcon get star => AppIcon(_starKey);
  static AppIcon get tack => AppIcon(_tackKey);
  static AppIcon get rateStar => AppIcon(_rateStarKey);
  static AppIcon get prompt => AppIcon(_promptKey);
  static AppIcon get editPencil => AppIcon(_editPencilKey);
  static AppIcon get plus => AppIcon(_plusKey);
  static AppIcon get bankRounded => AppIcon(_bankRoundedKey);
  static AppIcon get bankRoundedFilled => AppIcon(_bankRoundedFilledKey);
  static AppIcon get bank => AppIcon(_bankKey);
  static AppIcon get add => AppIcon(_addKey);
  static AppIcon get masterCard => AppIcon(_masterCardKey);
  static AppIcon get morganChase => AppIcon(_morganChaseKey);
  static AppIcon get applePay => AppIcon(_applePayKey);
  static AppIcon get lock => AppIcon(_lockKey);
  static AppIcon get card => AppIcon(_cardKey);
  static AppIcon get chevronRightRounded => AppIcon(_chevronRightRoundedKey);
}
