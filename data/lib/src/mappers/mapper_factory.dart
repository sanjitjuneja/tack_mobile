part of mappers;

class MapperFactory {
  GroupMapper get groupMapper => const GroupMapper();

  GroupInviteLinkMapper get groupInviteLinkMapper =>
      const GroupInviteLinkMapper();

  GroupInvitationMapper get groupInvitationMapper =>
      GroupInvitationMapper(groupMapper: groupMapper);

  TemplateTackMapper get templateTackMapper => const TemplateTackMapper();

  TackStatusMapper get tackStatusMapper => const TackStatusMapper();

  TackUserContactsMapper get tackUserContactsMapper =>
      const TackUserContactsMapper();

  TackUserMapper get tackUserMapper => TackUserMapper(
        tackUserContactsMapper: tackUserContactsMapper,
      );

  TackMapper get tackMapper => TackMapper(
        tackStatusMapper: tackStatusMapper,
        tackUserMapper: tackUserMapper,
        groupMapper: groupMapper,
      );

  OfferTypeMapper get offerTypeMapper => OfferTypeMapper();

  OfferMapper get offerMapper => OfferMapper(
        offerTypeMapper: offerTypeMapper,
        tackUserMapper: tackUserMapper,
      );

  RunnerTackMapper get runnerTackMapper => RunnerTackMapper(
        tackMapper: tackMapper,
        offerMapper: offerMapper,
      );

  UserBankAccountMapper get userBankAccountMapper => UserBankAccountMapper();

  UserMapper get customerMapper => UserMapper(
        userBankAccountMapper: userBankAccountMapper,
      );

  SmsVerificationMapper get smsVerificationMapper => SmsVerificationMapper();

  PhoneVerificationMapper get phoneVerificationMapper =>
      PhoneVerificationMapper();

  PaginationMapper<S, C> paginationMapper<S, C>() => PaginationMapper<S, C>(
        mapper: _factory<S, C>(),
      );

  Mapper<S, C> _factory<S, C>() {
    if (S == TackEntity) {
      return tackMapper as Mapper<S, C>;
    }

    if (S == OfferEntity) {
      return offerMapper as Mapper<S, C>;
    }

    throw Exception('wrong type');
  }
}
