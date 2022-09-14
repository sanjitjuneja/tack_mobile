part of tacks;

abstract class TacksRepository {
  Stream<WebSocketIntent<GroupTack>> get groupTackIntentStream;

  Stream<WebSocketIntent<Tack>> get tackerTackIntentStream;

  Stream<WebSocketIntent<RunnerTack>> get runnerTackIntentStream;

  Stream<WebSocketIntent<Tack>> get completedTacksRunnerIntentStream;

  Stream<WebSocketIntent<Offer>> get offerIntentStream;

  Stream<WebSocketIntent<Tack>> get cancelTackerTackRunnerStream;

  Future<bool> fetchHasRunningTack(FetchHasRunningTackPayload payload);

  Future<List<TemplateTack>> fetchNearbyPopularTacks(
    FetchNearbyPopularTacksPayload payload,
  );

  Future<List<TemplateTack>> fetchGroupPopularTacks(
    FetchGroupPopularTacksPayload payload,
  );

  Future<List<RunnerTack>> fetchRunnerTacks(
    FetchRunnerTacksPayload payload,
  );

  Future<List<Tack>> fetchTackerTacks(
    FetchTackerTacksPayload payload,
  );

  Future<PaginationModel<GroupTack>> fetchGroupTacks(
    FetchGroupTacksPayload payload,
  );

  Future<PaginationModel<Tack>> fetchCompletedTacks(
    FetchCompletedTacksPayload payload,
  );

  Future<PaginationModel<Tack>> fetchCreatedTacks(
    FetchCreatedTacksPayload payload,
  );

  Future<Tack> createTack(CreateTackPayload payload);

  Future<Tack> updateTack(UpdateTackPayload payload);

  Future<void> startTackByRunner(StartTackPayload payload);

  Future<void> cancelTackByTacker(CancelTackPayload payload);

  Future<void> cancelTackByRunner(CancelTackPayload payload);

  Future<void> completeTackByTacker(CompleteTackPayload payload);

  Future<void> completeTackByRunner(CompleteTackPayload payload);

  Future<PaginationModel<Offer>> fetchTackOffers(
    FetchTackOffersPayload payload,
  );

  Future<void> makeOffer(MakeOfferPayload payload);

  Future<void> cancelOffer(CancelOfferPayload payload);

  Future<void> acceptOffer(AcceptOfferPayload payload);

  Future<void> rateTack(RateTackPayload payload);
}
