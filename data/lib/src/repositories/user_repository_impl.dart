import 'dart:async';

import 'package:core/core.dart';
import 'package:domain/domain.dart' as domain;

import '../entities/entities.dart';
import '../providers/api_provider.dart';
import '../providers/session_provider.dart';
import '../providers/shared_preferences_provider.dart';
import '../providers/web_sockets_handlers.dart';
import '../providers/web_sockets_provider.dart';

class UserRepositoryImpl implements domain.UserRepository {
  final ApiProvider _apiProvider;
  final SessionProvider _sessionProvider;
  final SharedPreferencesProvider _sharedPreferencesProvider;
  final WebSocketsProvider _webSocketsProvider;

  late BehaviorSubject<domain.User> _userStreamController;
  late BehaviorSubject<domain.UserBankAccount> _balanceStreamController;

  late WebSocketStreamSubscription<domain.User>
      _webSocketUserIntentSubscription;
  late WebSocketStreamSubscription<domain.UserBankAccount>
      _webSocketBalanceIntentSubscription;

  UserRepositoryImpl({
    required ApiProvider apiProvider,
    required SessionProvider sessionProvider,
    required SharedPreferencesProvider sharedPreferencesProvider,
    required WebSocketsProvider webSocketsProvider,
  })  : _apiProvider = apiProvider,
        _sessionProvider = sessionProvider,
        _sharedPreferencesProvider = sharedPreferencesProvider,
        _webSocketsProvider = webSocketsProvider {
    final domain.User user = _sharedPreferencesProvider.getUser()!;

    _userStreamController = BehaviorSubject<domain.User>.seeded(user);
    _balanceStreamController = BehaviorSubject<domain.UserBankAccount>.seeded(
      const domain.UserBankAccount(id: -1, usdBalance: 0),
    );

    _webSocketUserIntentSubscription = _webSocketsProvider.userStream.listen(
      (domain.WebSocketIntent<domain.User> intent) {
        if (intent.action == domain.WebSocketAction.update) {
          _onUserUpdated(intent.object!);
        }
      },
    );
    _webSocketBalanceIntentSubscription =
        _webSocketsProvider.userBalanceStream.listen(
      (domain.WebSocketIntent<domain.UserBankAccount> intent) {
        if (intent.action == domain.WebSocketAction.update) {
          _balanceStreamController.add(intent.object!);
        }
      },
    );
  }

  @override
  Stream<domain.User> get userStream => _userStreamController.stream;

  @override
  domain.User get currentUser => _userStreamController.stream.value;

  @override
  Stream<domain.UserBankAccount> get balanceStream =>
      _balanceStreamController.stream;

  @override
  domain.UserBankAccount get balance => _balanceStreamController.stream.value;

  @override
  Future<void> initialLoad() async {
    // Handle of network error, no any action needed on error.
    try {
      await fetchUser();
      await fetchUserBalance(const domain.FetchUserBalancePayload());
    } catch (_) {}
  }

  @override
  Future<domain.User> fetchUser() async {
    final domain.User user = await _apiProvider.getUser();
    await _onUserUpdated(user);

    return user;
  }

  @override
  Future<domain.UserBankAccount> fetchUserBalance(
    domain.FetchUserBalancePayload payload,
  ) async {
    final domain.UserBankAccount bankAccount =
        await _apiProvider.fetchUserBalance(
      request: const FetchUserBalanceRequest(),
    );
    _balanceStreamController.add(bankAccount);

    return bankAccount;
  }

  @override
  Future<domain.UserContacts> fetchUserContacts(
    domain.FetchUserContactsPayload payload,
  ) async {
    return _apiProvider.fetchUserContacts(
      request: FetchUserContactsRequest(
        tackId: payload.tackId,
      ),
    );
  }

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
    await _onUserUpdated(user);

    return user;
  }

  @override
  Future<void> changePassword(
    domain.ChangePasswordPayload payload,
  ) async {
    final Session session = await _apiProvider.changePassword(
      request: ChangePasswordRequest(
        oldPassword: payload.oldPassword,
        newPassword: payload.newPassword,
      ),
    );

    return _sessionProvider.updateSession(session);
  }

  Future<void> _onUserUpdated(domain.User user) async {
    await _sharedPreferencesProvider.setUser(user);
    await _sharedPreferencesProvider.setActiveGroupId(user.activeGroup);

    _userStreamController.add(user);
    print(user);
    print('UPDATE');
  }

  @override
  void dispose() {
    _userStreamController.close();
    _balanceStreamController.close();

    _webSocketUserIntentSubscription.cancel();
    _webSocketBalanceIntentSubscription.cancel();
  }
}
