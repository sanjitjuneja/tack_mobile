import 'package:data/src/entities/entities.dart';
import 'package:data/src/providers/api_provider_core.dart';

abstract class SessionApiProvider extends ApiProviderCore {
  SessionApiProvider({
    required super.baseUrl,
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
