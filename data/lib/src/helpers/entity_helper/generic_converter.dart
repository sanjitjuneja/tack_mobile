import 'package:core/core.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../entities/entities.dart';

class GenericConverter<T> implements JsonConverter<T, Map<String, dynamic>> {
  const GenericConverter();

  @override
  T fromJson(Map<String, dynamic> json) {
    if (isTypeTypeOf<T, GroupDetailsEntity>()) {
      return GroupDetailsEntity.fromJson(json) as T;
    }

    if (isTypeTypeOf<T, GroupInvitationEntity>()) {
      return GroupInvitationEntity.fromJson(json) as T;
    }

    if (isTypeTypeOf<T, TackEntity>()) {
      return TackEntity.fromJson(json) as T;
    }

    if (isTypeTypeOf<T, GroupTackEntity>()) {
      return GroupTackEntity.fromJson(json) as T;
    }

    if (isTypeTypeOf<T, RunnerTackEntity>()) {
      return RunnerTackEntity.fromJson(json) as T;
    }

    if (isTypeTypeOf<T, OfferEntity>()) {
      return OfferEntity.fromJson(json) as T;
    }

    if (isTypeTypeOf<T, TackUserEntity>()) {
      return TackUserEntity.fromJson(json) as T;
    }

    if (isTypeTypeOf<T, UserEntity>()) {
      return UserEntity.fromJson(json) as T;
    }

    if (isTypeTypeOf<T, UserBankAccountEntity>()) {
      return UserBankAccountEntity.fromJson(json) as T;
    }

    throw Exception('Not supported Generic type.');
  }

  @override
  Map<String, dynamic> toJson(T object) {
    if (isTypeTypeOf<T, GroupDetailsEntity>()) {
      return (object as GroupDetailsEntity).toJson();
    }

    if (isTypeTypeOf<T, GroupInvitationEntity>()) {
      return (object as GroupInvitationEntity).toJson();
    }

    if (isTypeTypeOf<T, TackEntity>()) {
      return (object as TackEntity).toJson();
    }

    if (isTypeTypeOf<T, GroupTackEntity>()) {
      return (object as GroupTackEntity).toJson();
    }

    if (isTypeTypeOf<T, RunnerTackEntity>()) {
      return (object as RunnerTackEntity).toJson();
    }

    if (isTypeTypeOf<T, OfferEntity>()) {
      return (object as OfferEntity).toJson();
    }

    if (isTypeTypeOf<T, TackUserEntity>()) {
      return (object as TackUserEntity).toJson();
    }

    if (isTypeTypeOf<T, UserEntity>()) {
      return (object as UserEntity).toJson();
    }

    if (isTypeTypeOf<T, UserBankAccountEntity>()) {
      return (object as UserBankAccountEntity).toJson();
    }

    throw Exception('Not supported Generic type.');
  }
}
