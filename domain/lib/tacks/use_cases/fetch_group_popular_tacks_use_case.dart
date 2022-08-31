part of tacks;

class FetchGroupPopularTacksUseCase
    extends FutureUseCase<List<TemplateTack>, FetchGroupPopularTacksPayload> {
  final TacksRepository _tacksRepository;

  FetchGroupPopularTacksUseCase({
    required TacksRepository tacksRepository,
  }) : _tacksRepository = tacksRepository;

  @override
  Future<List<TemplateTack>> execute(FetchGroupPopularTacksPayload params) async {
    return _tacksRepository.fetchGroupPopularTacks(params);
  }
}
