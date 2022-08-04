part of mappers;

class UserBankAccountMapper
    implements Mapper<UserBankAccountEntity, domain.UserBankAccount> {
  @override
  domain.UserBankAccount fromEntity(UserBankAccountEntity entity) {
    return domain.UserBankAccount(
      userId: entity.user,
      usdBalance: entity.usdBalance,
    );
  }

  @override
  UserBankAccountEntity toEntity(domain.UserBankAccount item) {
    return UserBankAccountEntity(
      user: item.userId,
      usdBalance: item.usdBalance,
    );
  }
}
