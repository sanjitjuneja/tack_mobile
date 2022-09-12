part of tacks;

class ObserveRunnerTackIntentUseCase
    extends StreamUseCase<WebSocketIntent<RunnerTack>, NoParams> {
  final TacksRepository _tacksRepository;

  ObserveRunnerTackIntentUseCase({
    required TacksRepository tacksRepository,
  }) : _tacksRepository = tacksRepository;

  @override
  Stream<WebSocketIntent<RunnerTack>> execute(NoParams params) {
    return _tacksRepository.runnerTackIntentStream;
  }
}
