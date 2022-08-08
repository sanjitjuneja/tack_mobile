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

class GroupsChanged extends GlobalEvent {
  final List<Group> groups;

  const GroupsChanged({
    required this.groups,
  });
}

class ChangeGroup extends GlobalEvent {
  const ChangeGroup();
}

class GoToMyInvitations extends GlobalEvent {
  const GoToMyInvitations();
}
