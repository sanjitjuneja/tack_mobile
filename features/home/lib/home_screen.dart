import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:core_ui/core_ui.dart';
import 'package:home/dashboard/dashboard_screen.dart';
import 'package:home/tack_creator/create_tack_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: AppImagesTheme.dashboard,
              ),
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: AppImagesTheme.addTab,
              ),
            ),
          ],
          backgroundColor: AppTheme.positiveColor,
          activeColor: AppTheme.grassColor,
        ),
        tabBuilder: (BuildContext context, int index) {
          switch (index) {
            case 0:
              return CupertinoTabView(
                builder: (BuildContext context) {
                  return const CupertinoPageScaffold(
                    backgroundColor: AppTheme.backgroundColor,
                    child: DashboardScreen(),
                  );
                },
              );
            case 1:
              return CupertinoTabView(
                builder: (BuildContext context) {
                  return const CupertinoPageScaffold(
                    backgroundColor: AppTheme.backgroundColor,
                    child: CreateTackScreen(),
                  );
                },
              );

            default:
              return const CupertinoTabView();
          }
        },
      ),
    );
  }
}
