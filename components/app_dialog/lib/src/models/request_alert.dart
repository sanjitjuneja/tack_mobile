part of app_dialog;

class RequestAlert extends Alert {
  RequestAlert({
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
}
