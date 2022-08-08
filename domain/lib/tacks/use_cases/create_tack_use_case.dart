 part of tacks;

class CreateTackUseCase extends FutureUseCase<void, CreateTackPayload> {
  final TacksRepository _tacksRepository;

  CreateTackUseCase({
    required TacksRepository tacksRepository,
  }) : _tacksRepository = tacksRepository;

  @override
  Future<Tack> execute(CreateTackPayload params) async {
    return _tacksRepository.createTack(params);
  }
}
