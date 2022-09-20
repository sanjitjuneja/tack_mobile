part of errors;

class EmailAlreadyExistException extends AppException {
  const EmailAlreadyExistException()
      : super(
          code: ErrorCode.emailAlreadyExist,
          messageKey: 'errors.emailAlreadyExist',
        );
}
