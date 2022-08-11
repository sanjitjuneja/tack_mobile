part of mappers;

class GroupInvitationMapper
    implements Mapper<GroupInvitationEntity, domain.GroupInvitation> {
  final GroupMapper groupMapper;

  const GroupInvitationMapper({
    required this.groupMapper,
  });

  @override
  domain.GroupInvitation fromEntity(GroupInvitationEntity entity) {
    return domain.GroupInvitation(
      id: entity.id,
      group: groupMapper.fromEntity(entity.group),
      invitee: entity.invitee,
    );
  }

  @override
  GroupInvitationEntity toEntity(domain.GroupInvitation item) {
    return GroupInvitationEntity(
      id: item.id,
      group: groupMapper.toEntity(item.group),
      invitee: item.invitee,
    );
  }
}
