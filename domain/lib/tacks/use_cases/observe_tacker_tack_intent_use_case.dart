part of tacks;

class ObserveTackerTackIntentUseCase
    extends StreamUseCase<WebSocketIntent<Tack>, NoParams> {
  final TacksRepository _tacksRepository;

  ObserveTackerTackIntentUseCase({
    required TacksRepository tacksRepository,
  }) : _tacksRepository = tacksRepository;

  @override
  Stream<WebSocketIntent<Tack>> execute(NoParams params) {
    return _tacksRepository.tackerTackIntentStream;
  }
}
