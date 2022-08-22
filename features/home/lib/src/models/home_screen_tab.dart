enum HomeScreenTab {
  dashboard(tabIndex: dashboardTabIndex),
  add(tabIndex: addTabIndex),
  tacks(tabIndex: tacksTabIndex);

  final int tabIndex;

  static const int dashboardTabIndex = 0;
  static const int addTabIndex = 1;
  static const int tacksTabIndex = 2;

  const HomeScreenTab({
    required this.tabIndex,
  });
}
