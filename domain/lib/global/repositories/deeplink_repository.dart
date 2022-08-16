part of global;

abstract class DeeplinkRepository {
  Stream<DeeplinkIntent?> get deeplinkStream;

  DeeplinkIntent? get lastDeeplink;

  Future<void> configure();

  void resetLastDeeplink();

  Future<DeeplinkIntent?> getInitialLink();

  Future<Uri> createDeeplink(CreateDeeplinkPayload payload);
}
