import 'package:core_ui/src/theme/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class _LeftSlideRouteLayout extends SingleChildLayoutDelegate {
  final double progress;

  _LeftSlideRouteLayout(this.progress);

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    return BoxConstraints(
      minWidth: 0.0,
      maxWidth: constraints.maxWidth,
      minHeight: constraints.minHeight,
      maxHeight: constraints.maxHeight,
    );
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    return Offset(
      -childSize.width + childSize.width * progress,
      0,
    );
  }

  @override
  bool shouldRelayout(_LeftSlideRouteLayout oldDelegate) {
    return progress != oldDelegate.progress;
  }
}

class _LeftSlideRouteBody<T> extends StatelessWidget {
  final LeftSlideRoute route;

  const _LeftSlideRouteBody({
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

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: ClipRect(
                child: CustomSingleChildLayout(
                  delegate: _LeftSlideRouteLayout(animationValue),
                  child: child,
                ),
              ),
            ),
            Opacity(
              opacity: animationValue,
              child: route.rightOuterAnimationWidget,
            ),
          ],
        );
      },
    );
  }
}

class LeftSlideRoute<T> extends PopupRoute<T> {
  LeftSlideRoute({
    required this.builder,
    this.rightOuterAnimationWidget,
    this.barrierLabel,
    this.modalBarrierColor,
    this.isDismissible = true,
    RouteSettings? settings,
  }) : super(settings: settings);

  final WidgetBuilder? builder;
  final Widget? rightOuterAnimationWidget;
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
    return _LeftSlideRouteBody<T>(
      route: this,
    );
  }
}
