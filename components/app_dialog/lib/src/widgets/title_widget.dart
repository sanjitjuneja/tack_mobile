part of app_dialog;

class TitleWidget extends StatelessWidget {
  final String title;

  const TitleWidget({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return DialogTextWidget(
      content: title,
      textStyle: AppTextTheme.manrope16Bold.copyWith(
        color: AppTheme.textPrimaryColor,
      ),
    );
  }
}
