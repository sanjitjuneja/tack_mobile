part of app_dialog;

class DestructiveDialog {
  static const String routeName = '/destructiveDialog';

  static Page<dynamic> page(
    DestructiveAlert destructiveAlert, {
    ButtonCallback? onDestructiveActionTap,
  }) =>
      DestructiveDialogPage(
        destructiveAlert: destructiveAlert,
        onDestructiveActionTap: onDestructiveActionTap,
      );
}

class DestructiveDialogPage extends Page<bool> {
  final DestructiveAlert destructiveAlert;
  final ButtonCallback? onDestructiveActionTap;

  @override
  String get name => AppAlertDialog.routeName;

  const DestructiveDialogPage({
    required this.destructiveAlert,
    this.onDestructiveActionTap,
  });

  @override
  Route<bool> createRoute(BuildContext context) {
    return DialogRoute<bool>(
      settings: this,
      context: context,
      barrierDismissible: true,
      builder: (_) => DestructiveDialogWidget(
        destructiveAlert: destructiveAlert,
        onDestructiveActionTap: onDestructiveActionTap,
      ),
    );
  }
}
