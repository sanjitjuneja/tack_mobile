class FirstNameData {
  final bool isValidationEnabled;
  final String firstName;

  /// Used for Business Logic
  bool get isValid => firstName.isNotEmpty;

  /// Used for UI
  bool get isInvalid => isValidationEnabled ? !isValid : false;

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
