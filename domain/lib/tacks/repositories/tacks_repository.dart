part of tacks;

abstract class TacksRepository {
  ValueStream<List<Tack>> get tackerTacksStream;

  ValueStream<List<RunnerTack>> get runnerTacksStream;

  Future<List<Tack>> getMyTacks();

  Future<void> rateTack(RateTackPayload payload);
}