part of app_dialog;

class AppProgressIndicator extends StatelessWidget {
  final String? message;
  final Color? backgroundColor;

  const AppProgressIndicator({
    super.key,
    this.message,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
        width: double.infinity,
        color: backgroundColor ?? AppTheme.barrierColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircularProgressBar(
              size: 80,
              progressStrokeWidth: 11,
              backStrokeWidth: 0,
              progressColor: AppTheme.progressInterfaceColor,
            ),
            if (message != null) ...<Widget>[
              const SizedBox(height: 28),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Text(
                  message!,
                  textAlign: TextAlign.center,
                  style: AppTextTheme.manrope18Medium
                      .copyWith(color: AppTheme.progressInterfaceColor),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
