part of tacks;

class FetchGroupTacksUseCase
    extends FutureUseCase<PaginationModel<GroupTack>, FetchGroupTacksPayload> {
  final TacksRepository _tacksRepository;

  FetchGroupTacksUseCase({
    required TacksRepository tacksRepository,
  }) : _tacksRepository = tacksRepository;

  @override
  Future<PaginationModel<GroupTack>> execute(
    FetchGroupTacksPayload params,
  ) async {
    return _tacksRepository.fetchGroupTacks(params);
  }
}
