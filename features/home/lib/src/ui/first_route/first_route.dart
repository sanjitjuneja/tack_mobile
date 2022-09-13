import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:navigation/navigation.dart';

import 'first_route_form.dart';

class FirstRouteFeature {
  static const String routeName = '/firstRoute';

  static Page<void> page({
    bool withSlideAnimation = true,
  }) {
    return FirstRoutePage(
      withSlideAnimation: withSlideAnimation,
    );
  }
}

class FirstRoutePage extends Page<void> {
  final bool withSlideAnimation;
  final AppRouterDelegate _appRouter;

  @override
  String get name => FirstRouteFeature.routeName;

  FirstRoutePage({
    required this.withSlideAnimation,
  }) : _appRouter = appLocator.get<AppRouterDelegate>();

  @override
  Route<void> createRoute(BuildContext context) {
    final Widget child = FirstRouteForm(appRouter: _appRouter);

    if (withSlideAnimation) {
      return CupertinoPageRoute<void>(
        builder: (_) => child,
        settings: this,
      );
    } else {
      return OpacityRoute<void>(
        builder: (_) => child,
        settings: this,
      );
    }
  }
}
