part of user;

@JsonSerializable()
class MessageEntity extends JsonSerializable {
  final String message;

  const MessageEntity({
    required this.message,
  });

  factory MessageEntity.fromJson(Map<String, dynamic> json) {
    return _$MessageEntityFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() => _$MessageEntityToJson(this);
}
