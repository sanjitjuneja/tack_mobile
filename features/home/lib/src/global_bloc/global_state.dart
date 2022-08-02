part of 'global_bloc.dart';

class GlobalState {
  final UserModel user;
  final List<Group> groups;
  final Group? currentGroup;

  bool get isGroupSelected => currentGroup != null;

  const GlobalState({
    required this.user,
    required this.groups,
    this.currentGroup,
  });

  GlobalState copyWith({
    UserModel? user,
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
