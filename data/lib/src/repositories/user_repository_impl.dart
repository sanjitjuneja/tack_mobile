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
  late BehaviorSubject<domain.UserBankAccount> _balanceStreamController;

  UserRepositoryImpl({
    required ApiProvider apiProvider,
    required SessionProvider sessionProvider,
    required SharedPreferencesProvider sharedPreferencesProvider,
  })  : _apiProvider = apiProvider,
        _sessionProvider = sessionProvider,
        _sharedPreferencesProvider = sharedPreferencesProvider {
    final domain.User user = _sharedPreferencesProvider.getUser()!;
    _userStreamController = BehaviorSubject<domain.User>.seeded(user);
    _balanceStreamController = BehaviorSubject<domain.UserBankAccount>.seeded(
      const domain.UserBankAccount(usdBalance: 0),
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
      await fetchUserBalance(const domain.FetchUserBalancePayload());
    } catch (_) {}
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
    await _sharedPreferencesProvider.setUser(user);
    _userStreamController.add(user);

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
}
