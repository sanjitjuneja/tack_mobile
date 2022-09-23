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
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          systemNavigationBarColor: AppTheme.secondaryBackgroundColor,
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
        child: CupertinoPageScaffold(
          backgroundColor: AppTheme.secondaryBackgroundColor,
          navigationBar: AppNavigationBar(
            backgroundColor: AppTheme.secondaryBackgroundColor,
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
      ),
    );
  }
}
