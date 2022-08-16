part of global;

class CreateDeeplinkUseCase extends FutureUseCase<Uri, CreateDeeplinkPayload> {
  final DeeplinkRepository _deeplinkRepository;

  CreateDeeplinkUseCase({
    required DeeplinkRepository deeplinkRepository,
  }) : _deeplinkRepository = deeplinkRepository;

  @override
  Future<Uri> execute(CreateDeeplinkPayload params) {
    return _deeplinkRepository.createDeeplink(params);
  }
}
