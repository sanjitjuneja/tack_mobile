part of 'tacks_bloc.dart';

class TacksState {
  final TackerTacksState tackerTacksData;
  final RunnerTacksState runnerTacksData;

  const TacksState({
    TackerTacksState? tackerTacksData,
    RunnerTacksState? runnerTacksData,
  })  : tackerTacksData =
            tackerTacksData ?? const TackerTacksState(isLoading: true),
        runnerTacksData =
            runnerTacksData ?? const RunnerTacksState(isLoading: true);

  TacksState copyWith({
    TackerTacksState? tackerTacksData,
    RunnerTacksState? runnerTacksData,
    bool? isLoading,
  }) {
    return TacksState(
      tackerTacksData: tackerTacksData ?? this.tackerTacksData,
      runnerTacksData: runnerTacksData ?? this.runnerTacksData,
    );
  }
}
