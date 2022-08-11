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
  static const String offerCancelPath = '/offers/${ApiQuery.idKey}/';

  static const String groupsPath = '/groups/';
  static const String groupsMePath = '/groups/me/';
  static const String groupPath = '/groups/${ApiQuery.idKey}/';
  static const String groupSetActivePath = '/groups/${ApiQuery.idKey}/set_active/';
  static const String groupMembersPath = '/groups/${ApiQuery.idKey}/members/';
  static const String groupLeavePath = '/groups/${ApiQuery.idKey}/leave/';
  static const String groupMutePath = '/groups/${ApiQuery.idKey}/mute/';
  static const String groupUnMutePath = '/groups/${ApiQuery.idKey}/unmute/';
  static const String groupInviteLinkPath = '/groups/${ApiQuery.idKey}/get_invite_link/';

  static const String groupsTacksPath = '/groups/${ApiQuery.idKey}/tacks/';

  static const String invitationsMePath = 'invites/me/';
  static const String invitationAcceptPath = 'invites/${ApiQuery.idKey}/accept/';
  static const String invitationDeclinePath = 'invites/${ApiQuery.idKey}/';

  static const String tacksMeRunnerPath = '/tacks/me/as_runner/';
  static const String tacksMeTackerPath = '/tacks/me/as_tacker/';

  static const String tacks = '/tacks/';
  static const String tacksWithId = '/tacks/${ApiQuery.idKey}/';
  static const String tackOffersPath = '/tacks/${ApiQuery.idKey}/offers/';
  static const String tackStartPath = '/tacks/${ApiQuery.idKey}/start_tack/';
  static const String tackCompletePath = '/tacks/${ApiQuery.idKey}/complete/';

  static const String groupPopularTacksPath = 'groups/${ApiQuery.idKey}/popular_tacks/';
  static const String nearbyPopularTacksPath = 'tacks/nearby/';


  static const String reviews = '/reviews/';
}
