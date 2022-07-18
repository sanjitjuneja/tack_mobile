import 'package:core/di/app_di.dart';
import 'package:dashboard/dashboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:core_ui/core_ui.dart';
import 'package:groups/groups.dart';

import 'package:home/src/tack_creator/create_tack_screen.dart';
import 'package:navigation/navigation.dart';
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
                    return CupertinoPageScaffold(
                      backgroundColor: AppTheme.backgroundColor,
                      child: const CreateTackScreen(),
                    );
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

  // TODO: remove.
  Widget _dialogsTest(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          AppCircleButton(
            labelKey: 'Request alert',
            onTap: () {
              appLocator.get<AppRouterDelegate>().push(
                    AppAlertDialog.page(
                      RequestAlert(
                        contentKey: 'otherAlert.offerSent',
                      ),
                      onButtonTap: () {},
                    ),
                  );
            },
          ),
          const SizedBox(height: 6),
          AppCircleButton(
            labelKey: 'New Group Request alert',
            onTap: () {
              appLocator.get<AppRouterDelegate>().push(
                    AppAlertDialog.page(
                      RequestAlert(
                        contentKey: 'otherAlert.newGroupRequested',
                      ),
                    ),
                  );
            },
          ),
          const SizedBox(height: 6),
          AppCircleButton(
            labelKey: 'Cancelled alert',
            onTap: () {
              appLocator.get<AppRouterDelegate>().push(
                    AppAlertDialog.page(
                      ErrorAlert(
                        contentKey: 'errorAlert.tackCanceled',
                      ),
                    ),
                  );
            },
          ),
          const SizedBox(height: 6),
          AppCircleButton(
            labelKey: 'Offer accepted alert',
            onTap: () {
              appLocator.get<AppRouterDelegate>().push(
                    AppAlertDialog.page(
                      SuccessAlert(
                        contentKey: 'otherAlert.offerAccepted',
                      ),
                    ),
                  );
            },
          ),
          const SizedBox(height: 6),
          AppCircleButton(
            labelKey: 'You now in group alert',
            onTap: () {
              appLocator.get<AppRouterDelegate>().push(
                    AppAlertDialog.page(
                      SuccessAlert(
                        contentKey: 'otherAlert.inGroupNow',
                        translationParams: {
                          AlertPropertyKey.message: {
                            'groupName': 'Calllaway Group',
                          },
                        },
                      ),
                    ),
                  );
            },
          ),
          const SizedBox(height: 6),
          AppCircleButton(
            labelKey: 'Group created alert',
            onTap: () {
              appLocator.get<AppRouterDelegate>().push(
                    AppAlertDialog.page(
                      SuccessAlert(
                        contentKey: 'otherAlert.groupCreated',
                        translationParams: {
                          AlertPropertyKey.message: {
                            'groupName': 'Calllaway Group',
                          },
                        },
                      ),
                    ),
                  );
            },
          ),
          const SizedBox(height: 6),
          AppCircleButton(
            labelKey: 'Destructive dialog without title',
            onTap: () {
              appLocator.get<AppRouterDelegate>().push(
                    DestructiveDialog.page(
                      DestructiveAlert(
                        contentKey: 'destructiveAlert.cancelTack',
                        titleKey: '',
                        translationParams: {
                          AlertPropertyKey.message: {
                            'tackName': 'Need Laundry and Dishes...'
                          },
                        },
                      ),
                    ),
                  );
            },
          ),
          const SizedBox(height: 6),
          AppCircleButton(
            labelKey: 'Destructive dialog with title',
            onTap: () {
              appLocator.get<AppRouterDelegate>().push(
                    DestructiveDialog.page(
                      DestructiveAlert(
                        contentKey: 'destructiveAlert.cancelTack',
                        translationParams: {
                          AlertPropertyKey.message: {
                            'tackName': 'Need Laundry and Dishes...'
                          },
                        },
                      ),
                    ),
                  );
            },
          ),
          const SizedBox(height: 6),
          AppCircleButton(
            labelKey: 'Delete account dialog',
            onTap: () {
              appLocator.get<AppRouterDelegate>().push(
                    DestructiveDialog.page(
                      DestructiveAlert(
                        contentKey: 'destructiveAlert.deleteAccount',
                      ),
                    ),
                  );
            },
          ),
          const SizedBox(height: 6),
          AppCircleButton(
            labelKey: 'Open my groups',
            onTap: () {
              appLocator.get<AppRouterDelegate>().push(
                    MyGroups.page(),
                  );
            },
          ),
          const SizedBox(height: 6),
          AppCircleButton(
            labelKey: 'Open my invitations',
            onTap: () {
              appLocator.get<AppRouterDelegate>().push(
                    Invitations.page(),
                  );
            },
          ),
          const SizedBox(height: 6),
          AppCircleButton(
            labelKey: 'Invitation details',
            onTap: () {
              appLocator.get<AppRouterDelegate>().push(
                    InvitationDetails.page(),
                  );
            },
          ),
        ],
      ),
    );
  }
}
