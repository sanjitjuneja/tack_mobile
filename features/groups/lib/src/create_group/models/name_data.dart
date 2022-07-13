class NameData {
  final int maxLength;
  final bool isRequired;
  final String name;

  int get charactersLeft => maxLength - name.length;

  bool get isValid => isRequired ? name.isNotEmpty : true;

  const NameData({
    required this.maxLength,
    required this.isRequired,
    this.name = '',
  });

  NameData copyWith({String? name}) {
    return NameData(
      maxLength: maxLength,
      isRequired: isRequired,
      name: name ?? this.name,
    );
  }
}
