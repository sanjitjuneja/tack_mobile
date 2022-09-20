part of errors;

class HasNotEmptyBalanceException extends AppException {
  const HasNotEmptyBalanceException()
      : super(
    code: ErrorCode.hasNotEmptyBalance,
    messageKey: 'errors.hasNotEmptyBalance',
  );
}
