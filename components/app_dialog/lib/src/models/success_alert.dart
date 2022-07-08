part of app_dialog;

class SuccessAlert extends Alert {
  SuccessAlert({
    required String contentKey,
    String? title,
    String? message,
    required String buttonLabel,
  }) : super(
          contentKey: contentKey,
          title: title,
          message: message,
          buttonLabel: buttonLabel,
        );
}
