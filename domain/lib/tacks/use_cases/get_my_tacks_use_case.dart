part of tacks;

class GetMyTacksUseCase extends FutureUseCase<List<Tack>, void> {
  final TacksRepository _tacksRepository;

  GetMyTacksUseCase({
    required TacksRepository tacksRepository,
  }) : _tacksRepository = tacksRepository;

  @override
  Future<List<Tack>> execute(void params) async {
    return _tacksRepository.getMyTacks();
  }
}
