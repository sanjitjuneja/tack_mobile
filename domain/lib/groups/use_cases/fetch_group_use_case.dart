part of groups;

class FetchGroupUseCase extends FutureUseCase<GroupDetails, FetchGroupPayload> {
  final GroupsRepository _groupsRepository;

  FetchGroupUseCase({
    required GroupsRepository groupsRepository,
  }) : _groupsRepository = groupsRepository;

  @override
  Future<GroupDetails> execute(FetchGroupPayload params) async {
    return _groupsRepository.fetchGroup(params);
  }
}
