part of app_dialog;

class AppAlertDialog {
  static const String routeName = '/alertDialog';

  static Page<dynamic> page(
    Alert alert, {
    bool shouldUseDefaultContent = true,
    ButtonCallback? onButtonTap,
  }) {
    assert(
      alert is! DestructiveAlert,
      'Alert dialog is not working with DestructiveAlert.\nUse DestructiveAlertDialog instead.',
    );

    return _AlertDialogPage(
      alert: alert,
      shouldUseDefaultContent: shouldUseDefaultContent,
      onButtonTap: onButtonTap,
    );
  }
}

class _AlertDialogPage extends Page<bool> {
  final Alert alert;
  final bool shouldUseDefaultContent;
  final ButtonCallback? onButtonTap;

  @override
  String get name => AppAlertDialog.routeName;

  const _AlertDialogPage({
    required this.alert,
    required this.shouldUseDefaultContent,
    this.onButtonTap,
  });

  @override
  Route<bool> createRoute(BuildContext context) {
    return DialogRoute<bool>(
      settings: this,
      context: context,
      barrierColor: AppTheme.barrierColor,
      barrierDismissible: true,
      builder: (_) => AppAlertDialogWidget(
        alert: alert,
        shouldUseDefaultContent: shouldUseDefaultContent,
        onTap: onButtonTap,
      ),
    );
  }
}
