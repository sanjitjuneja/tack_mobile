part of mappers;

class TackUserMapper implements Mapper<TackUserEntity, domain.TackUser> {
  final TackUserContactsMapper tackUserContactsMapper;

  const TackUserMapper({
    required this.tackUserContactsMapper,
  });

  @override
  domain.TackUser fromEntity(TackUserEntity entity) {
    return domain.TackUser(
      id: entity.id,
      firstName: entity.firstName,
      lastName: entity.lastName,
      rating: entity.tacksRating,
      tacksComplete: entity.tacksAmount,
    );
  }

  @override
  TackUserEntity toEntity(domain.TackUser item) {
    return TackUserEntity(
      id: item.id,
      firstName: item.firstName,
      lastName: item.lastName,
      tacksRating: item.rating,
      tacksAmount: item.tacksComplete,
    );
  }
}
