import 'package:core/core.dart';

class DescriptionData {
  final int maxWords;
  final bool isRequired;
  final bool isValidationEnabled;
  final String description;

  int get wordsLeft => maxWords - TextUtility.getWordsCount(description);

  /// Used for Business Logic
  bool get isValid => isRequired ? description.isNotEmpty : true;

  /// Used for UI
  bool get isInvalid => isValidationEnabled ? !isValid : false;

  bool isDataChanged(String? oldDescription) {
    oldDescription ??= '';

    return description != oldDescription;
  }

  const DescriptionData({
    required this.maxWords,
    required this.isRequired,
    this.isValidationEnabled = false,
    String? description,
  }) : description = description ?? '';

  DescriptionData copyWith({
    String? description,
    bool? isValidationEnabled,
  }) {
    return DescriptionData(
      maxWords: maxWords,
      isRequired: isRequired,
      isValidationEnabled: isValidationEnabled ?? this.isValidationEnabled,
      description: description ?? this.description,
    );
  }

  DescriptionData empty() {
    return DescriptionData(
      maxWords: maxWords,
      isRequired: isRequired,
      isValidationEnabled: false,
      description: '',
    );
  }
}
