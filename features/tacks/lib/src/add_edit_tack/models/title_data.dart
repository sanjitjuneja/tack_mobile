class TitleData {
  final int maxLength;
  final bool isRequired;
  final String title;

  int get charactersLeft => maxLength - title.length;

  bool get isValid => isRequired ? title.isNotEmpty : true;

  bool isDataChanged(String? oldTitle) {
    oldTitle ??= '';

    return title != oldTitle;
  }

  const TitleData({
    required this.maxLength,
    required this.isRequired,
    String? title,
  }) : title = title ?? '';

  TitleData copyWith({String? title}) {
    return TitleData(
      maxLength: maxLength,
      isRequired: isRequired,
      title: title ?? this.title,
    );
  }

  TitleData empty() {
    return TitleData(
      maxLength: maxLength,
      isRequired: isRequired,
      title: '',
    );
  }
}
