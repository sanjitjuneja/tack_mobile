part of tacks;

class GetTackOffersUseCase
    extends FutureUseCase<List<Offer>, TackOffersPayload> {
  final TacksRepository _tacksRepository;

  GetTackOffersUseCase({
    required TacksRepository tacksRepository,
  }) : _tacksRepository = tacksRepository;

  @override
  Future<List<Offer>> execute(TackOffersPayload params) async {
    return _tacksRepository.getTackOffers(params);
  }
}
