part of 'group_details_bloc.dart';

class GroupDetailsState {
  final GroupDetails? groupDetails;
  final GroupInvitation? invitation;
  final PaginationModel<TackUser> membersData;
  final bool isLoading;

  bool get isInvitation => invitation != null;

  Group get group => groupDetails?.group ?? invitation!.group;

  GroupDetailsState({
    required this.groupDetails,
    required this.invitation,
    PaginationModel<TackUser>? membersData,
    this.isLoading = false,
  }) : membersData = membersData ?? PaginationModel<TackUser>.empty();

  GroupDetailsState copyWith({
    GroupDetails? groupDetails,
    PaginationModel<TackUser>? membersData,
    bool? isLoading,
  }) {
    return GroupDetailsState(
      groupDetails: groupDetails ?? this.groupDetails,
      invitation: invitation,
      membersData: membersData ?? this.membersData,
      isLoading: isLoading ?? false,
    );
  }
}
