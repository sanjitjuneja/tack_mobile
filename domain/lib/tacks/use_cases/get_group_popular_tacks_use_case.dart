part of tacks;

class GetGroupPopularTacksUseCase
    extends FutureUseCase<List<TemplateTack>, GroupPopularTacksPayload> {
  final TacksRepository _tacksRepository;

  GetGroupPopularTacksUseCase({
    required TacksRepository tacksRepository,
  }) : _tacksRepository = tacksRepository;

  @override
  Future<List<TemplateTack>> execute(GroupPopularTacksPayload params) async {
    return _tacksRepository.groupPopularTacks(params);
  }
}
