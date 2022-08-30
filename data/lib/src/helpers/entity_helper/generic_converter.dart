import 'package:json_annotation/json_annotation.dart';

import '../../entities/entities.dart';

class GenericConverter<T> implements JsonConverter<T, Object> {
  const GenericConverter();

  @override
  T fromJson(Object json) {
    if (json is Map<String, dynamic> && T == GroupDetailsEntity) {
      return GroupDetailsEntity.fromJson(json) as T;
    }

    if (json is Map<String, dynamic> && T == GroupInvitationEntity) {
      return GroupInvitationEntity.fromJson(json) as T;
    }

    if (json is Map<String, dynamic> && T == TackEntity) {
      return TackEntity.fromJson(json) as T;
    }

    if (json is Map<String, dynamic> && T == GroupTackEntity) {
      return GroupTackEntity.fromJson(json) as T;
    }

    if (json is Map<String, dynamic> && T == RunnerTackEntity) {
      return RunnerTackEntity.fromJson(json) as T;
    }

    if (json is Map<String, dynamic> && T == OfferEntity) {
      return OfferEntity.fromJson(json) as T;
    }

    if (json is Map<String, dynamic> && T == TackUserEntity) {
      return TackUserEntity.fromJson(json) as T;
    }

    return json as T;
  }

  @override
  Object toJson(T object) {
    if (T is GroupDetailsEntity) {
      return (object as GroupDetailsEntity).toJson();
    }

    if (T is GroupInvitationEntity) {
      return (object as GroupInvitationEntity).toJson();
    }

    if (T is TackEntity) {
      return (object as TackEntity).toJson();
    }

    if (T is GroupTackEntity) {
      return (object as GroupTackEntity).toJson();
    }

    if (T is RunnerTackEntity) {
      return (object as RunnerTackEntity).toJson();
    }

    if (T is OfferEntity) {
      return (object as OfferEntity).toJson();
    }

    if (T is TackUserEntity) {
      return (object as TackUserEntity).toJson();
    }

    return object as Object;
  }
}
