part of app_dialog;

class ProgressDialog {
  static const String routeName = '/progressDialog';

  static Page<void> page({
    String? messageKey,
  }) {
    return _ProgressDialogPage(
      messageKey: messageKey,
    );
  }
}

class _ProgressDialogPage extends Page<void> {
  final String? messageKey;

  @override
  String get name => ProgressDialog.routeName;

  const _ProgressDialogPage({
    this.messageKey,
  });

  @override
  Route<void> createRoute(BuildContext context) {
    return DialogRoute<void>(
      settings: this,
      context: context,
      barrierColor: AppTheme.progressBarrierColor,
      barrierDismissible: false,
      builder: (_) => AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          systemNavigationBarColor: AppTheme.accentColor,
          systemNavigationBarIconBrightness: Brightness.light,
        ),
        child: WillPopScope(
          onWillPop: () => Future.value(false),
          child: AppProgressIndicator(
            messageKey: messageKey,
            backgroundColor: AppTheme.transparentColor,
          ),
        ),
      ),
    );
  }
}
