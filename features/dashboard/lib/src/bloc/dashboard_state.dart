part of 'dashboard_bloc.dart';

class DashboardState {
  final List<Tack> tacks;

  const DashboardState({
    required this.tacks,
  });

  DashboardState copyWith({
    List<Tack>? tacks,
  }) {
    return DashboardState(
      tacks: tacks ?? this.tacks,
    );
  }
}
