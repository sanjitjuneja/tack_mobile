class BaseErrorModel {
  final String errorText;
  final String? descriptionText;

  BaseErrorModel({
    required this.errorText,
    this.descriptionText,
  });
}
