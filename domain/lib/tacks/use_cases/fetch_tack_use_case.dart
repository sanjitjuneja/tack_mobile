part of tacks;

class FetchTackUseCase extends FutureUseCase<Tack, FetchTackPayload> {
  final TacksRepository _tacksRepository;

  FetchTackUseCase({
    required TacksRepository tacksRepository,
  }) : _tacksRepository = tacksRepository;

  @override
  Future<Tack> execute(FetchTackPayload params) async {
    return _tacksRepository.fetchTack(params);
  }
}
