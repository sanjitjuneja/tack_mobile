part of groups;

class GetGroupsUseCase extends UseCase<List<GroupDetails>, NoParams> {
  final GroupsRepository _groupsRepository;

  GetGroupsUseCase({
    required GroupsRepository groupsRepository,
  }) : _groupsRepository = groupsRepository;

  @override
  List<GroupDetails> execute(NoParams params) {
    return _groupsRepository.groups;
  }
}
