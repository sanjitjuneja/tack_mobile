part of groups;

class LoadGroupInvitationsUseCase
    extends FutureUseCase<List<GroupInvitation>, GetGroupInvitationsPayload> {
  final GroupsRepository _groupsRepository;

  LoadGroupInvitationsUseCase({
    required GroupsRepository groupsRepository,
  }) : _groupsRepository = groupsRepository;

  @override
  Future<List<GroupInvitation>> execute(
    GetGroupInvitationsPayload params,
  ) async {
    return _groupsRepository.getInvitations(params);
  }
}
