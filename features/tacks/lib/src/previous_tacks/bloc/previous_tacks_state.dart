part of 'previous_tacks_bloc.dart';

class PreviousTacksState {
  final PaginationModel<Tack> createdTacksData;
  final PaginationModel<Tack> completedTacksData;
  final bool isLoading;

  PreviousTacksState({
    PaginationModel<Tack>? createdTacksData,
    PaginationModel<Tack>? completedTacksData,
    this.isLoading = false,
  })  : createdTacksData = createdTacksData ?? PaginationModel<Tack>.empty(),
        completedTacksData =
            completedTacksData ?? PaginationModel<Tack>.empty();

  PreviousTacksState copyWith({
    PaginationModel<Tack>? createdTacksData,
    PaginationModel<Tack>? completedTacksData,
    bool? isLoading,
  }) {
    return PreviousTacksState(
      createdTacksData: createdTacksData ?? this.createdTacksData,
      completedTacksData: completedTacksData ?? this.completedTacksData,
      isLoading: isLoading ?? false,
    );
  }
}
