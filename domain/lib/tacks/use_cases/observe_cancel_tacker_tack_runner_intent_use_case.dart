part of tacks;

class ObserveCancelTackerTackRunnerIntentUseCase
    extends StreamUseCase<WebSocketIntent<Tack>, NoParams> {
  final TacksRepository _tacksRepository;

  ObserveCancelTackerTackRunnerIntentUseCase({
    required TacksRepository tacksRepository,
  }) : _tacksRepository = tacksRepository;

  @override
  Stream<WebSocketIntent<Tack>> execute(NoParams params) {
    return _tacksRepository.cancelTackerTackRunnerStream;
  }
}
