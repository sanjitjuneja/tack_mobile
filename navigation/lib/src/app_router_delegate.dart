import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:home/home.dart';
import 'package:navigation/src/global_app_router_delegate.dart';

class AppRouterDelegate extends GlobalAppRouterDelegate {
  // TODO: refactor;
  final GlobalKey<State<HomeScreen>> navigationTabKey =
      GlobalKey<State<HomeScreen>>();

  AppRouterDelegate({
    required super.messageNotifier,
    required super.popNavigationObserver,
  });

  HomeScreenState get navigationTabState =>
      navigationTabKey.currentState as HomeScreenState;
}

extension AppRouter on AppRouterDelegate {
  static AppRouterDelegate of(BuildContext context) {
    return Router.of(context).routerDelegate as AppRouterDelegate;
  }
}
