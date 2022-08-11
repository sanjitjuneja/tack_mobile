part of groups;

class LoadGroupInviteLinkUseCase
    extends FutureUseCase<GroupInviteLink, GetGroupInviteLinkPayload> {
  final GroupsRepository _groupsRepository;

  LoadGroupInviteLinkUseCase({
    required GroupsRepository groupsRepository,
  }) : _groupsRepository = groupsRepository;

  @override
  Future<GroupInviteLink> execute(GetGroupInviteLinkPayload params) async {
    return _groupsRepository.getGroupInviteLink(params);
  }
}
