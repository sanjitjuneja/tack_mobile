part of tacks;

class CompleteTackRunnerUseCase
    extends FutureUseCase<void, CompleteTackPayload> {
  final TacksRepository _tacksRepository;

  CompleteTackRunnerUseCase({
    required TacksRepository tacksRepository,
  }) : _tacksRepository = tacksRepository;

  @override
  Future<void> execute(CompleteTackPayload params) async {
    return _tacksRepository.completeTackByRunner(params);
  }
}
