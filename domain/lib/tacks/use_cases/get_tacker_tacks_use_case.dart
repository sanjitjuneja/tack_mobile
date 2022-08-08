part of tacks;

class GetTackerTacksUseCase extends FutureUseCase<List<Tack>, NoParams> {
  final TacksRepository _tacksRepository;

  GetTackerTacksUseCase({
    required TacksRepository tacksRepository,
  }) : _tacksRepository = tacksRepository;

  @override
  Future<List<Tack>> execute(NoParams params) async {
    return _tacksRepository.getTackerTacks();
  }
}
