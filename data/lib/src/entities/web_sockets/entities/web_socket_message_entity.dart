part of web_sockets_entities;

@JsonSerializable(createToJson: false)
class WebSocketMessage extends JsonSerializable {
  final WebSocketModelEntity model;
  final Map<String, dynamic> message;

  const WebSocketMessage({
    required this.model,
    required this.message,
  });

  factory WebSocketMessage.fromJson(Map<String, dynamic> json) {
    return _$WebSocketMessageFromJson(json);
  }
}
