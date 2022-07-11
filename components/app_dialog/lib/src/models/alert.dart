part of app_dialog;

abstract class Alert {
  final String contentKey;
  final String? title;
  final String? message;
  final String buttonLabel;

  Alert({
    required this.contentKey,
    required this.title,
    required this.message,
    required this.buttonLabel,
  });
}
