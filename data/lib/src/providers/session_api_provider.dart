import 'api_provider_core.dart';
import '../entities/entities.dart';

abstract class SessionApiProvider extends ApiProviderCore {
  SessionApiProvider({
    required super.appConfig,
    required super.errorHandler,
  });

  Future<Session> startSession({
    required StartSessionRequest request,
  });

  Future<Session> refreshSession({
    required RefreshSessionRequest request,
  });

  Future<void> endSession({
    required EndSessionRequest request,
  });
}
