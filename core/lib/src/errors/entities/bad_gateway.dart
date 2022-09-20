part of errors;

class BadGatewayException extends AppException {
  const BadGatewayException()
      : super(
          code: ErrorCode.badGateway,
          messageKey: 'errors.serverNotResponding',
        );
}
