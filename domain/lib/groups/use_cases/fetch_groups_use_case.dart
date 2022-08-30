part of groups;

class LoadGroupsUseCase
    extends FutureUseCase<PaginationModel<GroupDetails>, FetchGroupsPayload> {
  final GroupsRepository _groupsRepository;

  LoadGroupsUseCase({
    required GroupsRepository groupsRepository,
  }) : _groupsRepository = groupsRepository;

  @override
  Future<PaginationModel<GroupDetails>> execute(
    FetchGroupsPayload params,
  ) async {
    return _groupsRepository.fetchGroups(params);
  }
}
