part of errors;

class AppSocketException extends AppException {
  const AppSocketException()
      : super(
          code: ErrorCode.socket,
          messageKey: 'errors.notAbleToConnectToServer',
        );
}
