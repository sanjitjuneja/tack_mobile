part of user_entities;

@JsonSerializable(
  createFactory: false,
  includeIfNull: false,
)
class UpdateUserInfoRequest extends JsonSerializable {
  @JsonKey(name: 'first_name')
  final String? firstName;
  @JsonKey(name: 'last_name')
  final String? lastName;
  final String? email;

  const UpdateUserInfoRequest({
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  @override
  Map<String, dynamic> toJson() => _$UpdateUserInfoRequestToJson(this);
}
