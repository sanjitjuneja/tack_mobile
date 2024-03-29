import 'package:core/core.dart';
import 'package:flutter/widgets.dart';

class OpacityOnTapContainer extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final HapticFeedbackType feedbackType;
  final bool withFeedback;
  final double pressedOpacity;
  final double disabledOpacity;
  final bool disable;

  const OpacityOnTapContainer({
    super.key,
    required this.child,
    this.feedbackType = HapticFeedbackType.heavy,
    this.withFeedback = false,
    this.pressedOpacity = 0.7,
    double? disabledOpacity,
    this.onTap,
    this.onLongPress,
    this.disable = false,
  }) : disabledOpacity = disabledOpacity ?? pressedOpacity;

  @override
  State<OpacityOnTapContainer> createState() => _OpacityOnTapContainerState();
}

class _OpacityOnTapContainerState extends State<OpacityOnTapContainer>
    with SingleTickerProviderStateMixin {
  static const Duration _fadeOutDuration = Duration(milliseconds: 120);
  static const Duration _fadeInDuration = Duration(milliseconds: 180);
  final Tween<double> _opacityTween = Tween<double>(begin: 1.0);

  late AnimationController _animationController;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      value: 0.0,
      vsync: this,
    );
    _opacityAnimation = _animationController
        .drive(CurveTween(curve: Curves.decelerate))
        .drive(_opacityTween);
    _setTween();
  }

  @override
  void didUpdateWidget(OpacityOnTapContainer old) {
    super.didUpdateWidget(old);
    _setTween();
  }

  void _setTween() {
    if (widget.disable) {
      _opacityTween.end = widget.disabledOpacity;
    } else {
      _opacityTween.end = widget.pressedOpacity;
    }

    _animate();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  bool _buttonHeldDown = false;

  void _handleTapDown(TapDownDetails event) {
    if (!_buttonHeldDown) {
      _buttonHeldDown = true;
      _animate();
    }
  }

  void _handleTapUp(TapUpDetails event) {
    if (_buttonHeldDown) {
      _buttonHeldDown = false;
      _animate();
    }
  }

  void _handleTapCancel() {
    if (_buttonHeldDown) {
      _buttonHeldDown = false;
      _animate();
    }
  }

  void _onTap() {
    if (widget.withFeedback) {
      HapticFeedbackManager.feedback(type: widget.feedbackType);
    }
    widget.onTap?.call();
  }

  void _onLongPress() {
    if (widget.withFeedback) {
      HapticFeedbackManager.feedback(type: widget.feedbackType);
    }
    widget.onLongPress?.call();
  }

  void _animate() {
    if (_animationController.isAnimating) return;
    if (widget.onTap == null) return;

    final bool wasHeldDown = _buttonHeldDown;
    final TickerFuture ticker = _buttonHeldDown || widget.disable
        ? _animationController.animateTo(
            1.0,
            duration: _fadeOutDuration,
            curve: Curves.easeInOutCubicEmphasized,
          )
        : _animationController.animateTo(
            0.0,
            duration: _fadeInDuration,
            curve: Curves.easeOutCubic,
          );
    ticker.then<void>((_) {
      if (mounted && wasHeldDown != _buttonHeldDown) _animate();
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isDisabled = widget.disable;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: isDisabled ? null : _handleTapDown,
      onTapUp: isDisabled ? null : _handleTapUp,
      onTapCancel: isDisabled ? null : _handleTapCancel,
      onTap: isDisabled ? null : _onTap,
      onLongPress: isDisabled ? null : _onLongPress,
      child: Semantics(
        button: true,
        child: FadeTransition(
          opacity: _opacityAnimation,
          child: widget.child,
        ),
      ),
    );
  }
}
