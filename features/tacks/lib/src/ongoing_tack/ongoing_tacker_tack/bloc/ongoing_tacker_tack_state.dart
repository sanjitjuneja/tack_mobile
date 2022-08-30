part of 'ongoing_tacker_tack_bloc.dart';

class OngoingTackerTackState {
  final Tack tack;
  final int stepsCount;
  final int currentStep;
  final bool isLoading;
  final UserContacts? userContacts;

  bool get hasContactData => userContacts != null;

  const OngoingTackerTackState({
    required this.tack,
    required this.stepsCount,
    required this.currentStep,
    bool? isLoading,
    this.userContacts,
  }) : isLoading = isLoading ?? false;

  OngoingTackerTackState copyWith({
    Tack? tack,
    int? stepsCount,
    int? currentStep,
    bool? isLoading,
    UserContacts? userContacts,
  }) {
    return OngoingTackerTackState(
      tack: tack ?? this.tack,
      stepsCount: stepsCount ?? this.stepsCount,
      currentStep: currentStep ?? this.currentStep,
      isLoading: isLoading ?? false,
      userContacts: userContacts ?? this.userContacts,
    );
  }
}
