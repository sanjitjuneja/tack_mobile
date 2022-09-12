part of 'ongoing_runner_tack_bloc.dart';

class OngoingRunnerTackState {
  final Tack tack;
  final int stepsCount;
  final int currentStep;
  final RunningTackData runningTackData;
  final UserContacts? userContacts;

  bool get hasContactData => userContacts != null;

  const OngoingRunnerTackState({
    required this.tack,
    required this.stepsCount,
    required this.currentStep,
    required this.runningTackData,
    this.userContacts,
  });

  OngoingRunnerTackState copyWith({
    Tack? tack,
    int? stepsCount,
    int? currentStep,
    RunningTackData? runningTackData,
    UserContacts? userContacts,
  }) {
    return OngoingRunnerTackState(
      tack: tack ?? this.tack,
      stepsCount: stepsCount ?? this.stepsCount,
      currentStep: currentStep ?? this.currentStep,
      runningTackData: runningTackData ?? this.runningTackData,
      userContacts: userContacts ?? this.userContacts,
    );
  }
}
