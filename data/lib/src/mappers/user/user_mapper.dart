part of mappers;

class CustomerMapper implements Mapper<UserEntity, domain.User> {
  @override
  domain.User fromEntity(UserEntity entity) {
    return domain.User(
      id: entity.id,
      balance: entity.balance ?? 0.0,
      firstName: entity.firstName,
      lastName: entity.lastName,
      activeGroup: entity.activeGroup,
      phoneNumber: entity.phoneNumber,
    );
  }

  @override
  UserEntity toEntity(domain.User item) {
    return UserEntity(
      id: item.id,
      balance: item.balance,
      firstName: item.firstName,
      lastName: item.lastName,
      activeGroup: item.activeGroup,
      phoneNumber: item.phoneNumber,
    );
  }
}
