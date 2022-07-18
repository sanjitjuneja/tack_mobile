import 'package:domain/models/user.dart';

abstract class PersonalInformationEvent {}

class RegisterUser extends PersonalInformationEvent {
  final User user;

  RegisterUser({
    required this.user,
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

class UpdatePassword extends PersonalInformationEvent {
  final String password;
  final String confirmedPassword;

  UpdatePassword({
    required this.password,
    required this.confirmedPassword,
  });
}

class RouteBack extends PersonalInformationEvent {}
