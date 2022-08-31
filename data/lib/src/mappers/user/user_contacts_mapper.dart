part of mappers;

class UserContactsMapper
    implements Mapper<UserContactsEntity, domain.UserContacts> {
  const UserContactsMapper();

  @override
  domain.UserContacts fromEntity(UserContactsEntity entity) {
    return domain.UserContacts(
      phoneNumber: entity.phoneNumber,
      email: entity.email,
    );
  }

  @override
  UserContactsEntity toEntity(domain.UserContacts item) {
    return UserContactsEntity(
      phoneNumber: item.phoneNumber,
      email: item.email,
    );
  }
}
