part of tacks;

class GetNearbyPopularTacksUseCase
    extends FutureUseCase<List<TemplateTack>, NearbyPopularTacksPayload> {
  final TacksRepository _tacksRepository;

  GetNearbyPopularTacksUseCase({
    required TacksRepository tacksRepository,
  }) : _tacksRepository = tacksRepository;

  @override
  Future<List<TemplateTack>> execute(NearbyPopularTacksPayload params) async {
    return _tacksRepository.nearbyPopularTacks(params);
  }
}
