part of groups;

class UnMuteGroupUseCase extends FutureUseCase<GroupDetails, UnMuteGroupPayload> {
  final GroupsRepository _groupsRepository;

  UnMuteGroupUseCase({
    required GroupsRepository groupsRepository,
  }) : _groupsRepository = groupsRepository;

  @override
  Future<GroupDetails> execute(UnMuteGroupPayload params) async {
    return _groupsRepository.unMuteGroup(params);
  }
}
