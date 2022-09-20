import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../navigation.dart';

class GlobalAppRouterDelegate extends RouterDelegate<RouteConfiguration>
    with
        ChangeNotifier,
        PageStackController,
        PopNavigatorRouterDelegateMixin<RouteConfiguration> {
  final AppMessageNotifier messageNotifier;
  final PopNavigationObserver popNavigationObserver;

  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  GlobalAppRouterDelegate({
    required this.messageNotifier,
    required this.popNavigationObserver,
  });

  @override
  Future<bool> popRoute() async {
    // check if we have pages in the stack to pop before
    // attempting app exit
    if (pages.length > 1) {
      // handle popping the current page off of the stack
      autoPop();
      return Future.value(true);
    }

    // TODO: implement App designed exit dialog.
    final bool? shouldPop = await showDialog<bool>(
      // get the context from the navigatorKey defined
      // in your RouterDelegate class
      context: navigatorKey.currentContext!,
      builder: (context) {
        return AlertDialog(
          title: const Text('Exit App'),
          content: const Text('Are you sure you want to exit the app?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.pop(context, true),
            ),
            TextButton(
              child: const Text('Confirm'),
              onPressed: () => Navigator.pop(context, false),
            ),
          ],
        );
      },
    );
    // if the dialog is dismissed by tapping outside of the barrier
    // the result is null, so we return false
    return shouldPop ?? false;
  }

  @override
  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  @override
  RouteConfiguration? get currentConfiguration =>
      pages.isNotEmpty ? RouteConfiguration(page: pages.last) : null;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: _navigatorKey,
      onPopPage: onPopPage,
      pages: pages,
      observers: <NavigatorObserver>[
        messageNotifier,
        popNavigationObserver,
      ],
    );
  }

  @override
  Future<void> setNewRoutePath(RouteConfiguration configuration) {
    resetTo(configuration.page);
    return SynchronousFuture<void>(null);
  }

  @override
  void notifyListeners() {
    messageNotifier.updateScaffoldKey();
    super.notifyListeners();
  }

  bool onPopPage(Route<dynamic> route, dynamic result) {
    onPopResultDispatch(pages);
    final bool didPop = route.didPop(result);
    if (!didPop) {
      return false;
    }
    pop();
    return true;
  }

  void pushNamed(String routeLocation) {
    push(RoutePageGenerator.generateRoute(routeLocation));
  }

  void pushNamedWithFixedPop(int popCount, Page<dynamic> page) {
    for (int i = 0; i < popCount; i++) {
      pop();
    }
    push(page);
  }

  void popWithFixedCount(int popCount) {
    for (int i = 0; i < popCount; i++) {
      pop();
    }
  }
}

extension GlobalAppRouter on GlobalAppRouterDelegate {
  static GlobalAppRouterDelegate of(BuildContext context) {
    return Router.of(context).routerDelegate as GlobalAppRouterDelegate;
  }
}
