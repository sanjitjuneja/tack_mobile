part of app_dialog;

class _AlertLocalizationMapper {
  static const String defaultErrorBaseKey = 'errorAlert.defaultAlert';
  static const String defaultOtherAlertBaseKey = 'otherAlert.defaultAlert';
  static const String defaultDestructiveAlertBaseKey =
      'destructiveAlert.defaultAlert';

  final Alert alert;
  final BuildContext context;
  final bool useDefaultContent;
  final String defaultBaseKey;

  _AlertLocalizationMapper({
    required this.alert,
    required this.context,
    required this.useDefaultContent,
  }) : defaultBaseKey = _getDefaultBaseKey(alert);

  static String _getDefaultBaseKey(Alert alert) {
    if (alert is ErrorAlert) return defaultErrorBaseKey;
    if (alert is DestructiveAlert) return defaultDestructiveAlertBaseKey;

    return defaultOtherAlertBaseKey;
  }

  String _translate(
    String key, {
    Map<String, String>? translationParams,
  }) {
    return FlutterI18n.translate(
      context,
      key,
      translationParams: translationParams,
    );
  }

  String? get title {
    return _getFieldTranslation(
      fieldKey: AlertPropertyKey.title,
    );
  }

  String? get message {
    return _getFieldTranslation(
      fieldKey: AlertPropertyKey.message,
    );
  }

  String? get mainButtonLabel {
    return _getFieldTranslation(
      fieldKey: AlertPropertyKey.mainButtonLabel,
    );
  }

  String? get secondaryButtonLabel {
    return _getFieldTranslation(
      fieldKey: AlertPropertyKey.secondaryButtonLabel,
    );
  }

  String? _getFieldTranslation({
    required AlertPropertyKey fieldKey,
  }) {
    final Map<String, String> fieldTranslationParams =
        alert.translationParams[fieldKey] ?? {};

    String __translateWithInnerParams(String value) {
      return _translate(value, translationParams: fieldTranslationParams);
    }

    final String? propertyValue = alert.getProperty(fieldKey);
    if (propertyValue != null) {
      return __translateWithInnerParams(propertyValue);
    }

    final String keyStringRepresentation = fieldKey.toString();
    if (alert.contentKey != null) {
      final String fullFieldKey = _getFullFieldKey(
        alert.contentKey!,
        keyStringRepresentation,
      );
      final String fieldTranslation = __translateWithInnerParams(fullFieldKey);

      if (fieldTranslation != fullFieldKey) return fieldTranslation;
    }

    if (useDefaultContent) {
      final String defaultFieldKey = _getFullFieldKey(
        defaultBaseKey,
        keyStringRepresentation,
      );
      final String defaultTranslation =
          __translateWithInnerParams(defaultFieldKey);

      if (defaultTranslation != defaultFieldKey) return defaultTranslation;
    }

    return null;
  }

  String _getFullFieldKey(String baseKey, String fieldKey) {
    return <String>[
      baseKey,
      fieldKey,
    ].join('.');
  }
}
