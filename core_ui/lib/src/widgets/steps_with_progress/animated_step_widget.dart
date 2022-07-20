part of steps_with_progress;

class AnimatedStepWidget extends AnimatedWidget {
  final double height;

  const AnimatedStepWidget({
    super.key,
    required super.listenable,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable as Animation<double>;
    final double progressValue = animation.value.clamp(0, 1);
    final double opacity = (animation.value - 1).clamp(0, 0.5) * 2;

    return LinearProgressIndicator(
      minHeight: height,
      value: progressValue,
      color: AppColors.fern.withOpacity(1 - opacity),
      backgroundColor: AppColors.white,
    );
  }
}