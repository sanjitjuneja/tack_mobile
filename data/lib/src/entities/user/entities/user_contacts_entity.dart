part of user_entities;

@JsonSerializable()
class UserContactsEntity extends JsonSerializable {
  @JsonKey(name: 'phone_number')
  final String phoneNumber;
  final String email;

  const UserContactsEntity({
    required this.phoneNumber,
    required this.email,
  });

  factory UserContactsEntity.fromJson(Map<String, dynamic> json) {
    return _$UserContactsEntityFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() => _$UserContactsEntityToJson(this);
}
