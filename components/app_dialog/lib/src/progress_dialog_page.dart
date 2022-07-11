part of app_dialog;

class ProgressDialog {
  static const String routeName = '/progressDialog';

  static Page<void> page({
    String? message,
  }) {
    return _ProgressDialogPage(
      message: message,
    );
  }
}

class _ProgressDialogPage extends Page<void> {
  final String? message;

  @override
  String get name => ProgressDialog.routeName;

  const _ProgressDialogPage({
    this.message,
  });

  @override
  Route<void> createRoute(BuildContext context) {
    return DialogRoute<void>(
      settings: this,
      context: context,
      barrierColor: AppTheme.progressBarrierColor,
      barrierDismissible: false,
      builder: (_) => Material(
        color: AppTheme.transparentColor,
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
