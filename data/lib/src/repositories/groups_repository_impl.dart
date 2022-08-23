import 'package:core/core.dart';
import 'package:data/src/entities/entities.dart';
import 'package:data/src/providers/api_provider.dart';
import 'package:data/src/providers/shared_preferences_provider.dart';
import 'package:domain/domain.dart' as domain;

class GroupsRepositoryImpl implements domain.GroupsRepository {
  final ApiProvider _apiProvider;
  final SharedPreferencesProvider _sharedPreferencesProvider;

  late BehaviorSubject<List<domain.Group>> _groupsStreamController;

  late BehaviorSubject<domain.Group?> _groupStreamController;

  GroupsRepositoryImpl({
    required ApiProvider apiProvider,
    required SharedPreferencesProvider sharedPreferencesProvider,
  })  : _apiProvider = apiProvider,
        _sharedPreferencesProvider = sharedPreferencesProvider {
    _groupsStreamController = BehaviorSubject<List<domain.Group>>.seeded(
      <domain.Group>[],
    );
    _groupStreamController = BehaviorSubject<domain.Group?>.seeded(null);
  }

  @override
  Stream<List<domain.Group>> get groupsStream => _groupsStreamController.stream;

  @override
  List<domain.Group> get groups => _groupsStreamController.stream.value;

  @override
  Stream<domain.Group?> get currentGroupStream => _groupStreamController.stream;

  @override
  domain.Group? get currentGroup => _groupStreamController.stream.value;

  @override
  Future<void> initialLoad() async {
    // Handle of network error, no any action needed on error.
    try {
      await getGroups(const domain.GetGroupsPayload());
      await _initialSetActiveGroup();
    } catch (_) {}
  }

  Future<void> _initialSetActiveGroup() async {
    final int? activeGroupId = _sharedPreferencesProvider.getActiveGroupId();

    if (activeGroupId == null) return;

    final int groupIndex = _groupsStreamController.stream.value.indexWhere(
      (domain.Group group) => group.id == activeGroupId,
    );

    final domain.Group group;

    if (groupIndex == -1) {
      group = await getGroup(
        domain.GetGroupPayload(id: activeGroupId),
      );
    } else {
      group = _groupsStreamController.stream.value.elementAt(groupIndex);
    }

    _groupStreamController.add(group);
  }

  @override
  Future<domain.Group> getGroup(domain.GetGroupPayload payload) async {
    return _apiProvider.getGroup(
      request: GetGroupRequest(id: payload.id),
    );
  }

  @override
  Future<List<domain.Group>> getGroups(domain.GetGroupsPayload payload) async {
    final List<domain.Group> groups = await _apiProvider.getGroups(
      request: const GetGroupsRequest(),
    );
    _groupsStreamController.add(groups);

    return groups;
  }

  @override
  Future<void> selectGroup(domain.SelectGroupPayload payload) async {
    if (payload.group.id == currentGroup?.id) return;

    _groupStreamController.add(payload.group);
    _sharedPreferencesProvider.setActiveGroupId(payload.group.id);
    try {
      await _apiProvider.selectGroup(
        request: SelectGroupRequest(
          id: payload.group.id,
        ),
      );
    } catch (_) {}
  }

  @override
  Future<domain.Group> createGroup(domain.CreateGroupPayload payload) async {
    final domain.Group group = await _apiProvider.createGroup(
      request: CreateGroupRequest(
        name: payload.name,
        description: payload.description,
        image: payload.image,
      ),
    );
    await selectGroup(domain.SelectGroupPayload(group: group));

    return group;
  }

  @override
  Future<void> leaveGroup(domain.LeaveGroupPayload payload) async {
    await _apiProvider.leaveGroup(
      request: LeaveGroupRequest(
        id: payload.group.id,
      ),
    );

    if (currentGroup?.id == payload.group.id) {
      await selectGroup(
        domain.SelectGroupPayload(
          group: payload.group,
        ),
      );
    }
  }

  @override
  Future<domain.Group> muteGroup(domain.MuteGroupPayload payload) async {
    return _apiProvider.muteGroup(
      request: MuteGroupRequest(
        id: payload.group.id,
      ),
    );
  }

  @override
  Future<domain.Group> unMuteGroup(domain.UnMuteGroupPayload payload) async {
    return _apiProvider.unMuteGroup(
      request: UnMuteGroupRequest(
        id: payload.group.id,
      ),
    );
  }

  @override
  Future<domain.GroupInviteLink> getGroupInviteLink(
    domain.GetGroupInviteLinkPayload payload,
  ) async {
    return _apiProvider.getGroupInviteLink(
      request: GetGroupInviteLinkRequest(
        id: payload.group.id,
      ),
    );
  }

  @override
  Future<domain.GroupInvite> getGroupInvite(
    domain.GetGroupInvitePayload payload,
  ) async {
    return _apiProvider.getGroupInvite(
      request: GetGroupInviteRequest(
        params: payload.uri.queryParameters,
      ),
    );
  }

  @override
  Future<List<domain.TackUser>> getGroupMembers(
    domain.GetGroupMembersPayload payload,
  ) async {
    return _apiProvider.getGroupMembers(
      request: GetGroupMembersRequest(
        id: payload.group.id,
      ),
    );
  }

  @override
  Future<List<domain.GroupInvitation>> getInvitations(
    domain.GetGroupInvitationsPayload payload,
  ) async {
    return _apiProvider.getInvitations(
      request: const GetGroupInvitationsRequest(),
    );
  }

  @override
  Future<void> acceptGroupInvitation(
    domain.AcceptGroupInvitationPayload payload,
  ) async {
    await _apiProvider.acceptGroupInvitation(
      request: AcceptGroupInvitationRequest(
        id: payload.invitation.id,
      ),
    );

    await selectGroup(
      domain.SelectGroupPayload(
        group: payload.invitation.group,
      ),
    );
  }

  @override
  Future<void> declineGroupInvitation(
    domain.DeclineGroupInvitationPayload payload,
  ) async {
    return _apiProvider.declineGroupInvitation(
      request: DeclineGroupInvitationRequest(
        id: payload.invitation.id,
      ),
    );
  }
}
