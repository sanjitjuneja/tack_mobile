part of groups;

class LoadGroupMembersUseCase
    extends FutureUseCase<List<TackUser>, GetGroupMembersPayload> {
  final GroupsRepository _groupsRepository;

  LoadGroupMembersUseCase({
    required GroupsRepository groupsRepository,
  }) : _groupsRepository = groupsRepository;

  @override
  Future<List<TackUser>> execute(GetGroupMembersPayload params) async {
    return _groupsRepository.getGroupMembers(params);
  }
}
