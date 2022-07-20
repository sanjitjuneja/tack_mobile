part of steps_with_progress;

class StaticStepWidget extends StatelessWidget {
  final bool isStepComplete;

  const StaticStepWidget({
    super.key,
    required this.isStepComplete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isStepComplete ? AppColors.fern : AppColors.white,
      ),
    );
  }
}
