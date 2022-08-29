part of groups;

class FetchGroupInvitationsUseCase extends FutureUseCase<
    PaginationModel<GroupInvitation>, FetchGroupInvitationsPayload> {
  final GroupsRepository _groupsRepository;

  FetchGroupInvitationsUseCase({
    required GroupsRepository groupsRepository,
  }) : _groupsRepository = groupsRepository;

  @override
  Future<PaginationModel<GroupInvitation>> execute(
    FetchGroupInvitationsPayload params,
  ) async {
    return _groupsRepository.fetchGroupInvitations(params);
  }
}
