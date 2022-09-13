part of tacks;

class FetchHasRunningTackUseCase
    extends FutureUseCase<bool, FetchHasRunningTackPayload> {
  final TacksRepository _tacksRepository;

  FetchHasRunningTackUseCase({
    required TacksRepository tacksRepository,
  }) : _tacksRepository = tacksRepository;

  @override
  Future<bool> execute(FetchHasRunningTackPayload params) async {
    return _tacksRepository.fetchHasRunningTack(params);
  }
}
