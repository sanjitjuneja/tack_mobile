part of groups;

class LoadGroupsUseCase
    extends FutureUseCase<List<GroupDetails>, GetGroupsPayload> {
  final GroupsRepository _groupsRepository;

  LoadGroupsUseCase({
    required GroupsRepository groupsRepository,
  }) : _groupsRepository = groupsRepository;

  @override
  Future<List<GroupDetails>> execute(GetGroupsPayload params) async {
    return _groupsRepository.getGroups(params);
  }
}
