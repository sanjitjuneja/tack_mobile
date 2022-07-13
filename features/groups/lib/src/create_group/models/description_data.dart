import 'package:core/core.dart';

class DescriptionData {
  final int maxWords;
  final bool isRequired;
  final String description;

  int get wordsLeft => maxWords - TextUtility.getWordsCount(description);

  bool get isValid => isRequired ? description.isNotEmpty : true;

  const DescriptionData({
    required this.maxWords,
    required this.isRequired,
    this.description = '',
  });

  DescriptionData copyWith({String? description}) {
    return DescriptionData(
      maxWords: maxWords,
      isRequired: isRequired,
      description: description ?? this.description,
    );
  }
}
