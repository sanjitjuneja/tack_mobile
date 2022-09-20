part of app_refresh_widgets;

typedef LoadCallback = void Function(BuildContext, Completer<LoadingStatus>);
typedef RefreshCallback = void Function(BuildContext, Completer<RefreshingStatus>);
