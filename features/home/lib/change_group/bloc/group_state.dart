part of 'group_bloc.dart';

class GroupState {
  final List<Group> groups;
  final Group currentGroup;

  const GroupState({
    required this.groups,
    required this.currentGroup,
  });

  GroupState copyWith({
    List<Group>? groups,
    Group? currentGroup,
  }) {
    return GroupState(
      groups: groups ?? this.groups,
      currentGroup: currentGroup ?? this.currentGroup,
    );
  }
}
