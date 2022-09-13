part of 'global_bloc.dart';

class GlobalState {
  final User user;
  final int groupsCount;
  final Group? currentGroup;

  bool get canPickOtherGroup => groupsCount > 1;

  bool get isGroupSelected => currentGroup != null;

  const GlobalState({
    required this.user,
    required this.groupsCount,
    this.currentGroup,
  });

  GlobalState copyWith({
    User? user,
    int? groupsCount,
    Optional<Group?>? currentGroup,
  }) {
    return GlobalState(
      user: user ?? this.user,
      groupsCount: groupsCount ?? this.groupsCount,
      currentGroup:
          currentGroup == null ? this.currentGroup : currentGroup.value,
    );
  }
}
