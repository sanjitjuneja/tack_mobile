part of tacks;

class CancelTackTackerUseCase extends FutureUseCase<void, CancelTackPayload> {
  final TacksRepository _tacksRepository;

  CancelTackTackerUseCase({
    required TacksRepository tacksRepository,
  }) : _tacksRepository = tacksRepository;

  @override
  Future<void> execute(CancelTackPayload params) async {
    return _tacksRepository.cancelTackByTacker(params);
  }
}
