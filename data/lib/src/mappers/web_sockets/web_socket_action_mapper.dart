part of mappers;

class WebSocketActionMapper
    implements Mapper<WebSocketActionEntity, domain.WebSocketAction> {
  const WebSocketActionMapper();

  @override
  domain.WebSocketAction fromEntity(WebSocketActionEntity entity) {
    switch (entity) {
      case WebSocketActionEntity.create:
        return domain.WebSocketAction.create;
      case WebSocketActionEntity.update:
        return domain.WebSocketAction.update;
      case WebSocketActionEntity.delete:
        return domain.WebSocketAction.delete;
      case WebSocketActionEntity.unknown:
        return domain.WebSocketAction.unknown;
    }
  }

  @override
  WebSocketActionEntity toEntity(domain.WebSocketAction item) {
    switch (item) {
      case domain.WebSocketAction.create:
        return WebSocketActionEntity.create;
      case domain.WebSocketAction.update:
        return WebSocketActionEntity.update;
      case domain.WebSocketAction.delete:
        return WebSocketActionEntity.delete;
      case domain.WebSocketAction.unknown:
        return WebSocketActionEntity.unknown;
    }
  }
}
