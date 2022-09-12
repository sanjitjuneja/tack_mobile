part of groups;

class ObserveGroupInvitationIntentUseCase
    extends StreamUseCase<WebSocketIntent<GroupInvitation>, NoParams> {
  final GroupsRepository _groupsRepository;

  ObserveGroupInvitationIntentUseCase({
    required GroupsRepository groupsRepository,
  }) : _groupsRepository = groupsRepository;

  @override
  Stream<WebSocketIntent<GroupInvitation>> execute(NoParams params) {
    return _groupsRepository.groupInvitationIntentStream;
  }
}
