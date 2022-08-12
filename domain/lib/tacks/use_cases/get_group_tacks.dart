part of tacks;

class GetGroupTacksUseCase
    extends FutureUseCase<PaginationModel<Tack>, GroupTacksPayload> {
  final TacksRepository _tacksRepository;

  GetGroupTacksUseCase({
    required TacksRepository tacksRepository,
  }) : _tacksRepository = tacksRepository;

  @override
  Future<PaginationModel<Tack>> execute(GroupTacksPayload params) async {
    return _tacksRepository.getGroupTacks(params);
  }
}
