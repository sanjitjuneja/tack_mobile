part of errors;

class TransactionsLimitException extends AppException {
  const TransactionsLimitException()
      : super(
          code: ErrorCode.transactionLimit,
          messageKey: 'errors.transactionsLimitReached',
        );
}
