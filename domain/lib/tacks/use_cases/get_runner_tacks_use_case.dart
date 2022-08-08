part of tacks;

class GetRunnerTacksUseCase extends FutureUseCase<List<RunnerTack>, NoParams> {
  final TacksRepository _tacksRepository;

  GetRunnerTacksUseCase({
    required TacksRepository tacksRepository,
  }) : _tacksRepository = tacksRepository;

  @override
  Future<List<RunnerTack>> execute(NoParams params) async {
    return _tacksRepository.getRunnerTacks();
  }
}