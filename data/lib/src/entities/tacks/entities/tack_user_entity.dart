part of tacks_entities;

@JsonSerializable()
@DoubleConverter()
class TackUserEntity extends JsonSerializable {
  final int id;
  @JsonKey(name: 'first_name')
  final String firstName;
  @JsonKey(name: 'last_name')
  final String lastName;
  @JsonKey(name: 'tacks_rating')
  final double tacksRating;
  @JsonKey(name: 'tacks_amount')
  final int tacksAmount;

  const TackUserEntity({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.tacksRating,
    required this.tacksAmount,
  });

  factory TackUserEntity.fromJson(Map<String, dynamic> json) {
    return _$TackUserEntityFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() => _$TackUserEntityToJson(this);
}
