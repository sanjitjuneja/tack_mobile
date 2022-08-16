part of groups;

class GetGroupInviteUseCase
    extends FutureUseCase<GroupInvite, GetGroupInvitePayload> {
  final GroupsRepository _groupsRepository;

  GetGroupInviteUseCase({
    required GroupsRepository groupsRepository,
  }) : _groupsRepository = groupsRepository;

  @override
  Future<GroupInvite> execute(GetGroupInvitePayload params) {
    return _groupsRepository.getGroupInvite(params);
  }
}
