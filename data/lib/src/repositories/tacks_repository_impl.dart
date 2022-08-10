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
  Future<List<domain.TemplateTack>> nearbyPopularTacks(
    domain.NearbyPopularTacksPayload payload,
  ) async {
    return _apiProvider.getNearbyPopularTacks(
      request: const NearbyPopularTacksRequest(),
    );
  }

  @override
  Future<List<domain.TemplateTack>> groupPopularTacks(
    domain.GroupPopularTacksPayload payload,
  ) async {
    return _apiProvider.getGroupPopularTacks(
      request: GroupPopularTacksRequest(groupId: payload.groupId),
    );
  }

  @override
  Future<List<domain.RunnerTack>> getRunnerTacks() async {
    final List<domain.RunnerTack> tacks = await _apiProvider.getRunnerTacks();
    _runnerTacksStreamController.add(tacks);

    return tacks;
  }

  @override
  Future<List<domain.Tack>> getTackerTacks() async {
    final List<domain.Tack> tacks = await _apiProvider.getTackerTacks();
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
  Future<domain.Tack> createTack(domain.CreateTackPayload payload) async {
    return _apiProvider.createTack(
      CreateTackRequest(
        title: payload.title,
        price: payload.price,
        description: payload.description,
        estimationTimeSeconds: payload.estimatedTime,
        allowCounterOffer: payload.shouldAllowCounterOffers,
        group: payload.groupId,
      ),
    );
  }

  @override
  Future<domain.Tack> updateTack(domain.UpdateTackPayload payload) async {
    return _apiProvider.updateTack(
      UpdateTackRequest(
        id: payload.tackId,
        title: payload.title,
        price: payload.price,
        description: payload.description,
        estimationTimeSeconds: payload.estimatedTime,
        allowCounterOffer: payload.shouldAllowCounterOffers,
      ),
    );
  }

  @override
  Future<void> startTackByRunner(domain.StartTackPayload payload) async {
    return _apiProvider.startTackByRunner(
      StartTackRequest(
        tackId: payload.tack.id,
      ),
    );
  }

  @override
  Future<void> cancelTackByTacker(domain.CancelTackPayload payload) async {
    return _apiProvider.cancelTackByTacker(
      CancelTackRequest(
        tackId: payload.tack.id,
      ),
    );
  }

  @override
  Future<void> cancelTackByRunner(domain.CancelTackPayload payload) async {
    // TODO: replace by canceling by runner
    return _apiProvider.cancelTackByTacker(
      CancelTackRequest(
        tackId: payload.tack.id,
      ),
    );
  }

  @override
  Future<void> completeTackByTacker(domain.CompleteTackPayload payload) async {
    // TODO: replace by canceling by tacker
    return _apiProvider.completeTackByRunner(
      CompleteTackRequest(
        tackId: payload.tack.id,
      ),
    );
  }

  @override
  Future<void> completeTackByRunner(domain.CompleteTackPayload payload) async {
    return _apiProvider.completeTackByRunner(
      CompleteTackRequest(
        tackId: payload.tack.id,
      ),
    );
  }

  @override
  Future<List<domain.Offer>> getTackOffers(
    domain.TackOffersPayload payload,
  ) async {
    return _apiProvider.getTackOffers(
      GetTackOffersRequest(
        tackId: payload.tack.id,
      ),
    );
  }

  @override
  Future<void> makeOffer(domain.MakeOfferPayload payload) async {
    return _apiProvider.makeOffer(
      MakeOfferRequest(
        tack: payload.tackId,
        price: payload.price,
      ),
    );
  }

  @override
  Future<void> cancelOffer(domain.CancelOfferPayload payload) async {
    return _apiProvider.cancelOffer(
      CancelOfferRequest(tackId: payload.tack.id),
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
