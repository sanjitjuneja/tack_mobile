part of groups;

class GetGroupsUseCase extends UseCase<List<Group>, NoParams> {
  final GroupsRepository _groupsRepository;

  GetGroupsUseCase({
    required GroupsRepository groupsRepository,
  }) : _groupsRepository = groupsRepository;

  @override
  List<Group> execute(NoParams params) {
    return _groupsRepository.groups;
  }
}
