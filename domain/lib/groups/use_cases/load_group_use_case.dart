part of groups;

class LoadGroupUseCase extends FutureUseCase<Group, GetGroupPayload> {
  final GroupsRepository _groupsRepository;

  LoadGroupUseCase({
    required GroupsRepository groupsRepository,
  }) : _groupsRepository = groupsRepository;

  @override
  Future<Group> execute(GetGroupPayload params) async {
    return _groupsRepository.getGroup(params);
  }
}
