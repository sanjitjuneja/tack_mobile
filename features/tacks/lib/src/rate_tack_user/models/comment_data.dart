import 'package:core/core.dart';

class CommentData {
  final int maxWords;
  final bool isRequired;
  final String comment;

  int get wordsLeft => maxWords - TextUtility.getWordsCount(comment);

  bool get isValid => isRequired ? comment.isNotEmpty : true;

  const CommentData({
    required this.maxWords,
    required this.isRequired,
    this.comment = '',
  });

  CommentData copyWith({String? comment}) {
    return CommentData(
      maxWords: maxWords,
      isRequired: isRequired,
      comment: comment ?? this.comment,
    );
  }
}
