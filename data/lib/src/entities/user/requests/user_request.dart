part of user_entities;

@JsonSerializable(createFactory: false)
class UserRequest extends JsonSerializable {
  @JsonKey(name: 'first_name')
  final String firstName;
  @JsonKey(name: 'last_name')
  final String lastName;
  @JsonKey(name: 'phone_number')
  final String phoneNumber;
  final String password;

  const UserRequest({
    required this.firstName,
    required this.lastName,
    required this.password,
    required this.phoneNumber,
  });

  @override
  Map<String, dynamic> toJson() => _$UserRequestToJson(this);
}
