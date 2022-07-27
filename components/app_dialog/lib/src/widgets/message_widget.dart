part of app_dialog;

class MessageWidget extends StatelessWidget {
  final String message;
  final Color highlightColor;

  const MessageWidget({
    super.key,
    required this.message,
    required this.highlightColor,
  });

  @override
  Widget build(BuildContext context) {
    return TextWithHighlight(
      text: message,
      coloredTextColor: highlightColor,
      textAlign: TextAlign.center,
      textStyle: AppTextTheme.manrope16Regular.copyWith(
        color: AppTheme.textPrimaryColor,
        height: 1.6,
      ),
    );
  }
}
