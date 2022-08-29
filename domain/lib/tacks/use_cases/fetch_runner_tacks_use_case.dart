part of tacks;

class FetchRunnerTacksUseCase extends FutureUseCase<PaginationModel<RunnerTack>,
    FetchRunnerTacksPayload> {
  final TacksRepository _tacksRepository;

  FetchRunnerTacksUseCase({
    required TacksRepository tacksRepository,
  }) : _tacksRepository = tacksRepository;

  @override
  Future<PaginationModel<RunnerTack>> execute(
    FetchRunnerTacksPayload params,
  ) async {
    return _tacksRepository.fetchRunnerTacks(params);
  }
}
