part of tacks_entities;

@JsonSerializable()
class HasRunningTackEntity extends JsonSerializable {
  @JsonKey(name: 'is_ongoing_runner_tack')
  final bool hasRunningTack;

  const HasRunningTackEntity({
    required this.hasRunningTack,
  });

  factory HasRunningTackEntity.fromJson(Map<String, dynamic> json) {
    return _$HasRunningTackEntityFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() => _$HasRunningTackEntityToJson(this);
}
