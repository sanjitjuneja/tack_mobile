part of tacks;

class FetchTackerTacksUseCase
    extends FutureUseCase<List<Tack>, FetchTackerTacksPayload> {
  final TacksRepository _tacksRepository;

  FetchTackerTacksUseCase({
    required TacksRepository tacksRepository,
  }) : _tacksRepository = tacksRepository;

  @override
  Future<List<Tack>> execute(FetchTackerTacksPayload params) async {
    return _tacksRepository.fetchTackerTacks(params);
  }
}
