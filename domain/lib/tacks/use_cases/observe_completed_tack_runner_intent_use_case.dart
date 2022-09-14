part of tacks;

class ObserveCompletedTackRunnerIntentUseCase
    extends StreamUseCase<WebSocketIntent<Tack>, NoParams> {
  final TacksRepository _tacksRepository;

  ObserveCompletedTackRunnerIntentUseCase({
    required TacksRepository tacksRepository,
  }) : _tacksRepository = tacksRepository;

  @override
  Stream<WebSocketIntent<Tack>> execute(NoParams params) {
    return _tacksRepository.completedTacksRunnerIntentStream;
  }
}
