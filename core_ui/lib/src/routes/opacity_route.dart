import 'package:flutter/cupertino.dart';

class OpacityRoute<T> extends PageRoute<T> {
  static const Duration _defaultAnimationDuration = Duration(milliseconds: 500);

  final WidgetBuilder builder;

  OpacityRoute({
    super.settings,
    required this.builder,
  });

  @override
  Duration get transitionDuration => _defaultAnimationDuration;

  @override
  Color? get barrierColor => null;

  @override
  String? get barrierLabel => null;

  @override
  bool get maintainState => true;

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
    return FadeTransition(
      opacity: animation,
      child: builder(context),
    );
  }
}
