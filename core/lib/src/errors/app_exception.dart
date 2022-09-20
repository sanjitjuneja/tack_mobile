part of errors;

class AppException implements Exception {
  final String code;
  final String? errorDialogContentKey;
  final String? messageKey;
  final String? message;

  const AppException({
    required this.code,
    this.errorDialogContentKey,
    this.messageKey,
    this.message,
  });

  @override
  String toString() => messageKey ?? message ?? '';
}
