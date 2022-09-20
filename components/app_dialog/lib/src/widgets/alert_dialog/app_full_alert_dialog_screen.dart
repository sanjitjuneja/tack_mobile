part of app_dialog;

class AppFullAlertDialogScreen extends StatelessWidget {
  final Alert alert;
  final bool shouldUseDefaultContent;
  final bool showNavigation;

  const AppFullAlertDialogScreen({
    super.key,
    required this.alert,
    required this.shouldUseDefaultContent,
    required this.showNavigation,
  });

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: showNavigation ? null : () => Future<bool>.value(false),
      child: CupertinoPageScaffold(
        backgroundColor: AppTheme.primaryColor,
        navigationBar: AppNavigationBar(
          backgroundColor: AppTheme.primaryColor,
          leading: showNavigation
              ? AppBackButton(
                  onPressed: () =>
                      GlobalAppRouter.of(context).popWithResult(false),
                )
              : null,
        ),
        child: SafeArea(
          child: AppFullAlertDialogForm(
            alert: alert,
            shouldUseDefaultContent: shouldUseDefaultContent,
          ),
        ),
      ),
    );
  }
}
