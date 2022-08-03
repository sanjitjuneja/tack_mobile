part of mappers;

class TackUserContactsMapper
    implements Mapper<TackUserContactsEntity, domain.TackUserContacts> {
  const TackUserContactsMapper();

  @override
  domain.TackUserContacts fromEntity(TackUserContactsEntity entity) {
    return domain.TackUserContacts(
      phoneNumber: entity.phoneNumber,
    );
  }

  @override
  TackUserContactsEntity toEntity(domain.TackUserContacts item) {
    return TackUserContactsEntity(
      phoneNumber: item.phoneNumber,
    );
  }
}
