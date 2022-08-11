part of tacks;

class CancelTackRunnerUseCase extends FutureUseCase<void, CancelTackPayload> {
  final TacksRepository _tacksRepository;

  CancelTackRunnerUseCase({
    required TacksRepository tacksRepository,
  }) : _tacksRepository = tacksRepository;

  @override
  Future<void> execute(CancelTackPayload params) async {
    return _tacksRepository.cancelTackByRunner(params);
  }
}
