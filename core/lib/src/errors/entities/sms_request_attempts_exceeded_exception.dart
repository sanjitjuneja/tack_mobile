part of errors;

class SmsRequestAttemptsExceededException extends AppException {
  const SmsRequestAttemptsExceededException()
      : super(
          code: ErrorCode.smsRequestAttemptsExceeded,
          errorDialogContentKey: 'errorAlert.smsRequestAttemptsExceeded',
          messageKey: 'errors.smsRequestAttemptsExceeded',
        );
}
