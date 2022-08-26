part of form_models;

class FirstNameData {
  final bool isValidationEnabled;
  final String firstName;

  /// Used for Business Logic
  bool get isValid => firstName.isNotEmpty;

  /// Used for UI
  bool get isInvalid => isValidationEnabled ? !isValid : false;

  bool isDataChanged(String? oldFirstName) {
    oldFirstName ??= '';

    return firstName != oldFirstName;
  }

  const FirstNameData({
    this.isValidationEnabled = false,
    String? firstName,
  }) : firstName = firstName ?? '';

  FirstNameData copyWith({
    String? firstName,
    bool? isValidationEnabled,
  }) {
    return FirstNameData(
      isValidationEnabled: isValidationEnabled ?? false,
      firstName: firstName ?? this.firstName,
    );
  }
}
