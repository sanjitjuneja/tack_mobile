part of groups;

class ObserveGroupsUseCase extends StreamUseCase<List<Group>, NoParams> {
  final GroupsRepository _groupsRepository;

  ObserveGroupsUseCase({
    required GroupsRepository groupsRepository,
  }) : _groupsRepository = groupsRepository;

  @override
  Stream<List<Group>> execute(NoParams params) {
    return _groupsRepository.groupsStream;
  }
}
