part of global;

class ResetLastDeeplinkUseCase extends UseCase<void, NoParams> {
  final DeeplinkRepository _deeplinkRepository;

  ResetLastDeeplinkUseCase({
    required DeeplinkRepository deeplinkRepository,
  }) : _deeplinkRepository = deeplinkRepository;

  @override
  void execute(NoParams params) {
    return _deeplinkRepository.resetLastDeeplink();
  }
}
