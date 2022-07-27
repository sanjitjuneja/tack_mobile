part of app_dialog;

class AppProgressIndicator extends StatelessWidget {
  final String? messageKey;
  final Color? backgroundColor;
  final ProgressIndicatorSize indicatorSize;

  const AppProgressIndicator({
    super.key,
    this.messageKey,
    this.backgroundColor,
    ProgressIndicatorSize? indicatorSize,
  }): indicatorSize = indicatorSize ?? ProgressIndicatorSize.big;

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
              size: indicatorSize.size,
              progressStrokeWidth: indicatorSize.strokeWidth,
              backStrokeWidth: 0,
              progressColor: AppTheme.progressInterfaceColor,
            ),
            if (messageKey != null) ...<Widget>[
              const SizedBox(height: 28),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Text(
                  FlutterI18n.translate(context, messageKey!),
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
