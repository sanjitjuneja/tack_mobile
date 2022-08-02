part of 'dashboard_bloc.dart';

class DashboardState {
  final Group group;
  final List<Tack> tacks;
  final bool isLoading;
  final bool canLoadMore;

  bool get hasData => tacks.isNotEmpty;

  const DashboardState({
    required this.group,
    List<Tack>? tacks,
    this.isLoading = false,
    this.canLoadMore = true,
  }) : tacks = tacks ?? const <Tack>[];

  DashboardState copyWith({
    List<Tack>? tacks,
    bool? isLoading,
    bool? canLoadMore,
  }) {
    return DashboardState(
      group: group,
      tacks: tacks ?? this.tacks,
      isLoading: isLoading ?? false,
      canLoadMore: canLoadMore ?? this.canLoadMore,
    );
  }
}
