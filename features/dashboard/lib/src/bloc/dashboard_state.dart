part of 'dashboard_bloc.dart';

class DashboardState {
  final Group group;
  final PaginationModel<Tack> tacksData;
  final bool isLoading;

  DashboardState({
    required this.group,
    this.isLoading = false,
    PaginationModel<Tack>? tacksData,
  }) : tacksData = tacksData ?? PaginationModel<Tack>.empty();

  DashboardState copyWith({
    PaginationModel<Tack>? tacksData,
    bool? isLoading,
  }) {
    return DashboardState(
      group: group,
      tacksData: tacksData ?? this.tacksData,
      isLoading: isLoading ?? false,
    );
  }
}