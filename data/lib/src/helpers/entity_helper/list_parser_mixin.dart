part of entities_helpers;

mixin ListParserMixin {
  static List<T> listFromJson<T>(
    Map<String, dynamic> json,
    Parser<T> parser,
  ) {
    return List<T>.from(
      (json as List<dynamic>).map(
        (dynamic x) => parser(x as Map<String, dynamic>),
      ),
    );
  }
}
