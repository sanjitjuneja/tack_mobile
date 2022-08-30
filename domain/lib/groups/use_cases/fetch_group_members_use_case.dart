part of groups;

class FetchGroupMembersUseCase
    extends FutureUseCase<PaginationModel<TackUser>, FetchGroupMembersPayload> {
  final GroupsRepository _groupsRepository;

  FetchGroupMembersUseCase({
    required GroupsRepository groupsRepository,
  }) : _groupsRepository = groupsRepository;

  @override
  Future<PaginationModel<TackUser>> execute(
    FetchGroupMembersPayload params,
  ) async {
    return _groupsRepository.fetchGroupMembers(params);
  }
}
