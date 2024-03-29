import 'package:flutter/material.dart';

import 'global_app_router_delegate.dart';

class AppMessageNotifier extends NavigatorObserver {
  late GlobalAppRouterDelegate? appRouter;

  GlobalKey<ScaffoldMessengerState>? _scaffoldKey;

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    updateScaffoldKey();
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didRemove(route, previousRoute);
    updateScaffoldKey();
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    updateScaffoldKey();
  }

  void showMessageFromLocalization(String key) {
    _scaffoldKey?.currentState!.showSnackBar(
      const SnackBar(
        content: Text(''),
      ),
    );
  }

  void updateScaffoldKey() {
    _scaffoldKey = appRouter?.currentConfiguration?.scaffoldKey;
  }
}
