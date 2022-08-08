part of mappers;

class GroupMapper implements Mapper<GroupEntity, domain.Group> {
  const GroupMapper();

  @override
  domain.Group fromEntity(GroupEntity entity) {
    return domain.Group(
      id: entity.id,
      ownerId: entity.ownerId,
      name: entity.name,
      description: entity.description,
      imageUrl: entity.imageUrl ?? '',
      isPublic: entity.isPublic,
    );
  }

  @override
  GroupEntity toEntity(domain.Group item) {
    return GroupEntity(
      id: item.id,
      ownerId: item.ownerId,
      name: item.name,
      description: item.description,
      imageUrl: item.imageUrl,
      isPublic: item.isPublic,
    );
  }
}
