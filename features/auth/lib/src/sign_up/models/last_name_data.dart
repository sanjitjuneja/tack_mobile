class LastNameData {
  final bool isValidationEnabled;
  final String lastName;

  /// Used for Business Logic
  bool get isValid => lastName.isNotEmpty;

  /// Used for UI
  bool get isInvalid => isValidationEnabled ? !isValid : false;

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
