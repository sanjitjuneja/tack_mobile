part of mappers;

class ConnectedBankAccountMapper
    implements Mapper<ConnectedBankAccountEntity, domain.ConnectedBankAccount> {
  const ConnectedBankAccountMapper();

  @override
  domain.ConnectedBankAccount fromEntity(ConnectedBankAccountEntity entity) {
    return domain.ConnectedBankAccount(
      id: entity.id,
      bankName: entity.bankName,
      status: entity.status,
      type: entity.type,
      bankAccountType: entity.bankAccountType,
      imageUrl: entity.imageUrl,
      channels: entity.channels,
      isPrimary: entity.isPrimary,
    );
  }

  @override
  ConnectedBankAccountEntity toEntity(domain.ConnectedBankAccount item) {
    return ConnectedBankAccountEntity(
      id: item.id,
      bankName: item.bankName,
      status: item.status,
      type: item.type,
      bankAccountType: item.bankAccountType,
      imageUrl: item.imageUrl,
      channels: item.channels,
      isPrimary: item.isPrimary,
    );
  }
}
