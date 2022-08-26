part of form_models;

class LastNameData {
  final bool isValidationEnabled;
  final String lastName;

  /// Used for Business Logic
  bool get isValid => lastName.isNotEmpty;

  /// Used for UI
  bool get isInvalid => isValidationEnabled ? !isValid : false;

  bool isDataChanged(String? oldLastName) {
    oldLastName ??= '';

    return lastName != oldLastName;
  }

  const LastNameData({
    this.isValidationEnabled = false,
    String? lastName,
  }) : lastName = lastName ?? '';

  LastNameData copyWith({
    String? lastName,
    bool? isValidationEnabled,
  }) {
    return LastNameData(
      isValidationEnabled: isValidationEnabled ?? false,
      lastName: lastName ?? this.lastName,
    );
  }
}
