import 'package:core/core.dart';
import 'package:core_ui/src/theme/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:navigation/navigation.dart';

class _TopSlideRouteLayout extends SingleChildLayoutDelegate {
  final double progress;

  _TopSlideRouteLayout(this.progress);

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    return BoxConstraints(
      minWidth: constraints.maxWidth,
      maxWidth: constraints.maxWidth,
      minHeight: 0.0,
      maxHeight: constraints.maxHeight * 0.37,
    );
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    return Offset(
      0,
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

        return Stack(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                if (!route.isDismissible) return;

                if (isVoid(T)) {
                  AppRouter.of(context).pop();
                } else {
                  AppRouter.of(context).popWithResult(null);
                }
              },
              child: Container(
                color: route.modalBarrierColor.withOpacity(
                  route.modalBarrierColor.opacity * animationValue,
                ),
              ),
            ),
            ClipRect(
              child: CustomSingleChildLayout(
                delegate: _TopSlideRouteLayout(animationValue),
                child: child,
              ),
            ),
          ],
        );
      },
    );
  }
}

class TopSlideRoute<T> extends PopupRoute<T> {
  static const Duration _defaultAnimationDuration = Duration(milliseconds: 300);

  TopSlideRoute({
    required this.builder,
    this.barrierLabel,
    Color? modalBarrierColor,
    this.isDismissible = true,
    this.transitionAnimationDuration,
    RouteSettings? settings,
  })  : modalBarrierColor = modalBarrierColor ?? AppTheme.barrierColor,
        super(settings: settings);

  final WidgetBuilder? builder;
  final Color modalBarrierColor;
  final bool isDismissible;
  final Duration? transitionAnimationDuration;

  @override
  Duration get transitionDuration =>
      transitionAnimationDuration ?? _defaultAnimationDuration;

  @override
  Duration get reverseTransitionDuration =>
      transitionAnimationDuration ?? _defaultAnimationDuration;

  @override
  bool get barrierDismissible => false;

  @override
  final String? barrierLabel;

  @override
  Color get barrierColor => AppTheme.transparentColor;

  @override
  Animation<double>? get animation => controller?.drive(
        CurveTween(curve: Curves.easeInOutQuad),
      );

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
