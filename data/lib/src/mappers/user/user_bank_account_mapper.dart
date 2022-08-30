part of mappers;

class UserBankAccountMapper
    implements Mapper<UserBankAccountEntity, domain.UserBankAccount> {
  const UserBankAccountMapper();

  @override
  domain.UserBankAccount fromEntity(UserBankAccountEntity entity) {
    return domain.UserBankAccount(
      usdBalance: entity.usdBalance / 100,
    );
  }

  @override
  UserBankAccountEntity toEntity(domain.UserBankAccount item) {
    return UserBankAccountEntity(
      usdBalance: (item.usdBalance * 100).toInt(),
    );
  }
}
