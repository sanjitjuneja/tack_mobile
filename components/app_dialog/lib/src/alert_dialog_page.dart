part of app_dialog;

class AppAlertDialog {
  static const String routeName = '/alertDialog';

  static Page<dynamic> page(
    Alert alert, {
    ButtonCallback? onButtonTap,
  }) =>
      AlertDialogPage(
        alert: alert,
        onButtonTap: onButtonTap,
      );
}

class AlertDialogPage extends Page<bool> {
  final Alert alert;
  final ButtonCallback? onButtonTap;

  @override
  String get name => AppAlertDialog.routeName;

  const AlertDialogPage({
    required this.alert,
    this.onButtonTap,
  });

  @override
  Route<bool> createRoute(BuildContext context) {
    return DialogRoute<bool>(
      settings: this,
      context: context,
      barrierDismissible: true,
      builder: (_) => AppAlertDialogWidget(
        alert: alert,
        onTap: onButtonTap,
      ),
    );
  }
}
