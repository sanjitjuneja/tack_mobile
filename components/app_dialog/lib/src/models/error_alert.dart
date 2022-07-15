part of app_dialog;

class ErrorAlert extends Alert {
  ErrorAlert({
    String? contentKey,
    String? titleKey,
    String? messageKey,
    String? buttonLabelKey,
    TranslationParams? translationParams,
  }) : super(
          contentKey: contentKey,
          title: titleKey,
          message: messageKey,
          mainButtonLabel: buttonLabelKey,
          secondaryButtonLabel: null,
          translationParams: translationParams,
        );

// TODO: add method fromServerError.
}
