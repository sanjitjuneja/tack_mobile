part of 'ongoing_tacker_tack_bloc.dart';

class OngoingTackerTackState {
  final Tack tack;
  final int stepsCount;
  final int currentStep;
  final bool isContactsLoading;
  final UserContacts? userContacts;

  bool get hasContactData => userContacts != null;

  const OngoingTackerTackState({
    required this.tack,
    required this.stepsCount,
    required this.currentStep,
    this.isContactsLoading = true,
    this.userContacts,
  });

  OngoingTackerTackState copyWith({
    Tack? tack,
    int? stepsCount,
    int? currentStep,
    bool? isContactsLoading,
    UserContacts? userContacts,
  }) {
    return OngoingTackerTackState(
      tack: tack ?? this.tack,
      stepsCount: stepsCount ?? this.stepsCount,
      currentStep: currentStep ?? this.currentStep,
      isContactsLoading: isContactsLoading ?? this.isContactsLoading,
      userContacts: userContacts ?? this.userContacts,
    );
  }
}
