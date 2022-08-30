import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:navigation/navigation.dart';

import '../theme/app_theme.dart';

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
                delegate: _LeftSlideRouteLayout(animationValue),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: child ?? const SizedBox.shrink(),
                    ),
                    route.rightBorderWidget ?? const SizedBox.shrink(),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class LeftSlideRoute<T> extends PopupRoute<T> {
  static const Duration _defaultAnimationDuration = Duration(milliseconds: 300);

  LeftSlideRoute({
    required this.builder,
    this.rightBorderWidget,
    this.barrierLabel,
    Color? modalBarrierColor,
    this.isDismissible = true,
    RouteSettings? settings,
  })  : modalBarrierColor = modalBarrierColor ?? AppTheme.barrierColor,
        super(settings: settings);

  final WidgetBuilder? builder;
  final Widget? rightBorderWidget;
  final Color modalBarrierColor;
  final bool isDismissible;

  @override
  Duration get transitionDuration => _defaultAnimationDuration;

  @override
  Duration get reverseTransitionDuration => _defaultAnimationDuration;

  @override
  bool get barrierDismissible => false;

  @override
  final String? barrierLabel;

  @override
  Color get barrierColor => AppTheme.barrierColor;

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
    return _LeftSlideRouteBody<T>(
      route: this,
    );
  }
}
