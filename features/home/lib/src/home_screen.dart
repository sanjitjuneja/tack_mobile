import 'package:create_tack/create_tack.dart';
import 'package:dashboard/dashboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:core_ui/core_ui.dart';

import 'package:tacks/tacks.dart';

enum HomeScreenTab {
  dashboard(tabIndex: dashboardTabIndex),
  add(tabIndex: addTabIndex),
  tacks(tabIndex: tacksTabIndex);

  final int tabIndex;

  static const int dashboardTabIndex = 0;
  static const int addTabIndex = 1;
  static const int tacksTabIndex = 2;

  const HomeScreenTab({required this.tabIndex});
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  late CupertinoTabController _tabController;

  @override
  void initState() {
    _tabController = CupertinoTabController(
      initialIndex: HomeScreenTab.dashboardTabIndex,
    );

    super.initState();
  }

  void changeTabIndex(HomeScreenTab tab) {
    _tabController.index = tab.tabIndex;
    // setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MediaQuery.removePadding(
        context: context,
        removeBottom: true,
        child: CupertinoTabScaffold(
          controller: _tabController,
          tabBar: CupertinoTabBar(
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                activeIcon: AppIconsTheme.dashboardsActive(),
                icon: AppIconsTheme.dashboardInactive(),
              ),
              BottomNavigationBarItem(
                activeIcon: AppIconsTheme.addActive(),
                icon: AppIconsTheme.addInactive(),
              ),
              BottomNavigationBarItem(
                activeIcon: AppIconsTheme.tacksActive(),
                icon: AppIconsTheme.tacksInactive(),
              ),
            ],
            backgroundColor: AppTheme.navBarBackgroundColor,
            activeColor: AppTheme.navBarActiveIconColor,
            inactiveColor: AppTheme.navBarInactiveIconColor,
            height: 85,
            border: null,
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
        ),
      ),
    );
  }
}
