import 'package:data/src/entities/entities.dart';
import 'package:data/src/providers/api_provider.dart';
import 'package:core/core.dart';
import 'package:domain/domain.dart' as domain;

class TacksRepositoryImpl implements domain.TacksRepository {
  final ApiProvider _apiProvider;

  late BehaviorSubject<List<domain.Tack>> _tackerTacksStreamController;
  late BehaviorSubject<List<domain.RunnerTack>> _runnerTacksStreamController;

  @override
  ValueStream<List<domain.Tack>> get tackerTacksStream =>
      _tackerTacksStreamController;

  @override
  ValueStream<List<domain.RunnerTack>> get runnerTacksStream =>
      _runnerTacksStreamController;

  TacksRepositoryImpl({
    required ApiProvider apiProvider,
  }) : _apiProvider = apiProvider {
    _tackerTacksStreamController =
        BehaviorSubject<List<domain.Tack>>.seeded(<domain.Tack>[]);
    _runnerTacksStreamController =
        BehaviorSubject<List<domain.RunnerTack>>.seeded(<domain.RunnerTack>[]);
  }

  @override
  Future<List<domain.Tack>> getMyTacks() async {
    final List<domain.Tack> tacks = await _apiProvider.getMyTacks();
    _tackerTacksStreamController.add(tacks);

    return tacks;
  }

  @override
  Future<List<domain.Tack>> getGroupTacks(
    domain.GroupTacksPayload payload,
  ) async {
    return _apiProvider.getGroupTacks(
      GroupTacksRequest(groupId: payload.groupId),
    );
  }

  @override
  Future<void> updateTack(domain.UpdateTackPayload payload) async {
    return _apiProvider.updateTack(
      UpdateTackRequest(
        id: payload.tackId,
        title: payload.title,
        price: payload.price.toString(),
        description: payload.description,
        estimationTimeSeconds: payload.estimatedTime,
        allowCounterOffer: payload.shouldAllowCounterOffers,
      ),
    );
  }

  @override
  Future<void> rateTack(domain.RateTackPayload payload) async {
    return _apiProvider.rateTack(
      RateTackRequest(
        tack: payload.tackId,
        description: payload.comment,
        rating: payload.rating,
      ),
    );
  }
}
