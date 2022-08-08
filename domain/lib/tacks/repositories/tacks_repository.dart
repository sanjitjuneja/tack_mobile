part of tacks;

abstract class TacksRepository {
  ValueStream<List<Tack>> get tackerTacksStream;

  ValueStream<List<RunnerTack>> get runnerTacksStream;

  Future<List<TemplateTack>> nearbyPopularTacks(
    NearbyPopularTacksPayload payload,
  );

  Future<List<TemplateTack>> groupPopularTacks(
    GroupPopularTacksPayload payload,
  );

  Future<List<RunnerTack>> getRunnerTacks();

  Future<List<Tack>> getTackerTacks();

  Future<List<Tack>> getGroupTacks(GroupTacksPayload payload);

  Future<Tack> createTack(CreateTackPayload payload);

  Future<Tack> updateTack(UpdateTackPayload payload);

  Future<void> makeOffer(MakeOfferPayload payload);

  Future<void> rateTack(RateTackPayload payload);
}
