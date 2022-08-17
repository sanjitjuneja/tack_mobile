part of tacks;

class AcceptOfferUseCase extends FutureUseCase<void, AcceptOfferPayload> {
  final TacksRepository _tacksRepository;

  AcceptOfferUseCase({
    required TacksRepository tacksRepository,
  }) : _tacksRepository = tacksRepository;

  @override
  Future<void> execute(AcceptOfferPayload params) async {
    return _tacksRepository.acceptOffer(params);
  }
}
