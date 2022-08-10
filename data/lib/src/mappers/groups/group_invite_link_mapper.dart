part of mappers;

class GroupInviteLinkMapper
    implements Mapper<GroupInviteLinkEntity, domain.GroupInviteLink> {
  const GroupInviteLinkMapper();

  @override
  domain.GroupInviteLink fromEntity(GroupInviteLinkEntity entity) {
    return domain.GroupInviteLink(
      link: entity.inviteLink,
    );
  }

  @override
  GroupInviteLinkEntity toEntity(domain.GroupInviteLink item) {
    return GroupInviteLinkEntity(
      inviteLink: item.link,
    );
  }
}
