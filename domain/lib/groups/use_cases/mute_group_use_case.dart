part of groups;

class MuteGroupUseCase extends FutureUseCase<Group, MuteGroupPayload> {
  final GroupsRepository _groupsRepository;

  MuteGroupUseCase({
    required GroupsRepository groupsRepository,
  }) : _groupsRepository = groupsRepository;

  @override
  Future<Group> execute(MuteGroupPayload params) async {
    return _groupsRepository.muteGroup(params);
  }
}
