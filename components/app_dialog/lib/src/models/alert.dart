part of app_dialog;

enum AlertPropertyKey {
  title,
  message,
  mainButtonLabel,
  secondaryButtonLabel;

  @override
  String toString() {
    switch (this) {
      case AlertPropertyKey.title:
        return 'title';
      case AlertPropertyKey.message:
        return 'message';
      case AlertPropertyKey.mainButtonLabel:
        return 'mainButtonLabel';
      case AlertPropertyKey.secondaryButtonLabel:
        return 'secondaryButtonLabel';
    }
  }
}

abstract class Alert {
  final String? contentKey;
  final String? title;
  final String? message;
  final String? mainButtonLabel;
  final String? secondaryButtonLabel;
  final TranslationParams translationParams;

  Alert({
    required this.contentKey,
    required this.title,
    required this.message,
    required this.mainButtonLabel,
    required this.secondaryButtonLabel,
    TranslationParams? translationParams,
  }) : translationParams = translationParams ?? {};

  String? getProperty(AlertPropertyKey key) => <AlertPropertyKey, String?>{
        AlertPropertyKey.title: title,
        AlertPropertyKey.message: message,
        AlertPropertyKey.mainButtonLabel: mainButtonLabel,
        AlertPropertyKey.secondaryButtonLabel: secondaryButtonLabel,
      }[key];
}
