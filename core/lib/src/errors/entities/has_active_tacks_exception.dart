part of errors;

class HasActiveTacksException extends AppException {
  const HasActiveTacksException()
      : super(
    code: ErrorCode.hasActiveTacks,
    messageKey: 'errors.hasActiveTacks',
  );
}
