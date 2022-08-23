class TermsData {
  final bool isValidationEnabled;
  final bool isAccepted;

  /// Used for Business Logic
  bool get isValid => isAccepted;

  /// Used for UI
  bool get isInvalid => isValidationEnabled ? !isValid : false;

  const TermsData({
    this.isValidationEnabled = false,
    bool? isAccepted,
  }) : isAccepted = isAccepted ?? false;

  TermsData copyWith({
    bool? isAccepted,
    bool? isValidationEnabled,
  }) {
    return TermsData(
      isValidationEnabled: isValidationEnabled ?? false,
      isAccepted: isAccepted ?? this.isAccepted,
    );
  }
}
