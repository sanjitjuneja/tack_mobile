part of errors;

class NoPermissionsException extends AppException {
  const NoPermissionsException()
      : super(
    code: ErrorCode.noPermissions,
    messageKey: 'errors.noPermissions',
  );
}
