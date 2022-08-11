part of groups;

class LeaveGroupUseCase
    extends FutureUseCase<void, LeaveGroupPayload> {
  final GroupsRepository _groupsRepository;

  LeaveGroupUseCase({
    required GroupsRepository groupsRepository,
  }) : _groupsRepository = groupsRepository;

  @override
  Future<void> execute(LeaveGroupPayload params) async {
    return _groupsRepository.leaveGroup(params);
  }
}
