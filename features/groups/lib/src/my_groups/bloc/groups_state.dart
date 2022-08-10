part of 'groups_bloc.dart';

class GroupsState {
  final List<Group> groups;
  final bool isLoading;
  final bool canLoadMore;

  bool get hasData => groups.isNotEmpty;

  const GroupsState({
    List<Group>? groups,
    this.isLoading = false,
    this.canLoadMore = true,
  }) : groups = groups ?? const <Group>[];

  GroupsState copyWith({
    List<Group>? groups,
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
