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
      builder: (_) => AppProgressIndicator(
        message: message,
        backgroundColor: AppTheme.transparentColor,
      ),
    );
  }
}
