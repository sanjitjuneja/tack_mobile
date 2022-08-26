part of mappers;

class UserMapper implements Mapper<UserEntity, domain.User> {
  final UserBankAccountMapper userBankAccountMapper;

  const UserMapper({
    required this.userBankAccountMapper,
  });

  @override
  domain.User fromEntity(UserEntity entity) {
    return domain.User(
      id: entity.id,
      email: entity.email,
      firstName: entity.firstName,
      lastName: entity.lastName,
      birthDate: entity.birthDate,
      profilePicture: entity.profilePicture,
      rating: entity.tacksRating,
      tacksAmount: entity.tacksAmount,
      phoneNumber: entity.phoneNumber,
      activeGroup: entity.activeGroup,
    );
  }

  @override
  UserEntity toEntity(domain.User item) {
    return UserEntity(
      id: item.id,
      email: item.email,
      firstName: item.firstName,
      lastName: item.lastName,
      birthDate: item.birthDate,
      profilePicture: item.profilePicture,
      tacksRating: item.rating,
      tacksAmount: item.tacksAmount,
      phoneNumber: item.phoneNumber,
      activeGroup: item.activeGroup,
    );
  }
}
