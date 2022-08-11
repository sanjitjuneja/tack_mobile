part of groups;

class AcceptGroupInvitationUseCase
    extends FutureUseCase<void, AcceptGroupInvitationPayload> {
  final GroupsRepository _groupsRepository;

  AcceptGroupInvitationUseCase({
    required GroupsRepository groupsRepository,
  }) : _groupsRepository = groupsRepository;

  @override
  Future<void> execute(AcceptGroupInvitationPayload params) async {
    return _groupsRepository.acceptGroupInvitation(params);
  }
}
