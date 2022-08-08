import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PopNavigationObserver extends NavigatorObserver {
  void Function(Route<dynamic> route, Route<dynamic>? previousRoute)? onPopBack;

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    onPopBack?.call(route, previousRoute);
    super.didPop(route, previousRoute);
  }
}
