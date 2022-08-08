part of tacks_entities;

@JsonSerializable()
class TackUserContactsEntity extends JsonSerializable {
  final String? phoneNumber;

  const TackUserContactsEntity({
    required this.phoneNumber,
  });

  factory TackUserContactsEntity.fromJson(Map<String, dynamic> json) {
    return _$TackUserContactsEntityFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() => _$TackUserContactsEntityToJson(this);
}
