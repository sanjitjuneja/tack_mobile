part of groups;

class ObserveGroupIntentUseCase
    extends StreamUseCase<WebSocketIntent<GroupDetails>, NoParams> {
  final GroupsRepository _groupsRepository;

  ObserveGroupIntentUseCase({
    required GroupsRepository groupsRepository,
  }) : _groupsRepository = groupsRepository;

  @override
  Stream<WebSocketIntent<GroupDetails>> execute(NoParams params) {
    return _groupsRepository.groupIntentStream;
  }
}
