part of groups;

class LoadGroupsUseCase extends FutureUseCase<List<Group>, GetGroupsPayload> {
  final GroupsRepository _groupsRepository;

  LoadGroupsUseCase({
    required GroupsRepository groupsRepository,
  }) : _groupsRepository = groupsRepository;

  @override
  Future<List<Group>> execute(GetGroupsPayload params) async {
    return _groupsRepository.getGroups(params);
  }
}
