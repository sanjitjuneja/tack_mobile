import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'app_router.dart';

class PopNavigationObserver extends NavigatorObserver {
  late AppRouter? appRouter;

  void Function(Route<dynamic> route, Route<dynamic>? previousRoute)? onPopBack;

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    onPopBack?.call(route, previousRoute);
    super.didPop(route, previousRoute);
  }
}
