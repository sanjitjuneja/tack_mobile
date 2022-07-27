part of user;

@JsonSerializable()
class UserEntity extends JsonSerializable {
  final int id;
  final double balance;
  @JsonKey(name: 'first_name')
  final String firstName;
  @JsonKey(name: 'last_name')
  final String lastName;
  @JsonKey(name: 'phone_number')
  final String phoneNumber;
  @JsonKey(name: 'active_group')
  final int activeGroup;

  const UserEntity({
    required this.id,
    required this.balance,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.activeGroup,
  });

  factory UserEntity.fromJson(Map<String, dynamic> json) {
    return _$UserEntityFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() => _$UserEntityToJson(this);
}
