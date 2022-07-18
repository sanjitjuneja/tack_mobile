part of 'tacks_bloc.dart';

class TacksState {
  final List<TackerTack> tackerTacks;
  final List<RunnerTack> runnerTacks;

  const TacksState({
    List<TackerTack>? tackerTacks,
    List<RunnerTack>? runnerTacks,
  })  : tackerTacks = tackerTacks ?? const <TackerTack>[],
        runnerTacks = runnerTacks ?? const <RunnerTack>[];

  TacksState copyWith({
    List<TackerTack>? tackerTacks,
    List<RunnerTack>? runnerTacks,
  }) {
    return TacksState(
      tackerTacks: tackerTacks ?? this.tackerTacks,
      runnerTacks: runnerTacks ?? this.runnerTacks,
    );
  }
}
