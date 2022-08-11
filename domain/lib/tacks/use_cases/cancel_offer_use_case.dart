part of tacks;

class CancelOfferUseCase extends FutureUseCase<void, CancelOfferPayload> {
  final TacksRepository _tacksRepository;

  CancelOfferUseCase({
    required TacksRepository tacksRepository,
  }) : _tacksRepository = tacksRepository;

  @override
  Future<void> execute(CancelOfferPayload params) async {
    return _tacksRepository.cancelOffer(params);
  }
}
