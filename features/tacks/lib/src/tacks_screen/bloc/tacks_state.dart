part of 'tacks_bloc.dart';

class TacksState {
  final TackerTacksState tackerTacksState;
  final RunnerTacksState runnerTacksState;

  const TacksState({
    TackerTacksState? tackerTacksState,
    RunnerTacksState? runnerTacksState,
  })  : tackerTacksState = tackerTacksState ?? const TackerTacksState(),
        runnerTacksState = runnerTacksState ?? const RunnerTacksState();

  TacksState copyWith({
    TackerTacksState? tackerTacksState,
    RunnerTacksState? runnerTacksState,
  }) {
    return TacksState(
      tackerTacksState: tackerTacksState ?? this.tackerTacksState,
      runnerTacksState: runnerTacksState ?? this.runnerTacksState,
    );
  }
}
