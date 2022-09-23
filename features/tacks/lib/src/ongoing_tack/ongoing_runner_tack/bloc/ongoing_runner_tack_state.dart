part of 'ongoing_runner_tack_bloc.dart';

class OngoingRunnerTackState {
  final RunnerTack runnerTack;
  final int stepsCount;
  final int currentStep;
  final RunningTackData runningTackData;
  final bool isLoading;
  final bool isContactsLoading;
  final UserContacts? userContacts;

  bool get hasContactData => userContacts != null;

  const OngoingRunnerTackState({
    required this.runnerTack,
    required this.stepsCount,
    required this.currentStep,
    required this.runningTackData,
    this.isLoading = false,
    this.isContactsLoading = true,
    this.userContacts,
  });

  OngoingRunnerTackState copyWith({
    RunnerTack? runnerTack,
    int? stepsCount,
    int? currentStep,
    RunningTackData? runningTackData,
    bool? isLoading,
    bool? isContactsLoading,
    UserContacts? userContacts,
  }) {
    return OngoingRunnerTackState(
      runnerTack: runnerTack ?? this.runnerTack,
      stepsCount: stepsCount ?? this.stepsCount,
      currentStep: currentStep ?? this.currentStep,
      runningTackData: runningTackData ?? this.runningTackData,
      isLoading: isLoading ?? false,
      isContactsLoading: isContactsLoading ?? this.isContactsLoading,
      userContacts: userContacts ?? this.userContacts,
    );
  }
}
