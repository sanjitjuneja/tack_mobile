part of errors;

class LogInAttemptsExceededException extends AppException {
  const LogInAttemptsExceededException()
      : super(
          code: ErrorCode.logInAttemptsExceeded,
          errorDialogContentKey: 'errorAlert.logInAttemptsExceeded',
          messageKey: 'errors.logInAttemptsExceeded',
        );
}
