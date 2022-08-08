import 'package:domain/domain.dart';

class RunnerTacksState {
  final List<RunnerTack> tacks;
  final bool isLoading;
  final bool canLoadMore;

  bool get hasData => tacks.isNotEmpty;

  const RunnerTacksState({
    List<RunnerTack>? tacks,
    this.isLoading = false,
    this.canLoadMore = true,
  }) : tacks = tacks ?? const <RunnerTack>[];

  RunnerTacksState copyWith({
    List<RunnerTack>? tacks,
    bool? isLoading,
    bool? canLoadMore,
  }) {
    return RunnerTacksState(
      tacks: tacks ?? this.tacks,
      isLoading: isLoading ?? false,
      canLoadMore: canLoadMore ?? this.canLoadMore,
    );
  }
}
