part of groups;

class ObserveGroupsUseCase extends StreamUseCase<List<GroupDetails>, NoParams> {
  final GroupsRepository _groupsRepository;

  ObserveGroupsUseCase({
    required GroupsRepository groupsRepository,
  }) : _groupsRepository = groupsRepository;

  @override
  Stream<List<GroupDetails>> execute(NoParams params) {
    return _groupsRepository.groupsStream;
  }
}
