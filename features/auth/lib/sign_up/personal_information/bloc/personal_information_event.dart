abstract class PersonalInformationEvent {}

class RegisterUser extends PersonalInformationEvent {
  final String firstName;
  final String lastName;
  final String password;
  final String phoneNumber;
  final String confirmedPassword;

  RegisterUser({
    required this.firstName,
    required this.lastName,
    required this.password,
    required this.phoneNumber,
    required this.confirmedPassword,
  });
}

class ValidateFirstName extends PersonalInformationEvent {
  final String firstName;

  ValidateFirstName({
    required this.firstName,
  });
}

class ValidateLastName extends PersonalInformationEvent {
  final String lastName;

  ValidateLastName({
    required this.lastName,
  });
}

class ValidatePassword extends PersonalInformationEvent {
  final String password;

  ValidatePassword({
    required this.password,
  });
}

class ValidateConfirmedPassword extends PersonalInformationEvent {
  final String password;

  ValidateConfirmedPassword({
    required this.password,
  });
}

class ValidateTermsConditions extends PersonalInformationEvent {
  final bool isConditionsAccepted;

  ValidateTermsConditions({
    required this.isConditionsAccepted,
  });
}

class RouteBack extends PersonalInformationEvent {}
