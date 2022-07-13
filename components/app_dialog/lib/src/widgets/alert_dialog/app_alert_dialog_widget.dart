part of app_dialog;

class AppAlertDialogWidget extends StatelessWidget {
  final Alert alert;
  final ButtonCallback? onTap;

  const AppAlertDialogWidget({
    super.key,
    required this.alert,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
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
                visible: onTap == null,
                replacement: CupertinoButton(
                  minSize: 24,
                  padding: const EdgeInsets.all(10.0),
                  onPressed: Navigator.of(context).pop,
                  child: AppImagesTheme.alertBack,
                ),
                child: const SizedBox(height: 44),
              ),
            ],
          ),
          const SizedBox(height: 10),
          alert.image,
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 42),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                if (alert.title != null) ...<Widget>[
                  TitleWidget(title: alert.title!),
                  const SizedBox(height: 10),
                ],
                if (alert.message != null) ...<Widget>[
                  MessageWidget(
                    message: alert.message!,
                    highlightColor: alert.color,
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 28),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28.0),
            child: AppCircleButton(
              labelKey: alert.buttonLabel,
              onTap: () => _onButtonTap(context),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  void _onButtonTap(BuildContext context) {
    onTap?.call();
    Navigator.of(context).pop();
  }
}
