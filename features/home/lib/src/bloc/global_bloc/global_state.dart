part of 'global_bloc.dart';

class GlobalState {
  final User user;
  final List<Group> groups;
  final Group? currentGroup;

  bool get canPickOtherGroup => groups.length > 1;

  bool get isGroupSelected => currentGroup != null;

  const GlobalState({
    required this.user,
    required this.groups,
    this.currentGroup,
  });

  GlobalState copyWith({
    User? user,
    List<Group>? groups,
    Group? currentGroup,
  }) {
    return GlobalState(
      user: user ?? this.user,
      groups: groups ?? this.groups,
      currentGroup: currentGroup ?? this.currentGroup,
    );
  }
}
