part of 'account_settings_bloc.dart';

class AccountSettingsState {
  final User user;
  final FirstNameData firstNameData;
  final LastNameData lastNameData;
  final EmailData emailData;

  bool get isReadyToProceed {
    return <bool>[
      firstNameData.isValid,
      lastNameData.isValid,
      emailData.isValid,
    ].every((bool element) => element == true);
  }

  bool get isAnyDataChanged {
    return <String?>[
      changedFirstName,
      changedLastName,
      changedEmail,
    ].any((String? element) => element != null);
  }

  String? get changedFirstName {
    if (firstNameData.isDataChanged(user.firstName)) {
      return firstNameData.firstName;
    }

    return null;
  }

  String? get changedLastName {
    if (lastNameData.isDataChanged(user.lastName)) {
      return lastNameData.lastName;
    }

    return null;
  }

  String? get changedEmail {
    if (emailData.isDataChanged(user.email)) {
      return emailData.email;
    }

    return null;
  }

  AccountSettingsState._({
    required this.user,
    required this.firstNameData,
    required this.lastNameData,
    required this.emailData,
  });

  factory AccountSettingsState.fromUser({
    required User user,
  }) {
    return AccountSettingsState._(
      user: user,
      firstNameData: FirstNameData(firstName: user.firstName),
      lastNameData: LastNameData(lastName: user.lastName),
      emailData: EmailData(email: user.email),
    );
  }

  AccountSettingsState copyWith({
    String? firstName,
    String? lastName,
    String? email,
    bool? isValidationEnabled,
    bool? isEmailAlreadyUsed,
  }) {
    return AccountSettingsState._(
      user: user,
      firstNameData: firstNameData.copyWith(
        firstName: firstName,
        isValidationEnabled: isValidationEnabled,
      ),
      lastNameData: lastNameData.copyWith(
        lastName: lastName,
        isValidationEnabled: isValidationEnabled,
      ),
      emailData: emailData.copyWith(
        email: email,
        isValidationEnabled: isValidationEnabled,
        isEmailAlreadyUsed: isEmailAlreadyUsed,
      ),
    );
  }
}
