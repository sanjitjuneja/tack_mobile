part of tacks;

abstract class TacksRepository {
  ValueStream<List<Tack>> get tackerTacksStream;

  ValueStream<List<RunnerTack>> get runnerTacksStream;

  Future<List<TemplateTack>> fetchNearbyPopularTacks(
    FetchNearbyPopularTacksPayload payload,
  );

  Future<List<TemplateTack>> fetchGroupPopularTacks(
    FetchGroupPopularTacksPayload payload,
  );

  Future<PaginationModel<RunnerTack>> fetchRunnerTacks(
    FetchRunnerTacksPayload payload,
  );

  Future<PaginationModel<Tack>> fetchTackerTacks(
    FetchTackerTacksPayload payload,
  );

  Future<PaginationModel<Tack>> fetchGroupTacks(FetchGroupTacksPayload payload);

  Future<Tack> createTack(CreateTackPayload payload);

  Future<Tack> updateTack(UpdateTackPayload payload);

  Future<void> startTackByRunner(StartTackPayload payload);

  Future<void> cancelTackByTacker(CancelTackPayload payload);

  Future<void> cancelTackByRunner(CancelTackPayload payload);

  Future<void> completeTackByTacker(CompleteTackPayload payload);

  Future<void> completeTackByRunner(CompleteTackPayload payload);

  Future<PaginationModel<Offer>> fetchTackOffers(FetchTackOffersPayload payload);

  Future<void> makeOffer(MakeOfferPayload payload);

  Future<void> cancelOffer(CancelOfferPayload payload);

  Future<void> acceptOffer(AcceptOfferPayload payload);

  Future<void> rateTack(RateTackPayload payload);
}
