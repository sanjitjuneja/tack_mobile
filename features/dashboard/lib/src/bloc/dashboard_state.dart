part of 'dashboard_bloc.dart';

class DashboardState {
  final Group group;
  final PaginationModel<GroupTack> tacksData;
  final bool isLoading;

  DashboardState({
    required this.group,
    this.isLoading = false,
    PaginationModel<GroupTack>? tacksData,
  }) : tacksData = tacksData ?? PaginationModel<GroupTack>.empty();

  DashboardState copyWith({
    PaginationModel<GroupTack>? tacksData,
    bool? isLoading,
  }) {
    return DashboardState(
      group: group,
      tacksData: tacksData ?? this.tacksData,
      isLoading: isLoading ?? false,
    );
  }
}
