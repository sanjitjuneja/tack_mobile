part of mappers;

class MapperFactory {
  GroupMapper get groupMapper => const GroupMapper();

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
}
