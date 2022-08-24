part of mappers;

class BankAccountMapper
    implements Mapper<BankAccountEntity, domain.BankAccount> {
  const BankAccountMapper();

  @override
  domain.BankAccount fromEntity(BankAccountEntity entity) {
    return domain.BankAccount(
      id: entity.id,
      bankName: entity.bankName,
      status: entity.status,
      type: entity.type,
      bankAccountType: entity.bankAccountType,
      channels: entity.channels,
    );
  }

  @override
  BankAccountEntity toEntity(domain.BankAccount item) {
    return BankAccountEntity(
      id: item.id,
      bankName: item.bankName,
      status: item.status,
      type: item.type,
      bankAccountType: item.bankAccountType,
      channels: item.channels,
    );
  }
}
