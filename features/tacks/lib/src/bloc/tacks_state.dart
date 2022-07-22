part of 'tacks_bloc.dart';

class TacksState {
  final List<Tack> tackerTacks;
  final List<RunnerTack> runnerTacks;

  const TacksState({
    List<Tack>? tackerTacks,
    List<RunnerTack>? runnerTacks,
  })  : tackerTacks = tackerTacks ?? const <Tack>[],
        runnerTacks = runnerTacks ?? const <RunnerTack>[];

  TacksState copyWith({
    List<Tack>? tackerTacks,
    List<RunnerTack>? runnerTacks,
  }) {
    return TacksState(
      tackerTacks: tackerTacks ?? this.tackerTacks,
      runnerTacks: runnerTacks ?? this.runnerTacks,
    );
  }
}
