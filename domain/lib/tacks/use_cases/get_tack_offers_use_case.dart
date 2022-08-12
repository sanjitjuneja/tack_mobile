part of tacks;

class GetTackOffersUseCase
    extends FutureUseCase<PaginationModel<Offer>, TackOffersPayload> {
  final TacksRepository _tacksRepository;

  GetTackOffersUseCase({
    required TacksRepository tacksRepository,
  }) : _tacksRepository = tacksRepository;

  @override
  Future<PaginationModel<Offer>> execute(TackOffersPayload params) async {
    return _tacksRepository.getTackOffers(params);
  }
}
