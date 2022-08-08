import 'package:core/core.dart';
import 'package:data/src/entities/entities.dart';
import 'package:data/src/providers/api_provider.dart';
import 'package:domain/domain.dart' as domain;

class GroupsRepositoryImpl implements domain.GroupsRepository {
  final ApiProvider _apiProvider;
  final domain.UserRepository _userRepository;

  late BehaviorSubject<List<domain.Group>> _groupsStreamController;

  @override
  Stream<List<domain.Group>> get groupsStream => _groupsStreamController.stream;

  @override
  List<domain.Group> get groups => _groupsStreamController.stream.value;

  late BehaviorSubject<domain.Group?> _groupStreamController;

  @override
  Stream<domain.Group?> get currentGroupStream => _groupStreamController.stream;

  @override
  domain.Group? get currentGroup => _groupStreamController.stream.value;

  GroupsRepositoryImpl({
    required ApiProvider apiProvider,
    required domain.UserRepository userRepository,
  })  : _apiProvider = apiProvider,
        _userRepository = userRepository {
    _groupsStreamController = BehaviorSubject<List<domain.Group>>.seeded(
      <domain.Group>[],
    );
    _groupStreamController = BehaviorSubject<domain.Group?>.seeded(null);
  }

  @override
  Future<void> initialLoad() async {
    await getGroups(const domain.GetGroupsPayload());
    final domain.User user = _userRepository.currentUser;
    if (user.activeGroup != null) {
      await getGroup(
        domain.GetGroupPayload(id: user.activeGroup!),
      );
    }
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
    _groupStreamController.add(payload.group);
    try {
      await _apiProvider.selectGroup(
        request: SelectGroupRequest(
          id: payload.group.id,
        ),
      );
    } catch (_) {}
  }

  @override
  Future<domain.Group> createGroup(domain.CreateGroupPayload payload) {
    return _apiProvider.createGroup(
      request: CreateGroupRequest(
        name: payload.name,
        description: payload.description,
        image: payload.image,
      ),
    );
  }
}
