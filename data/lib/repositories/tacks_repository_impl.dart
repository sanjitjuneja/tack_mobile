import 'package:data/entities/entities.dart';
import 'package:data/providers/api_provider.dart';
import 'package:domain/domain.dart' as domain;

class TacksRepositoryImpl implements domain.TacksRepository {
  final ApiProvider _apiProvider;

  TacksRepositoryImpl({
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

  @override
  Future<List<domain.Tack>> getMyTacks() {
    return _apiProvider.getMyTacks();
  }
}
