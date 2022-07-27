class BaseUrlConstants {
  static const String stagingUrl = 'http://35.175.118.114/api/v1/';
  static const String productionUrl = 'http://35.175.118.114/api/v1/';
  static const String developmentUrl = 'http://35.175.118.114/api/v1/';

  static const String loginPath = '/accounts/login/';
  static const String signUpPath = '/signup/user-by-phone/';
  static const String requestSmsCodeSignUpPath = 'signup/send-code/';
  static const String requestSmsCodeResetPasswordPath = 'recovery/send-code/';
  static const String verifyPhoneNumberPath = '/verify/sms-code/';

  static const String groupsPath = '/groups/';
  static const String tacksMePath = '/tacks/me/';

  static const String reviews = '/reviews/';
}
