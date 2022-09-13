part of groups;

class GetGroupsCountUseCase extends UseCase<int, NoParams> {
  final GroupsRepository _groupsRepository;

  GetGroupsCountUseCase({
    required GroupsRepository groupsRepository,
  }) : _groupsRepository = groupsRepository;

  @override
  int execute(NoParams params) {
    return _groupsRepository.groupsCount;
  }
}
