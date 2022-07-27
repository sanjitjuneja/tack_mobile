part of tacks;

class RateTackUseCase extends FutureUseCase<void, RateTackPayload> {
  final TacksRepository _tacksRepository;

  RateTackUseCase({
    required TacksRepository tacksRepository,
  }) : _tacksRepository = tacksRepository;

  @override
  Future<void> execute(RateTackPayload params) async {
    return _tacksRepository.rateTack(params);
  }
}
