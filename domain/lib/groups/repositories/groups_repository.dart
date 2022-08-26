part of groups;

abstract class GroupsRepository {
  Stream<List<GroupDetails>> get groupsStream;

  List<GroupDetails> get groups;

  Stream<Group?> get currentGroupStream;

  Group? get currentGroup;

  Future<void> initialLoad();

  Future<Group> getGroup(GetGroupPayload payload);

  Future<List<GroupDetails>> getGroups(GetGroupsPayload payload);

  Future<void> selectGroup(SelectGroupPayload payload);

  Future<Group> createGroup(CreateGroupPayload payload);

  Future<void> leaveGroup(LeaveGroupPayload payload);

  Future<GroupDetails> muteGroup(MuteGroupPayload payload);

  Future<GroupDetails> unMuteGroup(UnMuteGroupPayload payload);

  Future<GroupInviteLink> getGroupInviteLink(GetGroupInviteLinkPayload payload);

  Future<GroupInvite> getGroupInvite(GetGroupInvitePayload payload);

  Future<List<TackUser>> getGroupMembers(GetGroupMembersPayload payload);

  Future<List<GroupInvitation>> getInvitations(
    GetGroupInvitationsPayload payload,
  );

  Future<void> acceptGroupInvitation(AcceptGroupInvitationPayload payload);

  Future<void> declineGroupInvitation(DeclineGroupInvitationPayload payload);
}
