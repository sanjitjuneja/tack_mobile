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

  Future<void> startTackByRunner(StartTackPayload payload);

  Future<void> cancelTackByTacker(CancelTackPayload payload);

  Future<void> cancelTackByRunner(CancelTackPayload payload);

  Future<void> completeTackByTacker(CompleteTackPayload payload);

  Future<void> completeTackByRunner(CompleteTackPayload payload);

  Future<List<Offer>> getTackOffers(TackOffersPayload payload);

  Future<void> makeOffer(MakeOfferPayload payload);

  Future<void> cancelOffer(CancelOfferPayload payload);

  Future<void> rateTack(RateTackPayload payload);
}
