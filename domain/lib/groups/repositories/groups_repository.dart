part of groups;

abstract class GroupsRepository {
  Future<Group> createGroup(CreateGroupPayload payload);
}
