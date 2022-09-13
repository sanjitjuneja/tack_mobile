part of web_sockets_entities;

enum WebSocketActionEntity {
  @JsonValue('create')
  create,
  @JsonValue('update')
  update,
  @JsonValue('delete')
  delete,
}
