import '../models/auth_error_type.dart';

extension AuthErrorTypeToViewExtension on AuthErrorType {
  String get titleKey {
    return _fieldValue(field: 'title');
  }

  String get descriptionKey {
    return _fieldValue(field: 'description');
  }

  String get buttonLabelKey {
    return _fieldValue(field: 'button');
  }

  String _fieldValue({required String field}) {
    String basicPath = 'authErrorScreen';

    return <String>[
      basicPath,
      name,
      field,
    ].join('.');
  }
}
