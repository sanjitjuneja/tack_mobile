part of app_dialog;

class DestructiveDialog {
  static const String routeName = '/destructiveDialog';

  static Page<dynamic> page(
    DestructiveAlert destructiveAlert, {
    ButtonCallback? onDestructiveActionTap,
  }) {
    return _DestructiveDialogPage(
      destructiveAlert: destructiveAlert,
      onDestructiveActionTap: onDestructiveActionTap,
    );
  }
}

class _DestructiveDialogPage extends Page<bool> {
  final DestructiveAlert destructiveAlert;
  final ButtonCallback? onDestructiveActionTap;

  @override
  String get name => AppAlertDialog.routeName;

  const _DestructiveDialogPage({
    required this.destructiveAlert,
    this.onDestructiveActionTap,
  });

  @override
  Route<bool> createRoute(BuildContext context) {
    return DialogRoute<bool>(
      settings: this,
      context: context,
      barrierColor: AppTheme.barrierColor,
      barrierDismissible: true,
      builder: (_) => DestructiveDialogWidget(
        destructiveAlert: destructiveAlert,
        onDestructiveActionTap: onDestructiveActionTap,
      ),
    );
  }
}
