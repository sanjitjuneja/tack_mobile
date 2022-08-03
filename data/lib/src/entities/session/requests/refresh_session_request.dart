part of session_entity;

@JsonSerializable(createFactory: false)
class RefreshSessionRequest extends JsonSerializable {
  @JsonKey(name: 'access')
  final String accessToken;
  @JsonKey(name: 'refresh')
  final String refreshToken;

  RefreshSessionRequest({
    required Session session,
  })  : accessToken = session.accessToken,
        refreshToken = session.refreshToken;

  @override
  Map<String, dynamic> toJson() => _$RefreshSessionRequestToJson(this);
}
