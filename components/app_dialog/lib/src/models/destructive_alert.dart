part of app_dialog;

class DestructiveAlert extends Alert {
  DestructiveAlert({
    required String contentKey,
    String? title,
    String? message,
    String? buttonLabel,
  }) : super(
          contentKey: contentKey,
          title: title,
          message: message,
          buttonLabel: buttonLabel ?? '',
        );
}
