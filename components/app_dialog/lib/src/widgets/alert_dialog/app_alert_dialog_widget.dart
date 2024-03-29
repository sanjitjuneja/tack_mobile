part of app_dialog;

class AppAlertDialogWidget extends StatelessWidget {
  final Alert alert;
  final bool shouldUseDefaultContent;
  final bool showNavigation;

  const AppAlertDialogWidget({
    super.key,
    required this.alert,
    required this.shouldUseDefaultContent,
    required this.showNavigation,
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

    return BaseDialogWidget(
      margin: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Visibility(
                visible: showNavigation,
                replacement: CupertinoButton(
                  minSize: 24,
                  padding: const EdgeInsets.all(10.0),
                  onPressed: () => AppRouter.of(context).popWithResult(false),
                  child: AppImagesTheme.alertBack,
                ),
                child: const SizedBox(height: 44),
              ),
            ],
          ),
          const SizedBox(height: 10),
          alert.image,
          const SizedBox(height: 20),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 42),
              child: SingleChildScrollView(
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
                        highlightColor: alert.color,
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 28),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28.0),
            child: AppCircleButton(
              labelKey: buttonLabel ?? '',
              onTap: () => _onButtonTap(context),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  void _onButtonTap(BuildContext context) {
    GlobalAppRouter.of(context).popWithResult(true);
  }
}
