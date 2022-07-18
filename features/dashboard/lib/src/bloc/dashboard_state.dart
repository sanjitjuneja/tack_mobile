part of 'dashboard_bloc.dart';

class DashboardState {
  final List<TackModel> tacks;

  const DashboardState({
    required this.tacks,
  });

  DashboardState copyWith({
    List<TackModel>? tacks,
  }) {
    return DashboardState(
      tacks: tacks ?? this.tacks,
    );
  }
}
