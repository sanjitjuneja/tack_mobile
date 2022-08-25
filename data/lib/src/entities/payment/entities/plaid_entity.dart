part of payment_entities;

@JsonSerializable(createToJson: false)
class PlaidEntity extends JsonSerializable {
  @JsonKey(name: 'link_token')
  final String linkToken;

  const PlaidEntity({
    required this.linkToken,
  });

  factory PlaidEntity.fromJson(Map<String, dynamic> json) {
    return _$PlaidEntityFromJson(json);
  }
}
