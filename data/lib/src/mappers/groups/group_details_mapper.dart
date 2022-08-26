part of mappers;

class GroupDetailsMapper
    implements Mapper<GroupDetailsEntity, domain.GroupDetails> {
  final GroupMapper groupMapper;

  const GroupDetailsMapper({
    required this.groupMapper,
  });

  @override
  domain.GroupDetails fromEntity(GroupDetailsEntity entity) {
    return domain.GroupDetails(
      group: groupMapper.fromEntity(entity.group),
      isMuted: entity.isMuted,
    );
  }

  @override
  GroupDetailsEntity toEntity(domain.GroupDetails item) {
    return GroupDetailsEntity(
      group: groupMapper.toEntity(item.group),
      isMuted: item.isMuted,
    );
  }
}
