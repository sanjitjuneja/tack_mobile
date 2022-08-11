part of 'groups_bloc.dart';

abstract class GroupsEvent {
  const GroupsEvent();
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

class OpenGroupDetails extends GroupsEvent {
  final Group group;

  const OpenGroupDetails({
    required this.group,
  });
}

class InviteMembers extends GroupsEvent {
  final Group group;

  const InviteMembers({
    required this.group,
  });
}

class OpenMyInvitations extends GroupsEvent {}

class CreateGroup extends GroupsEvent {}
