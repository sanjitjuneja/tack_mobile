part of 'group_details_bloc.dart';

class GroupDetailsState {
  final GroupDetails? groupDetails;
  final GroupInvitation? invitation;
  final GroupsUsersState usersState;

  bool get isInvitation => invitation != null;

  Group get group => groupDetails?.group ?? invitation!.group;

  const GroupDetailsState({
    required this.groupDetails,
    required this.invitation,
    GroupsUsersState? usersState,
  }) : usersState = usersState ?? const GroupsUsersState();

  GroupDetailsState copyWith({
    GroupDetails? groupDetails,
    GroupsUsersState? usersState,
  }) {
    return GroupDetailsState(
      groupDetails: groupDetails ?? this.groupDetails,
      invitation: invitation,
      usersState: usersState ?? this.usersState,
    );
  }
}
