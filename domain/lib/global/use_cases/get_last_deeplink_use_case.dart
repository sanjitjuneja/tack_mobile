part of global;

class GetLastDeeplinkUseCase extends UseCase<DeeplinkIntent?, NoParams> {
  final DeeplinkRepository _deeplinkRepository;

  GetLastDeeplinkUseCase({
    required DeeplinkRepository deeplinkRepository,
  }) : _deeplinkRepository = deeplinkRepository;

  @override
  DeeplinkIntent? execute(NoParams params) {
    return _deeplinkRepository.lastDeeplink;
  }
}
