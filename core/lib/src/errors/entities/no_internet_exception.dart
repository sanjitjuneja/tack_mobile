part of errors;

class NoInternetConnection extends AppException {
  const NoInternetConnection()
      : super(
          code: ErrorCode.noInternet,
          messageKey: 'errors.noInternet',
        );
}
