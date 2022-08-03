part of mappers;

class MessageMapper implements Mapper<MessageEntity, domain.Message> {
  @override
  domain.Message fromEntity(MessageEntity entity) {
    return domain.Message(
      message: entity.message,
    );
  }

  @override
  MessageEntity toEntity(domain.Message item) {
    return MessageEntity(
      message: item.message,
    );
  }
}
