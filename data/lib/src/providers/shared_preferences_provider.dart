import 'dart:convert';

import 'package:core/core.dart';
import 'package:data/src/entities/entities.dart';
import 'package:data/src/mappers/mappers.dart';
import 'package:domain/domain.dart' as domain;

class SharedPreferencesKeys {
  static const String session = 'session';
  static const String isAuthorized = 'isAuthorized';
  static const String user = 'user';
  static const String activeGroupId = 'activeGroupId';
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

    if (data == null) return null;

    return Session.fromJson(jsonDecode(data));
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

  domain.User? getUser() {
    final String? data = _sharedPreferences.getString(
      SharedPreferencesKeys.user,
    );

    if (data == null) return null;

    final UserEntity userEntity = UserEntity.fromJson(jsonDecode(data));

    return mapper.customerMapper.fromEntity(userEntity);
  }

  Future<bool> setActiveGroupId(int? groupId) async {
    if (groupId == null) return true;

    return _sharedPreferences.setInt(
      SharedPreferencesKeys.activeGroupId,
      groupId,
    );
  }

  int? getActiveGroupId() {
    return _sharedPreferences.getInt(SharedPreferencesKeys.activeGroupId);
  }

  bool isAllSetForLogin() {
    final domain.User? user = getUser();

    return <Object?>[
      user,
    ].every((Object? element) => element != null);
  }

  Future<bool> clearAll() async {
    return _sharedPreferences.clear();
  }

  Future<void> clearSessionInfo() async {
    await _sharedPreferences.remove(SharedPreferencesKeys.user);
    await _sharedPreferences.remove(SharedPreferencesKeys.activeGroupId);
    await _sharedPreferences.remove(SharedPreferencesKeys.session);
    await _sharedPreferences.setBool(SharedPreferencesKeys.isAuthorized, false);
  }
}
