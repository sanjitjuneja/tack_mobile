import 'package:core/core.dart';
import 'package:create_tack/create_tack.dart';
import 'package:dashboard/dashboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:core_ui/core_ui.dart';

import 'package:tacks/tacks.dart';

import '../../models/home_screen_tab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  static const double _iconSize = 28.0;

  late CupertinoTabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = CupertinoTabController(
      initialIndex: HomeScreenTab.dashboardTabIndex,
    );
  }

  void changeTabIndex(HomeScreenTab tab) {
    _tabController.index = tab.tabIndex;
  }

  List<BottomNavigationBarItem> _getNavigationItems(BuildContext context) {
    return List<BottomNavigationBarItem>.generate(
      HomeScreenTab.values.length,
      (int index) {
        final AppIcon activeIcon;
        final AppIcon inactiveIcon;
        final String labelKey;

        switch (index) {
          case HomeScreenTab.dashboardTabIndex:
            activeIcon = AppIconsTheme.dashboardsActive;
            inactiveIcon = AppIconsTheme.dashboardInactive;
            labelKey = HomeScreenTab.dashboard.name;
            break;
          case HomeScreenTab.addTabIndex:
            activeIcon = AppIconsTheme.addActive;
            inactiveIcon = AppIconsTheme.addInactive;
            labelKey = HomeScreenTab.add.name;
            break;
          case HomeScreenTab.tacksTabIndex:
            activeIcon = AppIconsTheme.tacksActive;
            inactiveIcon = AppIconsTheme.tacksInactive;
            labelKey = HomeScreenTab.tacks.name;
            break;
          default:
            throw Exception('Index is not supported byt navigation bar');
        }

        return BottomNavigationBarItem(
          label: FlutterI18n.translate(context, 'homeScreen.tabs.$labelKey'),
          activeIcon: Padding(
            padding: const EdgeInsets.only(top: 12),
            child: activeIcon(size: _iconSize),
          ),
          icon: Padding(
            padding: const EdgeInsets.only(top: 12),
            child: inactiveIcon(size: _iconSize),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      resizeToAvoidBottomInset: false,
      controller: _tabController,
      tabBar: CupertinoTabBar(
        items: _getNavigationItems(context),
        backgroundColor: AppTheme.navBarBackgroundColor,
        activeColor: AppTheme.navBarActiveIconColor,
        inactiveColor: AppTheme.navBarInactiveIconColor,
        height: 55,
      ),
      tabBuilder: (_, int index) {
        switch (index) {
          case HomeScreenTab.dashboardTabIndex:
            return CupertinoTabView(
              builder: (_) {
                return const DashboardScreen();
              },
            );
          case HomeScreenTab.addTabIndex:
            return CupertinoTabView(
              builder: (_) {
                return const CreateTackScreen();
              },
            );
          case HomeScreenTab.tacksTabIndex:
            return CupertinoTabView(
              builder: (_) {
                return const TacksScreen();
              },
            );
          default:
            return const CupertinoTabView();
        }
      },
    );
  }
}
