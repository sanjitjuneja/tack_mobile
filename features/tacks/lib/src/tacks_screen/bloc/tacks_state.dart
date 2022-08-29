part of 'tacks_bloc.dart';

class TacksState {
  final PaginationModel<Tack> tackerTacksData;
  final PaginationModel<RunnerTack> runnerTacksData;
  final bool isLoading;

  TacksState({
    PaginationModel<Tack>? tackerTacksData,
    PaginationModel<RunnerTack>? runnerTacksData,
    this.isLoading = false,
  })  : tackerTacksData = tackerTacksData ?? PaginationModel<Tack>.empty(),
        runnerTacksData =
            runnerTacksData ?? PaginationModel<RunnerTack>.empty();

  TacksState copyWith({
    PaginationModel<Tack>? tackerTacksData,
    PaginationModel<RunnerTack>? runnerTacksData,
    bool? isLoading,
  }) {
    return TacksState(
      tackerTacksData: tackerTacksData ?? this.tackerTacksData,
      runnerTacksData: runnerTacksData ?? this.runnerTacksData,
      isLoading: isLoading ?? false,
    );
  }
}
