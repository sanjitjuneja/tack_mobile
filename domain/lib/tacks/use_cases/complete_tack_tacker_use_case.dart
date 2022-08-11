part of tacks;

class CompleteTackTackerUseCase
    extends FutureUseCase<void, CompleteTackPayload> {
  final TacksRepository _tacksRepository;

  CompleteTackTackerUseCase({
    required TacksRepository tacksRepository,
  }) : _tacksRepository = tacksRepository;

  @override
  Future<void> execute(CompleteTackPayload params) async {
    return _tacksRepository.completeTackByTacker(params);
  }
}
