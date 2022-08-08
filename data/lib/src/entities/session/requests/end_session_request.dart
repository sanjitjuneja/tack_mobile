part of session_entity;

@JsonSerializable(createFactory: false)
class EndSessionRequest extends JsonSerializable {
  @JsonKey(name: 'access')
  final String accessToken;
  @JsonKey(name: 'refresh')
  final String refreshToken;

  EndSessionRequest({
    required Session session,
  })  : accessToken = session.accessToken,
        refreshToken = session.refreshToken;

  @override
  Map<String, dynamic> toJson() => _$EndSessionRequestToJson(this);
}
