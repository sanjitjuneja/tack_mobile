part of web_sockets_entities;

@JsonSerializable(createToJson: false)
@GenericConverter()
class WebSocketIntentEntity<T> extends JsonSerializable {
  @JsonKey(unknownEnumValue: WebSocketActionEntity.unknown)
  final WebSocketActionEntity action;
  @JsonKey(name: 'id')
  final int objectId;
  final T? object;

  const WebSocketIntentEntity({
    required this.action,
    required this.objectId,
    required this.object,
  });

  factory WebSocketIntentEntity.fromJson(Map<String, dynamic> json) {
    return _$WebSocketIntentEntityFromJson(json);
  }
}
