import 'dart:convert';

import 'package:core/core.dart';
import 'package:data/src/entities/entities.dart';
import 'package:data/src/mappers/mappers.dart';
import 'package:domain/domain.dart' as domain;

class SharedPreferencesKeys {
  static const String session = 'session';
  static const String isAuthorized = 'isAuthorized';
  static const String user = 'user';
  static const String activeGroup = 'activeGroup';
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
    final UserEntity userEntity = mapper.userMapper.toEntity(user);

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

    return mapper.userMapper.fromEntity(userEntity);
  }

  Future<bool> setActiveGroup(domain.Group? group) async {
    if (group == null) {
      return _sharedPreferences.remove(SharedPreferencesKeys.activeGroup);
    } else {
      final GroupEntity groupEntity = mapper.groupMapper.toEntity(group);

      return _sharedPreferences.setString(
        SharedPreferencesKeys.activeGroup,
        jsonEncode(groupEntity),
      );
    }
  }

  domain.Group? getActiveGroup() {
    final String? data = _sharedPreferences.getString(
      SharedPreferencesKeys.activeGroup,
    );

    if (data == null) return null;

    final GroupEntity groupEntity = GroupEntity.fromJson(jsonDecode(data));

    return mapper.groupMapper.fromEntity(groupEntity);
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
    await _sharedPreferences.remove(SharedPreferencesKeys.activeGroup);
    await _sharedPreferences.remove(SharedPreferencesKeys.session);
    await _sharedPreferences.setBool(SharedPreferencesKeys.isAuthorized, false);
  }
}
