part of api_query;

class BaseUrlConstants {
  static const String startSessionPath = 'tokens/obtain/';
  static const String refreshSessionPath = 'tokens/refresh/';
  static const String endSessionPath = 'tokens/blacklist/';

  static const String logOutPath = '/accounts/logout/';
  static const String signUpPath = '/signup/user-by-phone/';
  static const String requestSmsCodeSignUpPath = 'signup/send-code/';
  static const String requestSmsCodeResetPasswordPath = 'recovery/send-code/';
  static const String verifyPhoneNumberPath = '/verify/sms-code/';

  static const String userPath = 'users/me/';

  static const String groupsPath = '/groups/';
  static const String groupsTacksPath = '/groups/${ApiQuery.idKey}/tacks';

  static const String tacksMePath = '/tacks/me/';

  static const String tacks = '/tacks/';
  static const String tacksWithId = '/tacks/${ApiQuery.idKey}/';

  static const String reviews = '/reviews/';
}
