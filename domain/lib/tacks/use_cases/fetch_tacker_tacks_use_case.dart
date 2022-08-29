part of tacks;

class FetchTackerTacksUseCase
    extends FutureUseCase<PaginationModel<Tack>, FetchTackerTacksPayload> {
  final TacksRepository _tacksRepository;

  FetchTackerTacksUseCase({
    required TacksRepository tacksRepository,
  }) : _tacksRepository = tacksRepository;

  @override
  Future<PaginationModel<Tack>> execute(FetchTackerTacksPayload params) async {
    return _tacksRepository.fetchTackerTacks(params);
  }
}
