import 'package:core_ui/src/theme/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class _TopSlideRouteLayout extends SingleChildLayoutDelegate {
  final double progress;

  _TopSlideRouteLayout(this.progress);

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    return BoxConstraints(
      minWidth: constraints.maxWidth,
      maxWidth: constraints.maxWidth,
      minHeight: 0.0,
      maxHeight: constraints.maxHeight * 0.85,
    );
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    return Offset(
      1,
      -childSize.height + childSize.height * progress,
    );
  }

  @override
  bool shouldRelayout(_TopSlideRouteLayout oldDelegate) {
    return progress != oldDelegate.progress;
  }
}

class _TopSlideRouteBody<T> extends StatelessWidget {
  final TopSlideRoute route;

  const _TopSlideRouteBody({
    super.key,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: route.animation!,
      child: route.builder!(context),
      builder: (_, Widget? child) {
        final double animationValue = route.animation!.value;

        return ClipRect(
          child: CustomSingleChildLayout(
            delegate: _TopSlideRouteLayout(animationValue),
            child: child,
          ),
        );
      },
    );
  }
}

class TopSlideRoute<T> extends PopupRoute<T> {
  TopSlideRoute({
    required this.builder,
    this.barrierLabel,
    this.modalBarrierColor,
    this.isDismissible = true,
    RouteSettings? settings,
  }) : super(settings: settings);

  final WidgetBuilder? builder;
  final Color? modalBarrierColor;
  final bool isDismissible;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 300);

  @override
  Duration get reverseTransitionDuration => const Duration(milliseconds: 300);

  @override
  bool get barrierDismissible => isDismissible;

  @override
  final String? barrierLabel;

  @override
  Color get barrierColor => AppTheme.barrierColor;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return _TopSlideRouteBody<T>(
      route: this,
    );
  }
}
