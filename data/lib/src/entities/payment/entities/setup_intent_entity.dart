part of payment_entities;

@JsonSerializable(createToJson: false)
class SetupIntentEntity extends JsonSerializable {
  @JsonKey(name: 'client_secret')
  final String clientSecret;

  const SetupIntentEntity({
    required this.clientSecret,
  });

  factory SetupIntentEntity.fromJson(Map<String, dynamic> json) {
    return _$SetupIntentEntityFromJson(json);
  }
}
