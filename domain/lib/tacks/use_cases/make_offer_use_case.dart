part of tacks;

class MakeOfferUseCase extends FutureUseCase<void, MakeOfferPayload> {
  final TacksRepository _tacksRepository;

  MakeOfferUseCase({
    required TacksRepository tacksRepository,
  }) : _tacksRepository = tacksRepository;

  @override
  Future<void> execute(MakeOfferPayload params) async {
    return _tacksRepository.makeOffer(params);
  }
}
