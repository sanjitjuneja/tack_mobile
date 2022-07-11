import 'package:flutter/widgets.dart';

class OpacityOnTapContainer extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final double? pressedOpacity;
  final double disabledOpacity;
  final bool disable;

  const OpacityOnTapContainer({
    super.key,
    required this.child,
    this.pressedOpacity = 0.7,
    this.disabledOpacity = 1,
    this.onTap,
    this.disable = false,
  });

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
      _opacityTween.begin = widget.disabledOpacity;
    }
    _opacityTween.end = widget.pressedOpacity ?? 1.0;

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

  void _animate() {
    if (_animationController.isAnimating) return;

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
      onTap: isDisabled ? null : widget.onTap,
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
