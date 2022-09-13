part of tacks;

class FetchRunnerTacksUseCase extends FutureUseCase<List<RunnerTack>,
    FetchRunnerTacksPayload> {
  final TacksRepository _tacksRepository;

  FetchRunnerTacksUseCase({
    required TacksRepository tacksRepository,
  }) : _tacksRepository = tacksRepository;

  @override
  Future<List<RunnerTack>> execute(
    FetchRunnerTacksPayload params,
  ) async {
    return _tacksRepository.fetchRunnerTacks(params);
  }
}
