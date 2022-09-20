part of app_dialog;

class AppAlertDialog {
  static const String routeName = '/alertDialog';

  /// [showNavigation]
  /// Full Dialog - Displaying/removing navigation within navigation bar.
  /// Dialog - Displaying/removing navigation Cross icon.
  static Page<bool> page(
    Alert alert, {
    bool shouldUseDefaultContent = true,
    bool fullScreen = false,
    bool showNavigation = true,
  }) {
    assert(
      alert is! DestructiveAlert,
      'Alert dialog is not working with DestructiveAlert.\nUse DestructiveAlertDialog instead.',
    );

    return _AlertDialogPage(
      alert: alert,
      shouldUseDefaultContent: shouldUseDefaultContent,
      fullScreen: fullScreen,
      showNavigation: showNavigation,
    );
  }
}

class _AlertDialogPage extends Page<bool> {
  final Alert alert;
  final bool shouldUseDefaultContent;
  final bool fullScreen;
  final bool showNavigation;

  @override
  String get name => AppAlertDialog.routeName;

  const _AlertDialogPage({
    required this.alert,
    required this.shouldUseDefaultContent,
    required this.fullScreen,
    required this.showNavigation,
  });

  @override
  Route<bool> createRoute(BuildContext context) {
    if (fullScreen) {
      return CupertinoPageRoute<bool>(
        builder: (_) {
          return AppFullAlertDialogScreen(
            alert: alert,
            shouldUseDefaultContent: shouldUseDefaultContent,
            showNavigation: showNavigation,
          );
        },
        settings: this,
      );
    } else {
      return DialogRoute<bool>(
        settings: this,
        context: context,
        barrierColor: AppTheme.transparentColor,
        useSafeArea: false,
        barrierDismissible: false,
        builder: (_) => GestureDetector(
          onTap: () => GlobalAppRouter.of(context).popWithResult(false),
          child: Container(
            color: AppTheme.barrierColor,
            child: Center(
              child: AppAlertDialogWidget(
                alert: alert,
                shouldUseDefaultContent: shouldUseDefaultContent,
                showNavigation: showNavigation,
              ),
            ),
          ),
        ),
      );
    }
  }
}
