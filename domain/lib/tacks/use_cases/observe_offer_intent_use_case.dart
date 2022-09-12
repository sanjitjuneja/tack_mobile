part of tacks;

class ObserveOfferIntentUseCase
    extends StreamUseCase<WebSocketIntent<Offer>, NoParams> {
  final TacksRepository _tacksRepository;

  ObserveOfferIntentUseCase({
    required TacksRepository tacksRepository,
  }) : _tacksRepository = tacksRepository;

  @override
  Stream<WebSocketIntent<Offer>> execute(NoParams params) {
    return _tacksRepository.offerIntentStream;
  }
}
