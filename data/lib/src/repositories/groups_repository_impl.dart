import 'package:core/core.dart';
import 'package:domain/domain.dart' as domain;

import '../entities/entities.dart';
import '../providers/api_provider.dart';
import '../providers/shared_preferences_provider.dart';

class GroupsRepositoryImpl implements domain.GroupsRepository {
  final ApiProvider _apiProvider;
  final SharedPreferencesProvider _sharedPreferencesProvider;

  late BehaviorSubject<List<domain.GroupDetails>> _groupsStreamController;

  late BehaviorSubject<domain.Group?> _groupStreamController;

  GroupsRepositoryImpl({
    required ApiProvider apiProvider,
    required SharedPreferencesProvider sharedPreferencesProvider,
  })  : _apiProvider = apiProvider,
        _sharedPreferencesProvider = sharedPreferencesProvider {
    _groupsStreamController = BehaviorSubject<List<domain.GroupDetails>>.seeded(
      <domain.GroupDetails>[],
    );
    _groupStreamController = BehaviorSubject<domain.Group?>.seeded(null);
  }

  @override
  Stream<List<domain.GroupDetails>> get groupsStream =>
      _groupsStreamController.stream;

  @override
  List<domain.GroupDetails> get groups => _groupsStreamController.stream.value;

  @override
  Stream<domain.Group?> get currentGroupStream => _groupStreamController.stream;

  @override
  domain.Group? get currentGroup => _groupStreamController.stream.value;

  @override
  Future<void> initialLoad() async {
    // Handle of network error, no any action needed on error.
    try {
      await fetchGroups(const domain.FetchGroupsPayload());
      await _initialSetActiveGroup();
    } catch (_) {}
  }

  Future<void> _initialSetActiveGroup() async {
    final int? activeGroupId = _sharedPreferencesProvider.getActiveGroupId();

    if (activeGroupId == null) return;

    final int groupIndex = _groupsStreamController.stream.value.indexWhere(
      (domain.GroupDetails groupDetails) =>
          groupDetails.group.id == activeGroupId,
    );

    final domain.Group group;

    if (groupIndex == -1) {
      group = await fetchGroup(
        domain.FetchGroupPayload(id: activeGroupId),
      );
    } else {
      group = _groupsStreamController.stream.value.elementAt(groupIndex).group;
    }

    _groupStreamController.add(group);
  }

  @override
  Future<domain.Group> fetchGroup(domain.FetchGroupPayload payload) async {
    return _apiProvider.fetchGroup(
      request: FetchGroupRequest(
        id: payload.id,
      ),
    );
  }

  @override
  Future<domain.PaginationModel<domain.GroupDetails>> fetchGroups(
    domain.FetchGroupsPayload payload,
  ) async {
    final domain.PaginationModel<domain.GroupDetails> groups =
        await _apiProvider.fetchGroups(
      request: FetchGroupsRequest(
        lastObjectId: payload.lastObjectId,
        queryParameters: payload.queryParameters,
      ),
    );
    if (payload.queryParameters == null) {
      _groupsStreamController.add(groups.results);
    }

    return groups;
  }

  @override
  Future<void> selectGroup(domain.SelectGroupPayload payload) async {
    if (payload.group?.id == currentGroup?.id) return;

    _groupStreamController.add(payload.group);
    _sharedPreferencesProvider.setActiveGroupId(payload.group?.id);
    if (payload.group == null) return;

    try {
      await _apiProvider.selectGroup(
        request: SelectGroupRequest(
          id: payload.group!.id,
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
    await selectGroup(
      domain.SelectGroupPayload(group: group),
    );

    return group;
  }

  @override
  Future<void> leaveGroup(domain.LeaveGroupPayload payload) async {
    await _apiProvider.leaveGroup(
      request: LeaveGroupRequest(
        id: payload.group.id,
      ),
    );
    _groupsStreamController.add(
      _groupsStreamController.value
        ..removeWhere(
          (domain.GroupDetails element) => element.id == payload.group.id,
        ),
    );
    if (currentGroup?.id == payload.group.id) {
      await selectGroup(
        domain.SelectGroupPayload(
          group: _groupsStreamController.value.lastOrNull?.group,
        ),
      );
    }
  }

  @override
  Future<domain.GroupDetails> muteGroup(
    domain.MuteGroupPayload payload,
  ) async {
    return _apiProvider.muteGroup(
      request: MuteGroupRequest(
        id: payload.group.id,
      ),
    );
  }

  @override
  Future<domain.GroupDetails> unMuteGroup(
    domain.UnMuteGroupPayload payload,
  ) async {
    return _apiProvider.unMuteGroup(
      request: UnMuteGroupRequest(
        id: payload.group.id,
      ),
    );
  }

  @override
  Future<domain.GroupInviteLink> fetchGroupInviteLink(
    domain.FetchGroupInviteLinkPayload payload,
  ) async {
    return _apiProvider.fetchGroupInviteLink(
      request: FetchGroupInviteLinkRequest(
        id: payload.group.id,
      ),
    );
  }

  @override
  Future<domain.GroupInvite> fetchGroupInvite(
    domain.FetchGroupInvitePayload payload,
  ) async {
    return _apiProvider.fetchGroupInvite(
      request: FetchGroupInviteRequest(
        params: payload.uri.queryParameters,
      ),
    );
  }

  @override
  Future<domain.PaginationModel<domain.TackUser>> fetchGroupMembers(
    domain.FetchGroupMembersPayload payload,
  ) async {
    return _apiProvider.fetchGroupMembers(
      request: FetchGroupMembersRequest(
        groupId: payload.group.id,
        lastObjectId: payload.lastObjectId,
        queryParameters: payload.queryParameters,
      ),
    );
  }

  @override
  Future<domain.PaginationModel<domain.GroupInvitation>> fetchGroupInvitations(
    domain.FetchGroupInvitationsPayload payload,
  ) async {
    return _apiProvider.fetchGroupInvitations(
      request: FetchGroupInvitationsRequest(
        lastObjectId: payload.lastObjectId,
        queryParameters: payload.queryParameters,
      ),
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
