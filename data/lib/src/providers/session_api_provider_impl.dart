import 'session_api_provider.dart';
import '../query/api_query.dart';
import '../entities/entities.dart';

class SessionApiProviderImpl extends SessionApiProvider {
  SessionApiProviderImpl({
    required super.appConfig,
    required super.errorHandler,
  });

  @override
  Future<Session> startSession({
    required StartSessionRequest request,
  }) async {
    return post<Session>(
      ApiQuery(
        endpoint: BaseUrlConstants.startSessionPath,
        params: null,
        body: request.toJson(),
      ),
      parser: Session.fromJson,
    );
  }

  @override
  Future<Session> refreshSession({
    required RefreshSessionRequest request,
  }) async {
    return post<Session>(
      ApiQuery(
        endpoint: BaseUrlConstants.refreshSessionPath,
        params: null,
        body: request.toJson(),
      ),
      parser: Session.fromJson,
    );
  }

  @override
  Future<void> endSession({
    required EndSessionRequest request,
  }) async {
    return post<void>(
      ApiQuery(
        endpoint: BaseUrlConstants.endSessionPath,
        params: null,
        body: request.toJson(),
      ),
      parser: (_) {},
    );
  }
}
