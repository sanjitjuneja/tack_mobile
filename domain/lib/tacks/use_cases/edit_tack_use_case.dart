part of tacks;

class EditTackUseCase extends FutureUseCase<Tack, UpdateTackPayload> {
  final TacksRepository _tacksRepository;

  EditTackUseCase({
    required TacksRepository tacksRepository,
  }) : _tacksRepository = tacksRepository;

  @override
  Future<Tack> execute(UpdateTackPayload params) async {
    return _tacksRepository.updateTack(params);
  }
}
