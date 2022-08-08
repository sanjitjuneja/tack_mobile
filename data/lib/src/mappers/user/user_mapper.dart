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
      firstName: entity.firstName,
      lastName: entity.lastName,
      birthDate: DateTime.parse(entity.birthDate),
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
      firstName: item.firstName,
      lastName: item.lastName,
      birthDate: item.birthDate.toIso8601String(),
      profilePicture: item.profilePicture,
      tacksRating: item.rating,
      tacksAmount: item.tacksAmount,
      phoneNumber: item.phoneNumber,
      activeGroup: item.activeGroup,
    );
  }
}
