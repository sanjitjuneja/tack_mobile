part of app_dialog;

class DestructiveDialogWidget extends StatelessWidget {
  final DestructiveAlert destructiveAlert;
  final bool shouldUseDefaultContent;
  final ButtonCallback? onDestructiveActionTap;

  const DestructiveDialogWidget({
    super.key,
    required this.destructiveAlert,
    required this.shouldUseDefaultContent,
    this.onDestructiveActionTap,
  });

  @override
  Widget build(BuildContext context) {
    final _AlertLocalizationMapper mapper = _AlertLocalizationMapper(
      alert: destructiveAlert,
      context: context,
      useDefaultContent: shouldUseDefaultContent,
    );

    final String? title = mapper.title;
    final String? message = mapper.message;
    final String? mainButtonLabel = mapper.mainButtonLabel;
    final String? secondaryButtonLabel = mapper.secondaryButtonLabel;

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
                if (title != null && title.isNotEmpty) ...<Widget>[
                  TitleWidget(title: title),
                  const SizedBox(height: 10),
                ],
                if (message != null && message.isNotEmpty) ...<Widget>[
                  MessageWidget(
                    message: message,
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
                      mainButtonLabel ?? '',
                      style: AppTextTheme.manrope15Regular.copyWith(
                        color: AppTheme.textPrimaryColor,
                      ),
                    ),
                  ),
                ),
                const AppDivider(axis: Axis.vertical),
                Expanded(
                  child: CupertinoButton(
                    onPressed: () => _onNegativeActionTap(context),
                    minSize: 54,
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Text(
                      secondaryButtonLabel ?? '',
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
    AppRouter.of(context).popWithResult(true);
  }

  void _onNegativeActionTap(BuildContext context) {
    AppRouter.of(context).popWithResult(false);
  }
}
