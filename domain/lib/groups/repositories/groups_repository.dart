part of groups;

abstract class GroupsRepository {
  Stream<int> get groupsCountStream;

  int get groupsCount;

  Stream<Group?> get currentGroupStream;

  Group? get currentGroup;

  Stream<WebSocketIntent<GroupDetails>> get groupIntentStream;

  Stream<WebSocketIntent<GroupInvitation>> get groupInvitationIntentStream;

  Future<void> initialLoad();

  Future<GroupDetails> fetchGroup(FetchGroupPayload payload);

  Future<PaginationModel<GroupDetails>> fetchGroups(FetchGroupsPayload payload);

  Future<void> selectGroup(SelectGroupPayload payload);

  Future<Group> createGroup(CreateGroupPayload payload);

  Future<void> leaveGroup(LeaveGroupPayload payload);

  Future<GroupDetails> muteGroup(MuteGroupPayload payload);

  Future<GroupDetails> unMuteGroup(UnMuteGroupPayload payload);

  Future<GroupInviteLink> fetchGroupInviteLink(
    FetchGroupInviteLinkPayload payload,
  );

  Future<GroupInvite> fetchGroupInvite(FetchGroupInvitePayload payload);

  Future<PaginationModel<TackUser>> fetchGroupMembers(
    FetchGroupMembersPayload payload,
  );

  Future<PaginationModel<GroupInvitation>> fetchGroupInvitations(
    FetchGroupInvitationsPayload payload,
  );

  Future<void> acceptGroupInvitation(AcceptGroupInvitationPayload payload);

  Future<void> declineGroupInvitation(DeclineGroupInvitationPayload payload);

  Future<void> dispose();
}
