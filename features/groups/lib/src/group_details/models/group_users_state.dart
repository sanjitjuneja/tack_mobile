import 'package:domain/domain.dart';

class GroupsUsersState {
  final List<TackUser> members;
  final bool isLoading;
  final bool canLoadMore;

  bool get hasData => members.isNotEmpty;

  const GroupsUsersState({
    List<TackUser>? members,
    this.isLoading = false,
    this.canLoadMore = true,
  }) : members = members ?? const <TackUser>[];

  GroupsUsersState copyWith({
    List<TackUser>? members,
    bool? isLoading,
    bool? canLoadMore,
  }) {
    return GroupsUsersState(
      members: members ?? this.members,
      isLoading: isLoading ?? false,
      canLoadMore: canLoadMore ?? this.canLoadMore,
    );
  }
}
