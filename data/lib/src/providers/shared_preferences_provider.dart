import 'dart:convert';

import 'package:core/core.dart';
import 'package:data/src/entities/entities.dart';
import 'package:data/src/mappers/mappers.dart';
import 'package:domain/domain.dart' as domain;

class SharedPreferencesKeys {
  static const String session = 'session';
  static const String isAuthorized = 'isAuthorized';
  static const String user = 'user';
}

class SharedPreferencesProvider {
  final MapperFactory mapper;

  late SharedPreferences _sharedPreferences;

  SharedPreferencesProvider({
    required this.mapper,
  });

  Future<void> initializeSharedPreferences() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<bool> setSession(Session session) async {
    return _sharedPreferences.setString(
      SharedPreferencesKeys.session,
      jsonEncode(session),
    );
  }

  Session? getSession() {
    final String? data = _sharedPreferences.getString(
      SharedPreferencesKeys.session,
    );

    return data != null
        ? Session.fromJson(jsonDecode(data) as Map<String, dynamic>)
        : null;
  }

  Future<bool> setAuthorized() async {
    return _sharedPreferences.setBool(SharedPreferencesKeys.isAuthorized, true);
  }

  bool isAuthorized() {
    return _sharedPreferences.getBool(
          SharedPreferencesKeys.isAuthorized,
        ) ??
        false;
  }

  Future<bool> setUser(domain.User user) async {
    final UserEntity userEntity = mapper.customerMapper.toEntity(user);

    return _sharedPreferences.setString(
      SharedPreferencesKeys.user,
      jsonEncode(userEntity),
    );
  }

  bool isAllSetForLogin() {
    final String? user = _sharedPreferences.getString(
      SharedPreferencesKeys.user,
    );
    return <Object?>[
      user,
    ].every((Object? element) => element != null);
  }

  Future<bool> clearAll() async {
    return _sharedPreferences.clear();
  }
}
