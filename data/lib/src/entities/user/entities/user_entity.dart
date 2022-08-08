part of user_entities;

@JsonSerializable()
@DoubleConverter()
class UserEntity extends JsonSerializable {
  final int id;
  @JsonKey(name: 'first_name')
  final String firstName;
  @JsonKey(name: 'last_name')
  final String lastName;
  @JsonKey(name: 'birthday')
  final String birthDate;
  @JsonKey(name: 'profile_picture')
  final String? profilePicture;
  @JsonKey(name: 'tacks_rating')
  final double tacksRating;
  @JsonKey(name: 'tacks_amount')
  final int tacksAmount;
  @JsonKey(name: 'phone_number')
  final String phoneNumber;
  @JsonKey(name: 'active_group')
  final int? activeGroup;

  const UserEntity({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.birthDate,
    required this.profilePicture,
    required this.tacksRating,
    required this.tacksAmount,
    required this.phoneNumber,
    required this.activeGroup,
  });

  factory UserEntity.fromJson(Map<String, dynamic> json) {
    return _$UserEntityFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() => _$UserEntityToJson(this);
}
