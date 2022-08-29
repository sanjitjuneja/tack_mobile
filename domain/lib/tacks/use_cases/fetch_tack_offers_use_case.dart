part of tacks;

class FetchTackOffersUseCase
    extends FutureUseCase<PaginationModel<Offer>, FetchTackOffersPayload> {
  final TacksRepository _tacksRepository;

  FetchTackOffersUseCase({
    required TacksRepository tacksRepository,
  }) : _tacksRepository = tacksRepository;

  @override
  Future<PaginationModel<Offer>> execute(FetchTackOffersPayload params) async {
    return _tacksRepository.fetchTackOffers(params);
  }
}
