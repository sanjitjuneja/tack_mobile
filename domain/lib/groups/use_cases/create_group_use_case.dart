part of groups;

class CreateGroupUseCase extends FutureUseCase<Group, CreateGroupPayload> {
  final GroupsRepository _groupsRepository;

  CreateGroupUseCase({
    required GroupsRepository groupsRepository,
  }) : _groupsRepository = groupsRepository;

  @override
  Future<Group> execute(CreateGroupPayload params) async {
    return _groupsRepository.createGroup(params);
  }
}
