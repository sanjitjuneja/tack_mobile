part of mappers;

class GroupInviteMapper
    implements Mapper<GroupInviteEntity, domain.GroupInvite> {
  final GroupDetailsMapper groupDetailsMapper;
  final GroupInvitationMapper groupInvitationMapper;

  const GroupInviteMapper({
    required this.groupDetailsMapper,
    required this.groupInvitationMapper,
  });

  @override
  domain.GroupInvite fromEntity(GroupInviteEntity entity) {
    return domain.GroupInvite(
      groupDetails: entity.groupDetails != null
          ? groupDetailsMapper.fromEntity(entity.groupDetails!)
          : null,
      invitation: entity.invitation != null
          ? groupInvitationMapper.fromEntity(entity.invitation!)
          : null,
    );
  }

  @override
  GroupInviteEntity toEntity(domain.GroupInvite item) {
    return GroupInviteEntity(
      groupDetails: item.groupDetails != null
          ? groupDetailsMapper.toEntity(item.groupDetails!)
          : null,
      invitation: item.invitation != null
          ? groupInvitationMapper.toEntity(item.invitation!)
          : null,
    );
  }
}
