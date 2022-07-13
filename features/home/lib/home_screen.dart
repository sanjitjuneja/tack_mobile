import 'package:core/core.dart';
import 'package:core/di/app_di.dart';
import 'package:dashboard/dashboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:core_ui/core_ui.dart';

import 'package:home/tack_creator/create_tack_screen.dart';
import 'package:navigation/navigation.dart';

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
                      contentKey: 'test',
                      title: 'Offer Sent',
                      message: 'We will notify you if the offer is accepted',
                      buttonLabel: 'View All Offers Sent',
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
                      contentKey: 'test',
                      title: 'New Group Requested...',
                      message:
                          'We will notify you via text if the new group is accepted (1-2 days)',
                      buttonLabel: 'Close',
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
                    DestructiveAlert(
                      contentKey: 'test',
                      title: 'Tack Cancelled',
                      buttonLabel: 'Close',
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
                      contentKey: 'test',
                      title: 'Offer Accepted',
                      message: 'Need someone to Re-string my Fender Strat',
                      buttonLabel: 'Begin Tack',
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
                      contentKey: 'test',
                      message:
                          'You are now a member of\n <highlight-colored>Calllaway Group</highlight-colored>',
                      buttonLabel: 'Close',
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
                      contentKey: 'test',
                      message:
                          'Are you sure want to <colored>Cancel</colored>\n <highlight>Need Laundry and Dishes...</highlight>',
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
                      contentKey: 'test',
                      title: 'Your Tack Score Will Decrease',
                      message:
                          'Are you sure want to <colored>Cancel</colored>\n <highlight>Need Laundry and Dishes...</highlight>',
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
                      contentKey: 'test',
                      message:
                          'Are you sure you want to \n<colored>Delete Your Account</colored>?',
                    ),
                  ),
                );
          },
        ),
        const SizedBox(height: 10),
        AppCircleButton(
          labelKey: 'test',
          onTap: () {
            BlocProvider.of<DashboardBloc>(context).add(const ChangeGroup());
          },
        ),
      ],
    );
  }
}
