part of groups;

class UnMuteGroupUseCase extends FutureUseCase<Group, UnMuteGroupPayload> {
  final GroupsRepository _groupsRepository;

  UnMuteGroupUseCase({
    required GroupsRepository groupsRepository,
  }) : _groupsRepository = groupsRepository;

  @override
  Future<Group> execute(UnMuteGroupPayload params) async {
    return _groupsRepository.unMuteGroup(params);
  }
}
