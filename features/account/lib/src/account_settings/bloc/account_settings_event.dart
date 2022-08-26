part of 'account_settings_bloc.dart';

abstract class AccountSettingsEvent {
  const AccountSettingsEvent();
}

class FirstNameChanged extends AccountSettingsEvent {
  final String firstName;

  const FirstNameChanged({
    required this.firstName,
  });
}

class LastNameChanged extends AccountSettingsEvent {
  final String lastName;

  const LastNameChanged({
    required this.lastName,
  });
}

class EmailChanged extends AccountSettingsEvent {
  final String email;

  const EmailChanged({
    required this.email,
  });
}

class UpdateProfileAction extends AccountSettingsEvent {
  const UpdateProfileAction();
}
