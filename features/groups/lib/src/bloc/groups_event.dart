part of 'groups_bloc.dart';

abstract class GroupsEvent {
  const GroupsEvent();
}

class AppRefreshAction extends GroupsEvent {
  const AppRefreshAction();
}

class InitialLoad extends GroupsEvent {
  const InitialLoad();
}

class RefreshAction extends GroupsEvent {
  final Completer<RefreshingStatus>? completer;

  const RefreshAction({
    this.completer,
  });
}

class LoadMoreAction extends GroupsEvent {
  final Completer<LoadingStatus> completer;

  const LoadMoreAction({
    required this.completer,
  });
}

class GroupIntentAction extends GroupsEvent {
  final WebSocketIntent<GroupDetails> groupIntent;

  const GroupIntentAction({
    required this.groupIntent,
  });
}
