part of tacks;

class FetchCreatedTacksUseCase
    extends FutureUseCase<PaginationModel<Tack>, FetchCreatedTacksPayload> {
  final TacksRepository _tacksRepository;

  FetchCreatedTacksUseCase({
    required TacksRepository tacksRepository,
  }) : _tacksRepository = tacksRepository;

  @override
  Future<PaginationModel<Tack>> execute(
    FetchCreatedTacksPayload params,
  ) async {
    return _tacksRepository.fetchCreatedTacks(params);
  }
}
