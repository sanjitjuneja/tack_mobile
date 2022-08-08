part of groups;

class SelectGroupUseCase extends FutureUseCase<void, SelectGroupPayload> {
  final GroupsRepository _groupsRepository;

  SelectGroupUseCase({
    required GroupsRepository groupsRepository,
  }) : _groupsRepository = groupsRepository;

  @override
  Future<void> execute(SelectGroupPayload params) async {
    return _groupsRepository.selectGroup(params);
  }
}
