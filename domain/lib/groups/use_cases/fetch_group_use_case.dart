part of groups;

class LoadGroupUseCase extends FutureUseCase<Group, FetchGroupPayload> {
  final GroupsRepository _groupsRepository;

  LoadGroupUseCase({
    required GroupsRepository groupsRepository,
  }) : _groupsRepository = groupsRepository;

  @override
  Future<Group> execute(FetchGroupPayload params) async {
    return _groupsRepository.fetchGroup(params);
  }
}
