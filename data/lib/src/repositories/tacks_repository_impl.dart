import 'package:data/src/entities/entities.dart';
import 'package:data/src/providers/api_provider.dart';
import 'package:core/core.dart';
import 'package:domain/domain.dart' as domain;

class TacksRepositoryImpl implements domain.TacksRepository {
  final ApiProvider _apiProvider;

  late BehaviorSubject<List<domain.Tack>> _tackerTacksStreamController;
  late BehaviorSubject<List<domain.RunnerTack>> _runnerTacksStreamController;

  TacksRepositoryImpl({
    required ApiProvider apiProvider,
  }) : _apiProvider = apiProvider {
    _tackerTacksStreamController =
        BehaviorSubject<List<domain.Tack>>.seeded(<domain.Tack>[]);
    _runnerTacksStreamController =
        BehaviorSubject<List<domain.RunnerTack>>.seeded(<domain.RunnerTack>[]);
  }

  @override
  ValueStream<List<domain.Tack>> get tackerTacksStream =>
      _tackerTacksStreamController;

  @override
  ValueStream<List<domain.RunnerTack>> get runnerTacksStream =>
      _runnerTacksStreamController;

  @override
  Future<List<domain.TemplateTack>> fetchNearbyPopularTacks(
    domain.FetchNearbyPopularTacksPayload payload,
  ) async {
    return _apiProvider.fetchNearbyPopularTacks(
      request: const FetchNearbyPopularTacksRequest(),
    );
  }

  @override
  Future<List<domain.TemplateTack>> fetchGroupPopularTacks(
    domain.FetchGroupPopularTacksPayload payload,
  ) async {
    return _apiProvider.fetchGroupPopularTacks(
      request: FetchGroupPopularTacksRequest(groupId: payload.groupId),
    );
  }

  @override
  Future<domain.PaginationModel<domain.RunnerTack>> fetchRunnerTacks(
    domain.FetchRunnerTacksPayload payload,
  ) async {
    final domain.PaginationModel<domain.RunnerTack> tacks =
        await _apiProvider.fetchRunnerTacks(
      FetchRunnerTacksRequest(
        lastObjectId: payload.lastObjectId,
        queryParameters: payload.queryParameters,
      ),
    );
    if (payload.queryParameters == null) {
      _runnerTacksStreamController.add(tacks.results);
    }

    return tacks;
  }

  @override
  Future<domain.PaginationModel<domain.Tack>> fetchTackerTacks(
    domain.FetchTackerTacksPayload payload,
  ) async {
    final domain.PaginationModel<domain.Tack> tacks =
        await _apiProvider.fetchTackerTacks(
      FetchTackerTacksRequest(
        lastObjectId: payload.lastObjectId,
        queryParameters: payload.queryParameters,
      ),
    );
    if (payload.queryParameters == null) {
      _tackerTacksStreamController.add(tacks.results);
    }

    return tacks;
  }

  @override
  Future<domain.PaginationModel<domain.GroupTack>> fetchGroupTacks(
    domain.FetchGroupTacksPayload payload,
  ) async {
    return _apiProvider.fetchGroupTacks(
      FetchGroupsTacksRequest(
        groupId: payload.groupId,
        lastObjectId: payload.lastObjectId,
        queryParameters: payload.queryParameters,
      ),
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
    return _apiProvider.completeTackByTacker(
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
  Future<domain.PaginationModel<domain.Offer>> fetchTackOffers(
    domain.FetchTackOffersPayload payload,
  ) async {
    return _apiProvider.fetchTackOffers(
      FetchTackOffersRequest(
        tackId: payload.tack.id,
        lastObjectId: payload.lastObjectId,
        queryParameters: payload.queryParameters,
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
      CancelOfferRequest(
        offerId: payload.offer.id,
      ),
    );
  }

  @override
  Future<void> acceptOffer(domain.AcceptOfferPayload payload) async {
    return _apiProvider.acceptOffer(
      AcceptOfferRequest(
        offerId: payload.offer.id,
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
