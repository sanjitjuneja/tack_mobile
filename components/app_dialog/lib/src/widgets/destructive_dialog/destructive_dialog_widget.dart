part of app_dialog;

class DestructiveDialogWidget extends StatelessWidget {
  final DestructiveAlert destructiveAlert;
  final ButtonCallback? onDestructiveActionTap;

  const DestructiveDialogWidget({
    super.key,
    required this.destructiveAlert,
    this.onDestructiveActionTap,
  });

  @override
  Widget build(BuildContext context) {
    return BaseDialogWidget(
      margin: const EdgeInsets.all(50.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const SizedBox(height: 30),
          AppImagesTheme.alertError,
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                if (destructiveAlert.title != null) ...<Widget>[
                  TitleWidget(title: destructiveAlert.title!),
                  const SizedBox(height: 10),
                ],
                if (destructiveAlert.message != null) ...<Widget>[
                  MessageWidget(
                    message: destructiveAlert.message!,
                    highlightColor: AppTheme.errorColor,
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 28),
          const AppDivider(),
          IntrinsicHeight(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: CupertinoButton(
                    onPressed: () => _onDestructiveActionTap(context),
                    minSize: 54,
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Text(
                      'Yes',
                      style: AppTextTheme.manrope15Regular.copyWith(
                        color: AppTheme.textPrimaryColor,
                      ),
                    ),
                  ),
                ),
                const AppDivider(axis: Axis.vertical),
                Expanded(
                  child: CupertinoButton(
                    onPressed: Navigator.of(context).pop,
                    minSize: 54,
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Text(
                      'No',
                      style: AppTextTheme.manrope15SemiBold.copyWith(
                        color: AppTheme.buttonInterfaceSecondaryColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _onDestructiveActionTap(BuildContext context) {
    onDestructiveActionTap?.call();
    Navigator.of(context).pop();
  }
}
