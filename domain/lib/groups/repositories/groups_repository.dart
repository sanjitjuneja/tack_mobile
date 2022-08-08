part of groups;

abstract class GroupsRepository {
  Stream<List<Group>> get groupsStream;

  List<Group> get groups;

  Stream<Group?> get currentGroupStream;

  Group? get currentGroup;

  Future<void> initialLoad();

  Future<Group> getGroup(GetGroupPayload payload);

  Future<List<Group>> getGroups(GetGroupsPayload payload);

  Future<void> selectGroup(SelectGroupPayload payload);

  Future<Group> createGroup(CreateGroupPayload payload);
}
