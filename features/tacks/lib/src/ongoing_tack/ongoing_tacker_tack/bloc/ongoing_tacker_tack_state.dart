part of 'ongoing_tacker_tack_bloc.dart';

class OngoingTackerTackState {
  final Tack tack;
  final int stepsCount;
  final int currentStep;
  final List<Offer> offers;
  final bool isLoading;

  const OngoingTackerTackState({
    required this.tack,
    required this.stepsCount,
    required this.currentStep,
    List<Offer>? offers,
    bool? isLoading,
  })  : offers = offers ?? const <Offer>[],
        isLoading = isLoading ?? false;

  OngoingTackerTackState copyWith({
    Tack? tack,
    int? stepsCount,
    int? currentStep,
    List<Offer>? offers,
    bool? isLoading,
  }) {
    return OngoingTackerTackState(
      tack: tack ?? this.tack,
      stepsCount: stepsCount ?? this.stepsCount,
      currentStep: currentStep ?? this.currentStep,
      offers: offers ?? this.offers,
      isLoading: isLoading ?? false,
    );
  }
}
