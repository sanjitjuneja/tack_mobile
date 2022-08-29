part of tacks;

class FetchGroupTacksUseCase
    extends FutureUseCase<PaginationModel<Tack>, FetchGroupTacksPayload> {
  final TacksRepository _tacksRepository;

  FetchGroupTacksUseCase({
    required TacksRepository tacksRepository,
  }) : _tacksRepository = tacksRepository;

  @override
  Future<PaginationModel<Tack>> execute(FetchGroupTacksPayload params) async {
    return _tacksRepository.fetchGroupTacks(params);
  }
}
