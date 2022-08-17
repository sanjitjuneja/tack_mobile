part of mappers;

class GroupInviteMapper
    implements Mapper<GroupInviteEntity, domain.GroupInvite> {
  final GroupMapper groupMapper;
  final GroupInvitationMapper groupInvitationMapper;

  const GroupInviteMapper({
    required this.groupMapper,
    required this.groupInvitationMapper,
  });

  @override
  domain.GroupInvite fromEntity(GroupInviteEntity entity) {
    return domain.GroupInvite(
      group:
          entity.group != null ? groupMapper.fromEntity(entity.group!) : null,
      invitation: entity.invitation != null
          ? groupInvitationMapper.fromEntity(entity.invitation!)
          : null,
    );
  }

  @override
  GroupInviteEntity toEntity(domain.GroupInvite item) {
    return GroupInviteEntity(
      group: item.group != null ? groupMapper.toEntity(item.group!) : null,
      invitation: item.invitation != null
          ? groupInvitationMapper.toEntity(item.invitation!)
          : null,
    );
  }
}
