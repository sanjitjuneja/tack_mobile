part of errors;

class WrongCredentialsException extends AppException {
  const WrongCredentialsException()
      : super(
          code: ErrorCode.wrongCredentials,
          messageKey: 'errors.wrongCredentials',
        );
}
