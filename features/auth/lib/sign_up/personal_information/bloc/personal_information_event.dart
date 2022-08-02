abstract class PersonalInformationEvent {}

class RegisterUser extends PersonalInformationEvent {
  final String email;
  final String firstName;
  final String lastName;
  final String password;
  final String phoneNumber;
  final String confirmedPassword;

  RegisterUser({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.password,
    required this.phoneNumber,
    required this.confirmedPassword,
  });
}

class ValidateEmail extends PersonalInformationEvent {
  final String email;

  ValidateEmail({
    required this.email,
  });
}

class ValidatePassword extends PersonalInformationEvent {
  final String password;
  final String confirmedPassword;

  ValidatePassword({
    required this.password,
    required this.confirmedPassword,
  });
}

class ValidateConfirmedPassword extends PersonalInformationEvent {
  final String password;
  final String confirmedPassword;

  ValidateConfirmedPassword({
    required this.password,
    required this.confirmedPassword,
  });
}

class ValidateTermsConditions extends PersonalInformationEvent {
  final bool isConditionsAccepted;

  ValidateTermsConditions({
    required this.isConditionsAccepted,
  });
}
