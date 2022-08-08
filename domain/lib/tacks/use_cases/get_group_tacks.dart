part of tacks;

class GetGroupTacksUseCase
    extends FutureUseCase<List<Tack>, GroupTacksPayload> {
  final TacksRepository _tacksRepository;

  GetGroupTacksUseCase({
    required TacksRepository tacksRepository,
  }) : _tacksRepository = tacksRepository;

  @override
  Future<List<Tack>> execute(GroupTacksPayload params) async {
    return _tacksRepository.getGroupTacks(params);
  }
}
