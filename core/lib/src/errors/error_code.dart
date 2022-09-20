part of errors;

class ErrorCode {
  static const String noInternet = 'XXX';

  static const String unknown = 'X00';
  static const String socket = 'X01';
  static const String unauthorized = 'X02';

  static const String internalServer = 'SSx500';
  static const String badGateway = 'SSx502';

  static const String wrongCredentials = 'Ux1';
  static const String emailAlreadyExist = 'Ux2';

  static const String phoneNumberAlreadyExist = 'Ux3';

  static const String smsRequestAttemptsExceeded = 'Sx1';
  static const String wrongPassword = 'Sx7';
  static const String phoneNumberNotFound = 'Sx4';
  static const String logInAttemptsExceeded = 'Sx12';

  static const String notMemberOfTheGroup = 'Gx1';
  static const String hasOngoingGroupTacks = 'Gx2';

  static const String transactionLimit = 'Px1';

  static const String hasActiveTacks = 'Ux5';
  static const String hasNotEmptyBalance = 'Ux6';
}
