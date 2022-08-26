import 'package:core/core.dart';
import 'package:domain/domain.dart' as domain;

import '../entities/entities.dart';
import '../providers/api_provider.dart';
import '../providers/session_provider.dart';
import '../providers/shared_preferences_provider.dart';

class UserRepositoryImpl implements domain.UserRepository {
  final ApiProvider _apiProvider;
  final SessionProvider _sessionProvider;
  final SharedPreferencesProvider _sharedPreferencesProvider;

  late BehaviorSubject<domain.User> _userStreamController;

  UserRepositoryImpl({
    required ApiProvider apiProvider,
    required SessionProvider sessionProvider,
    required SharedPreferencesProvider sharedPreferencesProvider,
  })  : _apiProvider = apiProvider,
        _sessionProvider = sessionProvider,
        _sharedPreferencesProvider = sharedPreferencesProvider {
    final domain.User user = _sharedPreferencesProvider.getUser()!;
    _userStreamController = BehaviorSubject<domain.User>.seeded(user);
  }

  @override
  Stream<domain.User> get userStream => _userStreamController.stream;

  @override
  domain.User get currentUser => _userStreamController.stream.value;

  @override
  Future<domain.User> updateUserInfo(
    domain.UpdateUserInfoPayload payload,
  ) async {
    final domain.User user = await _apiProvider.updateUserInfo(
      request: UpdateUserInfoRequest(
        firstName: payload.firstName,
        lastName: payload.lastName,
        email: payload.email,
      ),
    );
    await _sharedPreferencesProvider.setUser(user);
    _userStreamController.add(user);

    return user;
  }

  @override
  Future<void> changePassword(
    domain.ChangePasswordPayload payload,
  ) async {
    final Session session =await  _apiProvider.changePassword(
      request: ChangePasswordRequest(
        oldPassword: payload.oldPassword,
        newPassword: payload.newPassword,
      ),
    );

    return _sessionProvider.updateSession(session);
  }
}
