part of errors;

class InternalBackendException extends AppException {
  const InternalBackendException()
      : super(
          code: ErrorCode.internalServer,
          messageKey: 'errors.internalServer',
        );
}
