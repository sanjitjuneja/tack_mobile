part of mappers;

class WebSocketIntentMapper<S, C extends Object>
    extends Mapper<WebSocketIntentEntity<S>, domain.WebSocketIntent<C>> {
  final Mapper<S, C> mapper;
  final WebSocketActionMapper actionMapper;

  const WebSocketIntentMapper({
    required this.mapper,
    required this.actionMapper,
  });

  @override
  domain.WebSocketIntent<C> fromEntity(WebSocketIntentEntity<S> entity) {
    return domain.WebSocketIntent<C>(
      action: actionMapper.fromEntity(entity.action),
      objectId: entity.objectId,
      object:
          entity.object != null ? mapper.fromEntity(entity.object as S) : null,
    );
  }

  @override
  WebSocketIntentEntity<S> toEntity(domain.WebSocketIntent<C> item) {
    return WebSocketIntentEntity<S>(
      action: actionMapper.toEntity(item.action),
      objectId: item.objectId,
      object: item.object != null ? mapper.toEntity(item.object!) : null,
    );
  }
}
