part of tacks;

class StartTackRunnerUseCase extends FutureUseCase<void, StartTackPayload> {
  final TacksRepository _tacksRepository;

  StartTackRunnerUseCase({
    required TacksRepository tacksRepository,
  }) : _tacksRepository = tacksRepository;

  @override
  Future<void> execute(StartTackPayload params) async {
    return _tacksRepository.startTackByRunner(params);
  }
}
