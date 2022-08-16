part of global;

class ObserveDeeplinkUseCase extends StreamUseCase<DeeplinkIntent?, NoParams> {
  final DeeplinkRepository _deeplinkRepository;

  ObserveDeeplinkUseCase({
    required DeeplinkRepository deeplinkRepository,
  }) : _deeplinkRepository = deeplinkRepository;

  @override
  Stream<DeeplinkIntent?> execute(NoParams params) {
    return _deeplinkRepository.deeplinkStream;
  }
}
