part of groups;

class GetCurrentGroupUseCase extends UseCase<Group?, NoParams> {
  final GroupsRepository _groupsRepository;

  GetCurrentGroupUseCase({
    required GroupsRepository groupsRepository,
  }) : _groupsRepository = groupsRepository;

  @override
  Group? execute(NoParams params) {
    return _groupsRepository.currentGroup;
  }
}
