part of 'group_details_bloc.dart';

abstract class GroupDetailsEvent {
  const GroupDetailsEvent();
}

class InitialLoad extends GroupDetailsEvent {
  const InitialLoad();
}

class RefreshAction extends GroupDetailsEvent {
  final Completer<RefreshingStatus>? completer;

  const RefreshAction({
    this.completer,
  });
}

class LoadMoreAction extends GroupDetailsEvent {
  final Completer<LoadingStatus> completer;

  const LoadMoreAction({
    required this.completer,
  });
}

class JoinGroup extends GroupDetailsEvent {
  const JoinGroup();
}

class DeclineInvitation extends GroupDetailsEvent {
  const DeclineInvitation();
}

class LeaveGroup extends GroupDetailsEvent {
  const LeaveGroup();
}

class ChangeNotificationsSettings extends GroupDetailsEvent {
  const ChangeNotificationsSettings();
}

class InviteMembers extends GroupDetailsEvent {
  const InviteMembers();
}
