class TitleData {
  final int maxLength;
  final bool isRequired;
  final bool isValidationEnabled;
  final String title;

  int get charactersLeft => maxLength - title.length;

  /// Used for Business Logic
  bool get isValid => isRequired ? title.isNotEmpty : true;

  /// Used for UI
  bool get isInvalid => isValidationEnabled ? !isValid : false;

  bool isDataChanged(String? oldTitle) {
    oldTitle ??= '';

    return title != oldTitle;
  }

  const TitleData({
    required this.maxLength,
    required this.isRequired,
    this.isValidationEnabled = false,
    String? title,
  }) : title = title ?? '';

  TitleData copyWith({
    String? title,
    bool? isValidationEnabled,
  }) {
    return TitleData(
      maxLength: maxLength,
      isRequired: isRequired,
      isValidationEnabled: isValidationEnabled ?? this.isValidationEnabled,
      title: title ?? this.title,
    );
  }

  TitleData empty() {
    return TitleData(
      maxLength: maxLength,
      isRequired: isRequired,
      isValidationEnabled: false,
      title: '',
    );
  }
}
