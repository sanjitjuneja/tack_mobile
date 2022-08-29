part of 'groups_bloc.dart';

class GroupsState {
  final PaginationModel<GroupDetails> groupsData;
  final bool isLoading;

  GroupsState({
    this.isLoading = false,
    PaginationModel<GroupDetails>? groupsData,
  }) : groupsData = groupsData ?? PaginationModel<GroupDetails>.empty();

  GroupsState copyWith({
    PaginationModel<GroupDetails>? groupsData,
    bool? isLoading,
  }) {
    return GroupsState(
      groupsData: groupsData ?? this.groupsData,
      isLoading: isLoading ?? false,
    );
  }
}
