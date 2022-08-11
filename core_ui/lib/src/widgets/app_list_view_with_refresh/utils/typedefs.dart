part of app_list_view_with_refresh;

typedef LoadCallback = void Function(BuildContext, Completer<LoadingStatus>);
typedef RefreshCallback = void Function(BuildContext, Completer<RefreshingStatus>);
