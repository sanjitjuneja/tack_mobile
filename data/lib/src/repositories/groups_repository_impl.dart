import 'dart:math';

import 'package:core/core.dart';
import 'package:domain/domain.dart' as domain;

import '../entities/entities.dart';
import '../providers/api_provider.dart';
import '../providers/shared_preferences_provider.dart';
import '../providers/web_sockets_handlers.dart';
import '../providers/web_sockets_provider.dart';

class GroupsRepositoryImpl implements domain.GroupsRepository {
  final ApiProvider _apiProvider;
  final SharedPreferencesProvider _sharedPreferencesProvider;
  final WebSocketsProvider _webSocketsProvider;

  late BehaviorSubject<int> _groupsCountStreamController;
  late BehaviorSubject<domain.Group?> _groupStreamController;

  late WebSocketStreamSubscription<domain.GroupDetails>
      _webSocketGroupIntentSubscription;

  GroupsRepositoryImpl({
    required ApiProvider apiProvider,
    required SharedPreferencesProvider sharedPreferencesProvider,
    required WebSocketsProvider webSocketsProvider,
  })  : _apiProvider = apiProvider,
        _sharedPreferencesProvider = sharedPreferencesProvider,
        _webSocketsProvider = webSocketsProvider {
    _groupsCountStreamController = BehaviorSubject<int>.seeded(0);
    final domain.Group? activeGroup =
        _sharedPreferencesProvider.getActiveGroup();
    _groupStreamController = BehaviorSubject<domain.Group?>.seeded(activeGroup);

    _webSocketGroupIntentSubscription = _webSocketsProvider.groupsStream.listen(
      (domain.WebSocketIntent<domain.GroupDetails> intent) {
        if (intent.action.isUpdate && currentGroup?.id == intent.objectId) {
          _groupStreamController.add(intent.object!.group);
        }
      },
    );
  }

  @override
  Stream<int> get groupsCountStream => _groupsCountStreamController.stream;

  @override
  int get groupsCount => _groupsCountStreamController.stream.value;

  @override
  Stream<domain.Group?> get currentGroupStream => _groupStreamController.stream;

  @override
  domain.Group? get currentGroup => _groupStreamController.stream.value;

  @override
  WebSocketStream<domain.GroupDetails> get groupIntentStream =>
      _webSocketsProvider.groupsStream;

  @override
  WebSocketStream<domain.GroupInvitation> get groupInvitationIntentStream =>
      _webSocketsProvider.groupInvitationsStream;

  // TODO: move this to global bloc (or find solution for reload)
  @override
  Future<void> initialLoad() async {
    // Handle of network error, no any action needed on error.
    try {
      final domain.PaginationModel<domain.GroupDetails> groups =
          await fetchGroups(
        const domain.FetchGroupsPayload(),
      );
      await _initialSetActiveGroup(groups);
    } catch (_) {}
  }

  Future<void> _initialSetActiveGroup(
    domain.PaginationModel<domain.GroupDetails> groups,
  ) async {
    final domain.Group? activeGroup = currentGroup;
    final int? activeGroupId =
        _sharedPreferencesProvider.getUser()?.activeGroup;

    if (activeGroup != null && activeGroup.id == activeGroupId) return;

    if (activeGroupId != null) {
      final domain.GroupDetails groupDetails = await fetchGroup(
        domain.FetchGroupPayload(id: activeGroupId),
      );
      _groupStreamController.add(groupDetails.group);
      _sharedPreferencesProvider.setActiveGroup(groupDetails.group);
    } else {
      return _selectRandomGroup(groups: groups);
    }
  }

  @override
  Future<domain.GroupDetails> fetchGroup(
    domain.FetchGroupPayload payload,
  ) async {
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

    _groupsCountStreamController.add(groups.count);

    return groups;
  }

  @override
  Future<void> selectGroup(domain.SelectGroupPayload payload) async {
    if (payload.group?.id == currentGroup?.id) return;

    _groupStreamController.add(payload.group);
    _sharedPreferencesProvider.setActiveGroup(payload.group);
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

    final int newGroupsCount = groupsCount + 1;
    _groupsCountStreamController.add(newGroupsCount);

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

    final int newGroupsCount = max(0, groupsCount - 1);
    _groupsCountStreamController.add(newGroupsCount);
    final int? currentGroupId = currentGroup?.id;

    if (payload.group.id != currentGroupId) return;

    await _selectRandomGroup();
  }

  Future<void> _selectRandomGroup({
    domain.PaginationModel<domain.GroupDetails>? groups,
  }) async {
    final domain.PaginationModel<domain.GroupDetails> groupsData =
        groups ?? await fetchGroups(const domain.FetchGroupsPayload());

    if (groupsData.count == 0) {
      _groupStreamController.add(null);
      _sharedPreferencesProvider.setActiveGroup(null);
    } else {
      await selectGroup(
        domain.SelectGroupPayload(
          group: groupsData.results.first.group,
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

    final int newGroupsCount = groupsCount + 1;
    _groupsCountStreamController.add(newGroupsCount);

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

  @override
  Future<void> dispose() async {
    _groupsCountStreamController.close();
    _groupStreamController.close();

    _webSocketGroupIntentSubscription.cancel();
  }
}
