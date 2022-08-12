import 'package:data/src/entities/entities.dart';
import 'package:json_annotation/json_annotation.dart';

class GenericConverter<T> implements JsonConverter<T, Object> {
  const GenericConverter();

  @override
  T fromJson(Object json) {
    if (json is Map<String, dynamic> && T == TackEntity) {
      return TackEntity.fromJson(json) as T;
    }

    if (json is Map<String, dynamic> && T == OfferEntity) {
      return OfferEntity.fromJson(json) as T;
    }

    return json as T;
  }

  @override
  Object toJson(T object) {
    if (T is TackEntity) {
      return (object as TackEntity).toJson();
    }

    if (T is OfferEntity) {
      return (object as OfferEntity).toJson();
    }

    return object as Object;
  }
}
