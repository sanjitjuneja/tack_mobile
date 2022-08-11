part of 'group_details_bloc.dart';

class GroupDetailsState {
  final Group group;
  final GroupInvitation? invitation;
  final GroupsUsersState usersState;

  bool get isInvitation => invitation != null;

  const GroupDetailsState({
    required this.group,
    this.invitation,
    GroupsUsersState? usersState,
  }) : usersState = usersState ?? const GroupsUsersState();

  GroupDetailsState copyWith({
    Group? group,
    GroupsUsersState? usersState,
  }) {
    return GroupDetailsState(
      group: group ?? this.group,
      invitation: invitation,
      usersState: usersState ?? this.usersState,
    );
  }
}
