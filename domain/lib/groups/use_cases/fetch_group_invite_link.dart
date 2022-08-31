part of groups;

class FetchGroupInviteLinkUseCase
    extends FutureUseCase<GroupInviteLink, FetchGroupInviteLinkPayload> {
  final GroupsRepository _groupsRepository;

  FetchGroupInviteLinkUseCase({
    required GroupsRepository groupsRepository,
  }) : _groupsRepository = groupsRepository;

  @override
  Future<GroupInviteLink> execute(FetchGroupInviteLinkPayload params) async {
    return _groupsRepository.fetchGroupInviteLink(params);
  }
}
