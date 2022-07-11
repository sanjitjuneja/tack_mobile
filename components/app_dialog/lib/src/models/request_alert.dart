part of app_dialog;

class RequestAlert extends Alert {
  RequestAlert({
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
