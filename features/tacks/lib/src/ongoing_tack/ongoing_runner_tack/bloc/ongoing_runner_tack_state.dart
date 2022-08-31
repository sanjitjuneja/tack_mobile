part of 'ongoing_runner_tack_bloc.dart';

class OngoingRunnerTackState {
  final Tack tack;
  final int stepsCount;
  final int currentStep;
  final bool hasRunningTack;
  final UserContacts? userContacts;

  bool get hasContactData => userContacts != null;

  const OngoingRunnerTackState({
    required this.tack,
    required this.stepsCount,
    required this.currentStep,
    required this.hasRunningTack,
    this.userContacts,
  });

  OngoingRunnerTackState copyWith({
    Tack? tack,
    int? stepsCount,
    int? currentStep,
    bool? hasRunningTack,
    UserContacts? userContacts,
  }) {
    return OngoingRunnerTackState(
      tack: tack ?? this.tack,
      stepsCount: stepsCount ?? this.stepsCount,
      currentStep: currentStep ?? this.currentStep,
      hasRunningTack: hasRunningTack ?? this.hasRunningTack,
      userContacts: userContacts ?? this.userContacts,
    );
  }
}
