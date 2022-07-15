part of app_dialog;

class DestructiveAlert extends Alert {
  DestructiveAlert({
    String? contentKey,
    String? titleKey,
    String? messageKey,
    String? mainButtonLabelKey,
    String? secondaryButtonLabelKey,
    TranslationParams? translationParams,
  }) : super(
          contentKey: contentKey,
          title: titleKey,
          message: messageKey,
          mainButtonLabel: mainButtonLabelKey,
          secondaryButtonLabel: secondaryButtonLabelKey,
          translationParams: translationParams,
        );
}
