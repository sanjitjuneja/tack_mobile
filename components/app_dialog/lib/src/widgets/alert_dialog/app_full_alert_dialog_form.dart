part of app_dialog;

class AppFullAlertDialogForm extends StatelessWidget {
  final Alert alert;
  final bool shouldUseDefaultContent;

  const AppFullAlertDialogForm({
    super.key,
    required this.alert,
    required this.shouldUseDefaultContent,
  });

  @override
  Widget build(BuildContext context) {
    final _AlertLocalizationMapper mapper = _AlertLocalizationMapper(
      alert: alert,
      context: context,
      useDefaultContent: shouldUseDefaultContent,
    );

    final String? title = mapper.title;
    final String? message = mapper.message;
    final String? buttonLabel = mapper.mainButtonLabel;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: <Widget>[
          if (title != null && title.isNotEmpty) ...<Widget>[
            Text(
              FlutterI18n.translate(context, title),
              style: AppTextTheme.manrope32Bold.copyWith(
                color: AppTheme.textPrimaryColor,
              ),
            ),
          ],
          const SizedBox(height: 44),
          alert.image,
          const Spacer(flex: 1),
          if (message != null && message.isNotEmpty) ...<Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                FlutterI18n.translate(
                  context,
                  message,
                ),
                textAlign: TextAlign.center,
                style: AppTextTheme.manrope14Medium
                    .copyWith(color: AppTheme.textHintColor),
              ),
            ),
          ],
          const Spacer(flex: 2),
          Row(
            children: <Widget>[
              const Spacer(flex: 1),
              Expanded(
                flex: 5,
                child: AppCircleButton(
                  labelKey: buttonLabel ?? '',
                  onTap: () => GlobalAppRouter.of(context).popWithResult(true),
                ),
              ),
              const Spacer(flex: 1),
            ],
          ),
          const SizedBox(height: 28),
        ],
      ),
    );
  }
}
