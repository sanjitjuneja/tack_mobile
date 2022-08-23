part of errors;

class FormFieldException implements Exception {
  final Map<String, String> validationErrors;

  FormFieldException(this.validationErrors);
}
