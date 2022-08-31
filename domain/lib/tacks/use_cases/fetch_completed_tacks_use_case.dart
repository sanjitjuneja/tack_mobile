part of tacks;

class FetchCompletedTacksUseCase
    extends FutureUseCase<PaginationModel<Tack>, FetchCompletedTacksPayload> {
  final TacksRepository _tacksRepository;

  FetchCompletedTacksUseCase({
    required TacksRepository tacksRepository,
  }) : _tacksRepository = tacksRepository;

  @override
  Future<PaginationModel<Tack>> execute(
    FetchCompletedTacksPayload params,
  ) async {
    return _tacksRepository.fetchCompletedTacks(params);
  }
}
