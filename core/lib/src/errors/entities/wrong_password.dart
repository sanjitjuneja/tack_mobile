part of errors;

class WrongPasswordException extends AppException {
  const WrongPasswordException()
      : super(
          code: ErrorCode.wrongPassword,
          messageKey: 'errors.transactionsLimitReached',
        );
}
