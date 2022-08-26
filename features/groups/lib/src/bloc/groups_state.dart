part of 'groups_bloc.dart';

class GroupsState {
  final List<GroupDetails> groups;
  final bool isLoading;
  final bool canLoadMore;

  bool get hasData => groups.isNotEmpty;

  const GroupsState({
    List<GroupDetails>? groups,
    this.isLoading = false,
    this.canLoadMore = true,
  }) : groups = groups ?? const <GroupDetails>[];

  GroupsState copyWith({
    List<GroupDetails>? groups,
    bool? isLoading,
    bool? canLoadMore,
  }) {
    return GroupsState(
      groups: groups ?? this.groups,
      isLoading: isLoading ?? false,
      canLoadMore: canLoadMore ?? this.canLoadMore,
    );
  }
}
