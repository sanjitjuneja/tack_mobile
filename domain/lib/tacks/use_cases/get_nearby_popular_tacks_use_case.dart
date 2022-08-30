part of tacks;

class FetchNearbyPopularTacksUseCase
    extends FutureUseCase<List<TemplateTack>, FetchNearbyPopularTacksPayload> {
  final TacksRepository _tacksRepository;

  FetchNearbyPopularTacksUseCase({
    required TacksRepository tacksRepository,
  }) : _tacksRepository = tacksRepository;

  @override
  Future<List<TemplateTack>> execute(FetchNearbyPopularTacksPayload params) async {
    return _tacksRepository.fetchNearbyPopularTacks(params);
  }
}
