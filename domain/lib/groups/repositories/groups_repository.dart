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

  Future<void> leaveGroup(LeaveGroupPayload payload);

  Future<Group> muteGroup(MuteGroupPayload payload);

  Future<Group> unMuteGroup(UnMuteGroupPayload payload);

  Future<GroupInviteLink> getGroupInviteLink(GetGroupInviteLinkPayload payload);

  Future<List<TackUser>> getGroupMembers(GetGroupMembersPayload payload);

  Future<List<GroupInvitation>> getInvitations(
    GetGroupInvitationsPayload payload,
  );

  Future<void> acceptGroupInvitation(AcceptGroupInvitationPayload payload);

  Future<void> declineGroupInvitation(DeclineGroupInvitationPayload payload);
}
