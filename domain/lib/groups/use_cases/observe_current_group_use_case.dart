part of groups;

class ObserveCurrentGroupUseCase extends StreamUseCase<Group?, NoParams> {
  final GroupsRepository _groupsRepository;

  ObserveCurrentGroupUseCase({
    required GroupsRepository groupsRepository,
  }) : _groupsRepository = groupsRepository;

  @override
  Stream<Group?> execute(NoParams params) {
    return _groupsRepository.currentGroupStream;
  }
}
