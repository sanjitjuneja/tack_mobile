part of 'global_bloc.dart';

abstract class GlobalEvent {
  const GlobalEvent();
}

class UserChanged extends GlobalEvent {
  final User user;

  const UserChanged({
    required this.user,
  });
}

class CurrentGroupChanged extends GlobalEvent {
  final Group? group;

  const CurrentGroupChanged({
    required this.group,
  });
}

class GroupsCountChanged extends GlobalEvent {
  final int groupsCount;

  const GroupsCountChanged({
    required this.groupsCount,
  });
}

class ChangeGroup extends GlobalEvent {
  const ChangeGroup();
}

class GoToMyInvitations extends GlobalEvent {
  const GoToMyInvitations();
}

class GoToMyGroups extends GlobalEvent {
  const GoToMyGroups();
}
