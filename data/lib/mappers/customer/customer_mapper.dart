part of mappers;

class CustomerMapper implements Mapper<UserEntity, domain.Customer> {
  @override
  domain.Customer fromEntity(UserEntity entity) {
    return domain.Customer(
      id: entity.id,
      balance: entity.balance,
      firstName: entity.firstName,
      lastName: entity.lastName,
      activeGroup: entity.activeGroup,
      phoneNumber: entity.phoneNumber,
    );
  }

  @override
  UserEntity toEntity(domain.Customer item) {
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
