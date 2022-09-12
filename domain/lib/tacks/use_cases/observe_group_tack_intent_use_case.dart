part of tacks;

class ObserveGroupTackIntentUseCase
    extends StreamUseCase<WebSocketIntent<GroupTack>, NoParams> {
  final TacksRepository _tacksRepository;

  ObserveGroupTackIntentUseCase({
    required TacksRepository tacksRepository,
  }) : _tacksRepository = tacksRepository;

  @override
  Stream<WebSocketIntent<GroupTack>> execute(NoParams params) {
    return _tacksRepository.groupTackIntentStream;
  }
}
