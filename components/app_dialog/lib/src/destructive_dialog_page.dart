part of app_dialog;

class DestructiveDialog {
  static const String routeName = '/destructiveDialog';

  static Page<bool> page(
    DestructiveAlert destructiveAlert, {
    bool shouldUseDefaultContent = true,
    ButtonCallback? onDestructiveActionTap,
  }) {
    return _DestructiveDialogPage(
      destructiveAlert: destructiveAlert,
      shouldUseDefaultContent: shouldUseDefaultContent,
      onDestructiveActionTap: onDestructiveActionTap,
    );
  }
}

class _DestructiveDialogPage extends Page<bool> {
  final DestructiveAlert destructiveAlert;
  final bool shouldUseDefaultContent;
  final ButtonCallback? onDestructiveActionTap;

  @override
  String get name => AppAlertDialog.routeName;

  const _DestructiveDialogPage({
    required this.destructiveAlert,
    required this.shouldUseDefaultContent,
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
        shouldUseDefaultContent: shouldUseDefaultContent,
        onDestructiveActionTap: onDestructiveActionTap,
      ),
    );
  }
}
