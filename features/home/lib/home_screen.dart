import 'package:core/di/app_di.dart';
import 'package:dashboard/dashboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:core_ui/core_ui.dart';

import 'package:home/tack_creator/create_tack_screen.dart';
import 'package:navigation/navigation.dart';
import 'package:share_plus/share_plus.dart';

class HomeScreen extends StatelessWidget {
  static const int _dashboardTabIndex = 0;
  static const int _addTabIndex = 1;
  static const int _tacksTabIndex = 2;

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MediaQuery.removePadding(
        context: context,
        removeBottom: true,
        child: CupertinoTabScaffold(
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
              case _dashboardTabIndex:
                return CupertinoTabView(
                  builder: (_) {
                    return const DashboardScreen();
                  },
                );
              case _addTabIndex:
                return CupertinoTabView(
                  builder: (_) {
                    return const CupertinoPageScaffold(
                      backgroundColor: AppTheme.backgroundColor,
                      child: CreateTackScreen(),
                    );
                  },
                );
              case _tacksTabIndex:
                return CupertinoTabView(
                  builder: (_) {
                    return CupertinoPageScaffold(
                      backgroundColor: AppTheme.backgroundColor,
                      child: _dialogsTest(context),
                    );
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
    return Column(
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
      ],
    );
  }
}
