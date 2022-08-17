import 'package:core/core.dart';
import 'package:data/src/providers/api_provider.dart';
import 'package:data/src/providers/shared_preferences_provider.dart';
import 'package:domain/domain.dart' as domain;

class UserRepositoryImpl implements domain.UserRepository {
  final ApiProvider _apiProvider;
  final SharedPreferencesProvider _sharedPreferencesProvider;

  late BehaviorSubject<domain.User> _userStreamController;

  UserRepositoryImpl({
    required ApiProvider apiProvider,
    required SharedPreferencesProvider sharedPreferencesProvider,
  })  : _apiProvider = apiProvider,
        _sharedPreferencesProvider = sharedPreferencesProvider {
    final domain.User user = _sharedPreferencesProvider.getUser()!;
    _userStreamController = BehaviorSubject<domain.User>.seeded(user);
  }

  @override
  Stream<domain.User> get userStream => _userStreamController.stream;

  @override
  domain.User get currentUser => _userStreamController.stream.value;
}
