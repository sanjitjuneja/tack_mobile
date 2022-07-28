import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

import 'segment_tab.dart';
import 'utils/custom_clippers.dart';

class SegmentedTabControl<T> extends StatefulWidget
    implements PreferredSizeWidget {
  const SegmentedTabControl({
    Key? key,
    this.height = 46,
    required this.tabs,
    this.initialValue,
    this.onValueChange,
    this.controller,
    this.backgroundColor,
    this.tabTextColor,
    this.textStyle,
    this.selectedTabTextColor,
    this.indicatorColor,
    this.indicatorPadding = EdgeInsets.zero,
    this.tabPadding = const EdgeInsets.symmetric(horizontal: 8),
    this.radius = const Radius.circular(20),
    this.shape = BoxShape.rectangle,
    this.shadow,
    this.border,
    this.splashColor,
    this.splashHighlightColor,
  }) : super(key: key);

  /// Height of the widget.
  ///
  /// [preferredSize] returns this value.
  final double height;

  /// Selection options.
  final Map<T, SegmentTab> tabs;

  final T? initialValue;

  final void Function(T value)? onValueChange;

  /// Can be provided by [DefaultTabController].
  final TabController? controller;

  /// The color of the area beyond the indicator.
  final Color? backgroundColor;

  /// Style of all labels. Color will not applied.
  final TextStyle? textStyle;

  /// The color of the text beyond the indicator.
  final Color? tabTextColor;

  /// The color of the text inside the indicator.
  final Color? selectedTabTextColor;

  /// Color of the indicator.
  final Color? indicatorColor;

  /// Only vertical padding will be applied.
  final EdgeInsets indicatorPadding;

  /// Padding of labels.
  final EdgeInsets tabPadding;

  /// Radius of widget and indicator.
  final Radius radius;

  /// Shape of widget and indicator.
  final BoxShape shape;

  final BoxShadow? shadow;

  final Border? border;

  /// Splash color of options.
  final Color? splashColor;

  /// Splash highlight color of options.
  final Color? splashHighlightColor;

  @override
  State<SegmentedTabControl<T>> createState() => _SegmentedTabControlState<T>();

  @override
  Size get preferredSize => Size.fromHeight(height);
}

class _SegmentedTabControlState<T> extends State<SegmentedTabControl<T>>
    with SingleTickerProviderStateMixin {
  Alignment _currentIndicatorAlignment = Alignment.centerLeft;
  late AnimationController _internalAnimationController;
  late Animation<Alignment> _internalAnimation;
  TabController? _controller;

  bool isChanging = false;

  BorderRadius get borderRadius {
    return BorderRadius.all(radius);
  }

  Radius get radius {
    if (widget.shape == BoxShape.circle) {
      return Radius.circular(
        (widget.height / 2).roundToDouble(),
      );
    } else {
      return widget.radius;
    }
  }

  @override
  void initState() {
    super.initState();
    _internalAnimationController = AnimationController(vsync: this);
    _internalAnimationController.addListener(_handleInternalAnimationTick);
  }

  @override
  void dispose() {
    _internalAnimationController.removeListener(_handleInternalAnimationTick);
    _internalAnimationController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateTabController();
    if (widget.initialValue != null) {
      final int initialIndex = widget.tabs.entries.toList().indexWhere(
            (MapEntry<dynamic, SegmentTab> element) =>
                element.key == widget.initialValue,
          );
      _controller!.index = initialIndex;
    }
  }

  @override
  void didUpdateWidget(SegmentedTabControl<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      _updateTabController();
    }
  }

  bool get _controllerIsValid => _controller?.animation != null;

  void _updateTabController() {
    final TabController? newController =
        widget.controller ?? DefaultTabController.of(context);
    assert(() {
      if (newController == null) {
        throw FlutterError(
          'No TabController for ${widget.runtimeType}.\n'
          'When creating a ${widget.runtimeType}, you must either provide an explicit '
          'TabController using the "controller" property, or you must ensure that there '
          'is a DefaultTabController above the ${widget.runtimeType}.\n'
          'In this case, there was neither an explicit controller nor a default controller.',
        );
      }
      return true;
    }());

    if (newController == _controller) {
      return;
    }

    if (_controllerIsValid) {
      _controller!.animation!.removeListener(_handleTabControllerAnimationTick);
    }
    _controller = newController;
    if (_controller != null) {
      _controller!.animation!.addListener(_handleTabControllerAnimationTick);
    }
  }

  void _handleInternalAnimationTick() {
    setState(() {
      _currentIndicatorAlignment = _internalAnimation.value;
    });
  }

  void _handleTabControllerAnimationTick() {
    final currentValue = _controller!.animation!.value;
    _animateIndicatorTo(_animationValueToAlignment(currentValue));
  }

  void _updateControllerIndex() {
    final int newIndex = _internalIndex;
    if (newIndex == _controller!.index) return;

    _controller!.index = newIndex;
    widget.onValueChange?.call(widget.tabs.entries.toList()[newIndex].key);
  }

  TickerFuture _animateIndicatorToNearest(
      Offset pixelsPerSecond, double width) {
    final nearest = _internalIndex;
    final target = _animationValueToAlignment(nearest.toDouble());
    _internalAnimation = _internalAnimationController.drive(AlignmentTween(
      begin: _currentIndicatorAlignment,
      end: target,
    ));
    final unitsPerSecondX = pixelsPerSecond.dx / width;
    final unitsPerSecond = Offset(unitsPerSecondX, 0);
    final unitVelocity = unitsPerSecond.distance;

    const spring = SpringDescription(
      mass: 30,
      stiffness: 1,
      damping: 1,
    );

    final simulation = SpringSimulation(spring, 0, 1, -unitVelocity);

    return _internalAnimationController.animateWith(simulation);
  }

  TickerFuture _animateIndicatorTo(Alignment target) {
    _internalAnimation = _internalAnimationController.drive(AlignmentTween(
      begin: _currentIndicatorAlignment,
      end: target,
    ));

    return _internalAnimationController.fling();
  }

  Alignment _animationValueToAlignment(double? value) {
    if (value == null) {
      return const Alignment(-1, 0);
    }
    final inPercents = value / (_controller!.length - 1);
    final x = inPercents * 2 - 1;
    return Alignment(x, 0);
  }

  int get _internalIndex => _alignmentToIndex(_currentIndicatorAlignment);

  int _alignmentToIndex(Alignment alignment) {
    final currentPosition =
        (_controller!.length - 1) * _xToPercentsCoefficient(alignment);
    return currentPosition.round();
  }

  /// Converts [Alignment.x] value in range -1..1 to 0..1 percents coefficient
  double _xToPercentsCoefficient(Alignment alignment) {
    return (alignment.x + 1) / 2;
  }

  @override
  Widget build(BuildContext context) {
    final currentTab = widget.tabs.entries.toList()[_internalIndex].value;

    final textStyle =
        widget.textStyle ?? Theme.of(context).textTheme.bodyText2!;

    final selectedTabTextColor = currentTab.selectedTextColor ??
        widget.selectedTabTextColor ??
        Colors.white;

    final tabTextColor = currentTab.textColor ??
        widget.tabTextColor ??
        Colors.white.withOpacity(0.7);

    final backgroundColor = currentTab.backgroundColor ??
        widget.backgroundColor ??
        Theme.of(context).colorScheme.background;

    final indicatorColor = currentTab.color ??
        widget.indicatorColor ??
        Theme.of(context).indicatorColor;

    return DefaultTextStyle(
      style: widget.textStyle ?? DefaultTextStyle.of(context).style,
      child: LayoutBuilder(builder: (context, constraints) {
        final indicatorWidth =
            (constraints.maxWidth - widget.indicatorPadding.horizontal) /
                _controller!.length;

        return SizedBox(
          height: widget.height,
          child: Stack(
            children: <Widget>[
              AnimatedContainer(
                duration: kTabScrollDuration,
                curve: Curves.ease,
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: borderRadius,
                  border: widget.border,
                  boxShadow: widget.shadow != null
                      ? <BoxShadow>[
                          widget.shadow!,
                        ]
                      : null,
                ),
                child: Material(
                  color: Colors.transparent,
                  child: _Labels<T>(
                    borderRadius: borderRadius,
                    splashColor: widget.splashColor,
                    splashHighlightColor: widget.splashHighlightColor,
                    callbackBuilder: _onTabTap(),
                    tabs: widget.tabs,
                    currentIndex: _internalIndex,
                    textStyle: textStyle.copyWith(
                      color: tabTextColor,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: _currentIndicatorAlignment,
                child: GestureDetector(
                  onPanDown: _onPanDown(),
                  onPanUpdate: _onPanUpdate(constraints),
                  onPanEnd: _onPanEnd(constraints),
                  child: AnimatedContainer(
                    duration: kTabScrollDuration,
                    curve: Curves.ease,
                    width: indicatorWidth,
                    height: widget.height - widget.indicatorPadding.vertical,
                    decoration: BoxDecoration(
                      color: indicatorColor,
                      borderRadius: borderRadius,
                      border: Border.all(color: Colors.white),
                    ),
                  ),
                ),
              ),
              ClipPath(
                clipper: RRectRevealClipper(
                  radius: radius,
                  size: Size(
                    indicatorWidth,
                    widget.height - widget.indicatorPadding.vertical,
                  ),
                  offset: Offset(
                    _xToPercentsCoefficient(_currentIndicatorAlignment) *
                        (constraints.maxWidth - indicatorWidth),
                    0,
                  ),
                ),
                child: IgnorePointer(
                  child: _Labels<T>(
                    borderRadius: borderRadius,
                    splashColor: widget.splashColor,
                    splashHighlightColor: widget.splashHighlightColor,
                    tabs: widget.tabs,
                    currentIndex: _internalIndex,
                    textStyle: textStyle.copyWith(
                      color: selectedTabTextColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  VoidCallback Function(int, T)? _onTabTap() {
    if (_controller!.indexIsChanging) {
      return null;
    }
    return (int index, T key) => () {
          if (_controller?.index == index) return;

          widget.onValueChange?.call(key);
          _internalAnimationController.stop();
          _controller!.animateTo(index);
        };
  }

  GestureDragDownCallback? _onPanDown() {
    if (_controller!.indexIsChanging) {
      return null;
    }
    return (details) {
      setState(() => isChanging = false);
      _internalAnimationController.stop();
    };
  }

  GestureDragUpdateCallback? _onPanUpdate(BoxConstraints constraints) {
    if (_controller!.indexIsChanging) {
      return null;
    }
    return (details) {
      double x = _currentIndicatorAlignment.x +
          details.delta.dx / (constraints.maxWidth / 2);
      x = x.clamp(-1, 1);

      setState(() {
        _currentIndicatorAlignment = Alignment(x, 0);
      });
    };
  }

  GestureDragEndCallback _onPanEnd(BoxConstraints constraints) {
    return (details) {
      setState(() => isChanging = false);
      _animateIndicatorToNearest(
        details.velocity.pixelsPerSecond,
        constraints.maxWidth,
      );
      _updateControllerIndex();
    };
  }
}

class _Labels<T> extends StatelessWidget {
  const _Labels({
    this.callbackBuilder,
    required this.tabs,
    required this.currentIndex,
    required this.textStyle,
    required this.borderRadius,
    this.splashColor,
    this.splashHighlightColor,
  });

  final VoidCallback Function(int index, T key)? callbackBuilder;
  final Map<T, SegmentTab> tabs;
  final int currentIndex;
  final TextStyle textStyle;
  final BorderRadius borderRadius;
  final Color? splashColor;
  final Color? splashHighlightColor;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Row(
        children: List.generate(
          tabs.length,
          (index) {
            final MapEntry<T, SegmentTab> tabEntry =
                tabs.entries.toList()[index];
            final SegmentTab tab = tabEntry.value;

            return Expanded(
              child: InkWell(
                splashColor: tab.splashColor ?? splashColor,
                highlightColor:
                    tab.splashHighlightColor ?? splashHighlightColor,
                borderRadius: borderRadius,
                onTap: callbackBuilder?.call(index, tabEntry.key),
                child: Center(
                  child: AnimatedDefaultTextStyle(
                    duration: kTabScrollDuration,
                    curve: Curves.ease,
                    style: textStyle,
                    child: Text(
                      tab.label,
                      overflow: TextOverflow.clip,
                      maxLines: 1,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
