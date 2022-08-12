part of 'my_groups_bloc.dart';

abstract class MyGroupsEvent {
  const MyGroupsEvent();
}

class OpenGroupDetails extends MyGroupsEvent {
  final Group group;

  const OpenGroupDetails({
    required this.group,
  });
}

class InviteMembers extends MyGroupsEvent {
  final Group group;

  const InviteMembers({
    required this.group,
  });
}

class OpenMyInvitations extends MyGroupsEvent {}

class CreateGroup extends MyGroupsEvent {}
