part of groups;

class ObserveGroupsCountUseCase extends StreamUseCase<int, NoParams> {
  final GroupsRepository _groupsRepository;

  ObserveGroupsCountUseCase({
    required GroupsRepository groupsRepository,
  }) : _groupsRepository = groupsRepository;

  @override
  Stream<int> execute(NoParams params) {
    return _groupsRepository.groupsCountStream;
  }
}
