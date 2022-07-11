part of 'dashboard_bloc.dart';

class DashboardState {
  final List<Group> groups;
  final Group currentGroup;
  final List<TackModel> tacks;

  const DashboardState({
    required this.groups,
    required this.currentGroup,
    required this.tacks,
  });

  DashboardState copyWith({
    List<Group>? groups,
    Group? currentGroup,
    List<TackModel>? tacks,
  }) {
    return DashboardState(
      groups: groups ?? this.groups,
      currentGroup: currentGroup ?? this.currentGroup,
      tacks: tacks ?? this.tacks,
    );
  }
}
