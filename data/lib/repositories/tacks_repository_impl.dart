import 'package:data/entities/tacks/tacks.dart';
import 'package:data/providers/api_provider.dart';
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