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

  static const String offersPath = '/offers/';

  static const String groupsPath = '/groups/';
  static const String groupsMePath = '/groups/me/';
  static const String groupPath = '/group/${ApiQuery.idKey}/';
  static const String groupSetActivePath = '/groups/${ApiQuery.idKey}/set_active';
  static const String groupsTacksPath = '/groups/${ApiQuery.idKey}/tacks';

  static const String tacksMeRunnerPath = '/tacks/me/as_runner/';
  static const String tacksMeTackerPath = '/tacks/me/as_tacker/';

  static const String tacks = '/tacks/';
  static const String tacksWithId = '/tacks/${ApiQuery.idKey}/';

  static const String groupPopularTacksPath = 'groups/${ApiQuery.idKey}/popular_tacks/';
  static const String nearbyPopularTacksPath = 'tacks/nearby/';


  static const String reviews = '/reviews/';
}
