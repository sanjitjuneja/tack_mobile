part of groups;

class MuteGroupUseCase extends FutureUseCase<GroupDetails, MuteGroupPayload> {
  final GroupsRepository _groupsRepository;

  MuteGroupUseCase({
    required GroupsRepository groupsRepository,
  }) : _groupsRepository = groupsRepository;

  @override
  Future<GroupDetails> execute(MuteGroupPayload params) async {
    return _groupsRepository.muteGroup(params);
  }
}
