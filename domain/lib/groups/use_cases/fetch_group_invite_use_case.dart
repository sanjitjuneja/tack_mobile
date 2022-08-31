part of groups;

class FetchGroupInviteUseCase
    extends FutureUseCase<GroupInvite, FetchGroupInvitePayload> {
  final GroupsRepository _groupsRepository;

  FetchGroupInviteUseCase({
    required GroupsRepository groupsRepository,
  }) : _groupsRepository = groupsRepository;

  @override
  Future<GroupInvite> execute(FetchGroupInvitePayload params) {
    return _groupsRepository.fetchGroupInvite(params);
  }
}
