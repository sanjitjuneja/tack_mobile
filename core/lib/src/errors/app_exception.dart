part of errors;

class AppException implements Exception {
  final String errorMessage;

  AppException(this.errorMessage);
}
