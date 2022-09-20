part of errors;

class UnauthorizedException extends AppException {
  const UnauthorizedException()
      : super(
          code: ErrorCode.unauthorized,
          messageKey: 'errors.unauthorized',
        );
}
