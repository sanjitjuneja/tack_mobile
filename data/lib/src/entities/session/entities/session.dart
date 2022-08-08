part of session_entity;

@JsonSerializable()
class Session extends JsonSerializable {
  @JsonKey(name: 'access')
  final String accessToken;
  @JsonKey(name: 'refresh')
  final String refreshToken;

  const Session({
    required this.accessToken,
    required this.refreshToken,
  });

  factory Session.fromJson(Map<String, dynamic> json) {
    return _$SessionFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() => _$SessionToJson(this);
}
