part of app_dialog;

class DialogTextWidget extends StatelessWidget {
  final String content;
  final TextAlign? textAlign;
  final TextStyle? textStyle;

  const DialogTextWidget({
    super.key,
    required this.content,
    required this.textStyle,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      content,
      textAlign: textAlign ?? TextAlign.center,
      style: textStyle,
    );
  }
}
