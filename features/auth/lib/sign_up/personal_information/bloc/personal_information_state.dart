abstract class PersonalInformationState {}

class PersonalInformationContent extends PersonalInformationState {
  final Map<String, String>? firstNameError;
  final Map<String, String>? passwordError;
  final Map<String, String>? secondNameError;
  final Map<String, String>? confirmedPasswordError;

  PersonalInformationContent({
    this.firstNameError,
    this.passwordError,
    this.secondNameError,
    this.confirmedPasswordError,
  });
}
