part of errors;

class PhoneNumberAlreadyExistException extends AppException {
  const PhoneNumberAlreadyExistException()
      : super(
          code: ErrorCode.phoneNumberAlreadyExist,
          errorDialogContentKey: 'errorAlert.phoneNumberAlreadyExist',
          messageKey: 'errors.phoneNumberAlreadyExist',
        );
}
