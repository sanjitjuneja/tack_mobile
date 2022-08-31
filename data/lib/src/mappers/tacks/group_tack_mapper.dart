part of mappers;

class GroupTackMapper implements Mapper<GroupTackEntity, domain.GroupTack> {
  final TackMapper tackMapper;

  const GroupTackMapper({
    required this.tackMapper,
  });

  @override
  domain.GroupTack fromEntity(GroupTackEntity entity) {
    return domain.GroupTack(
      id: entity.id,
      tack: tackMapper.fromEntity(entity.tack),
      isMineOfferSent: entity.isMineOfferSent,
    );
  }

  @override
  GroupTackEntity toEntity(domain.GroupTack item) {
    return GroupTackEntity(
      id: item.id,
      tack: tackMapper.toEntity(item.tack),
      isMineOfferSent: item.isMineOfferSent,
    );
  }
}
