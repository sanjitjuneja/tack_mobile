part of groups;

class DeclineGroupInvitationUseCase
    extends FutureUseCase<void, DeclineGroupInvitationPayload> {
  final GroupsRepository _groupsRepository;

  DeclineGroupInvitationUseCase({
    required GroupsRepository groupsRepository,
  }) : _groupsRepository = groupsRepository;

  @override
  Future<void> execute(DeclineGroupInvitationPayload params) async {
    return _groupsRepository.declineGroupInvitation(params);
  }
}
