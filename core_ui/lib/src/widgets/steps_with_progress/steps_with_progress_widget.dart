part of steps_with_progress;

class StepsWithProgressWidget extends StatefulWidget {
  final int stepsCount;
  final int currentStep;
  final double height;
  final double spacing;
  final Duration animationDuration;

  const StepsWithProgressWidget({
    super.key,
    required this.stepsCount,
    required this.currentStep,
    this.height = 5,
    this.spacing = 8,
    this.animationDuration = const Duration(milliseconds: 1500),
  });

  @override
  State<StepsWithProgressWidget> createState() =>
      _StepsWithProgressWidgetState();
}

class _StepsWithProgressWidgetState extends State<StepsWithProgressWidget>
    with TickerProviderStateMixin {
  static const double _animationStart = 0.0;
  static const double _opacityAnimationStart = 1.0;
  static const double _animationEnd = 1.5;

  late AnimationController _animationController;
  late Tween<double> _animationTween;
  late Animation<double> _animation;

  late int _stepsCount;
  late int _stepsWithDividerCount;
  late int _currentStep;
  late int _actualCurrentStepIndex;

  @override
  void initState() {
    _setSteps();
    _setAnimation();

    super.initState();
  }

  @override
  void didUpdateWidget(StepsWithProgressWidget oldWidget) {
    if (widget.currentStep != oldWidget.currentStep) {
      _animationTween.end = _opacityAnimationStart;
      _animationController.forward();
      _animationController.addStatusListener(_animationStatusListener);
    } else if (widget.stepsCount != oldWidget.stepsCount) {
      _setSteps();
    } else if (widget.animationDuration != oldWidget.animationDuration) {
      _animationController.stop();
      _animationController.dispose();
      _setAnimation();
    }

    super.didUpdateWidget(oldWidget);
  }

  void _setSteps() {
    _stepsCount = widget.stepsCount;
    _stepsWithDividerCount = _stepsCount * 2 - 1;
    _currentStep = math.min(widget.currentStep, _stepsCount);
    _actualCurrentStepIndex = (_currentStep - 1) * 2;
  }

  void _setAnimation() {
    _animationController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );
    _animationTween = Tween<double>(
      begin: _animationStart,
      end: _animationEnd,
    );
    _animation = _animationController.drive(_animationTween);
    _animationController.repeat();
  }

  void _animationStatusListener(AnimationStatus status) {
    if (status == AnimationStatus.completed && mounted) {
      setState(_setSteps);
      _animationTween.end = _animationEnd;
      _animationController.repeat();
      _animationController.removeStatusListener(_animationStatusListener);
    }
  }

  bool _isDivider(int index) => index % 2 == 1;

  bool _isCurrentStep(int index) => index == _actualCurrentStepIndex;

  bool _isStepComplete(int index) => index < _actualCurrentStepIndex;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: Row(
        children: List<Widget>.generate(
          _stepsWithDividerCount,
          (int index) {
            if (_isDivider(index)) return SizedBox(width: widget.spacing);

            final Widget child;
            if (_isCurrentStep(index)) {
              child = AnimatedStepWidget(
                listenable: _animation,
                height: widget.height,
              );
            } else {
              child = StaticStepWidget(
                isStepComplete: _isStepComplete(index),
              );
            }

            return Expanded(child: child);
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();

    super.dispose();
  }
}
