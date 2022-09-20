part of errors;

class PhoneNumberNotFoundException extends AppException {
  const PhoneNumberNotFoundException()
      : super(
          code: ErrorCode.phoneNumberNotFound,
          errorDialogContentKey: 'errorAlert.phoneNumberNotFound',
          messageKey: 'errors.phoneNumberNotFound',
        );
}
