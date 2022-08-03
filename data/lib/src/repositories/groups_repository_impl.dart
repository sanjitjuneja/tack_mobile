import 'package:data/src/entities/entities.dart';
import 'package:data/src/providers/api_provider.dart';
import 'package:domain/domain.dart' as domain;

class GroupsRepositoryImpl implements domain.GroupsRepository {
  final ApiProvider _apiProvider;

  GroupsRepositoryImpl({
    required ApiProvider apiProvider,
  }) : _apiProvider = apiProvider;

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
